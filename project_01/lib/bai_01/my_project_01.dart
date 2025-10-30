import 'package:flutter/material.dart';

class MyProject01 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyProject01State();
}

class _MyProject01State extends State<MyProject01> {

  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: _darkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'),
          actions: [
            Switch(
              value: _darkMode,
              onChanged: (v) => setState(() => _darkMode = v),
            )
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
            const SizedBox(height: 20),
            const Text('Trần Thanh Phong', style: TextStyle(fontSize: 24)),
            const Text('Mobile Developer', style: TextStyle(fontSize: 18)),
            const Divider(),
            Card(
              child: ListTile(
                leading: const Icon(Icons.phone),
                title: const Text('0123 456 789'),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.email),
                title: const Text('ptt.xxit@vku.udn.vn'),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Kỹ năng:', style: TextStyle(fontSize: 20)),
            const ListTile(title: Text('• Flutter & Dart')),
            const ListTile(title: Text('• REST API')),
            const ListTile(title: Text('• Firebase')),
          ],
        ),
      ),
    );
  }
}
