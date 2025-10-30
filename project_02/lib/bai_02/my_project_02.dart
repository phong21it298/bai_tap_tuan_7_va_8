import 'package:flutter/material.dart';

class MyProject02 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyProject02State();
}

class _MyProject02State extends State<MyProject02> {

  final TextEditingController _controller = TextEditingController();
  final List<String> _tasks = [];

  void _addTask() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _tasks.add(_controller.text);
      _controller.clear();
    });
  }

  void _removeTask(int index) {
    setState(() => _tasks.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Enter task',
                    ),
                  ),
                ),
                IconButton(onPressed: _addTask, icon: const Icon(Icons.add))
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, i) => ListTile(
                title: Text(_tasks[i]),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _removeTask(i),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
