import 'package:flutter/material.dart';
import 'package:notepad/db/notes_db.dart';
import 'package:notepad/models/note.dart';

class NoteViewModel extends ChangeNotifier {

  Future<List<Note>> readAllNotes() async => await NoteDatabase().readAllNotes();
  Future<Note> readNote(int id) async => await NoteDatabase().readNote(id);

  void addNoteToDB(Note note) async {
    await NoteDatabase().addNoteToDB(note);
    notifyListeners();
  }

  void updateNote(Note note) async {
    await NoteDatabase().updateNote(note);
    notifyListeners();
  }

  void deleteNote(int id) async {
    await NoteDatabase().deleteNote(id);
    notifyListeners();
  } 

}
