import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'note_provider.dart';

class MyProject05 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyProject05State();
}

class _MyProject05State extends State<MyProject05> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Notes')),
        body: Consumer<NoteProvider>(
          builder: (context, provider, _) => ListView.builder(
            itemCount: provider.notes.length,
            itemBuilder: (context, i) => ListTile(
              title: Text(provider.notes[i]),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => provider.remove(i),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                final controller = TextEditingController();
                return AlertDialog(
                  title: const Text('Add Note'),
                  content: TextField(controller: controller),
                  actions: [
                    TextButton(
                      onPressed: () {
                        context.read<NoteProvider>().add(controller.text);
                        Navigator.pop(context);
                      },
                      child: const Text('Save'),
                    )
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
