import 'package:flutter/material.dart';

class MyProject04 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyProject04State();
}

class _MyProject04State extends State<MyProject04> {

  @override
  Widget build(BuildContext context) {

    final messages = [
      {'text': 'Hi!', 'isMe': true},
      {'text': 'Hello! How are you?', 'isMe': false},
      {'text': 'I’m fine, thanks!', 'isMe': true},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Chat UI')),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: messages.length,
        itemBuilder: (context, i) {
          final msg = messages[i];
          final isMe = msg['isMe'] as bool;
          final text = msg['text'] as String;

          return Align(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isMe ? Colors.blue[100] : Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(text),
            ),
          );
        },
      ),
    );
  }
}
