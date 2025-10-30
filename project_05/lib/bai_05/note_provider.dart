import 'package:flutter/material.dart';

class NoteProvider extends ChangeNotifier {
  final List<String> _notes = [];
  List<String> get notes => _notes;

  void add(String note) {
    _notes.add(note);
    notifyListeners();
  }

  void remove(int index) {
    _notes.removeAt(index);
    notifyListeners();
  }
}
