import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'notification_service.dart';

class MyProject09 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyProject09State();
}

class _MyProject09State extends State<MyProject09> {

  final TextEditingController _titleController = TextEditingController();
  DateTime? _selectedDateTime;

  void _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(minutes: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time == null) return;

    setState(() {
      _selectedDateTime =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);
    });
  }

  void _scheduleReminder() {
    if (_titleController.text.isEmpty || _selectedDateTime == null) return;

    NotificationService().scheduleNotification(
        DateTime
            .now()
            .millisecondsSinceEpoch ~/ 1000,
        _titleController.text,
        _selectedDateTime!);

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Reminder Scheduled')));
    _titleController.clear();
    setState(() {
      _selectedDateTime = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dateString = _selectedDateTime == null
        ? 'Select Date & Time'
        : DateFormat('yyyy-MM-dd HH:mm').format(_selectedDateTime!);

    return Scaffold(
      appBar: AppBar(title: const Text('Reminder App')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Reminder Title'),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: Text(dateString)),
                TextButton(
                    onPressed: _pickDateTime,
                    child: const Text('Pick Date & Time')),
              ],
            ),
            const SizedBox(height: 32),
            ElevatedButton(
                onPressed: _scheduleReminder,
                child: const Text('Schedule Reminder')),
          ],
        ),
      ),
    );
  }
}
