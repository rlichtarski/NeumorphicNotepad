import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notepad/pages/add_note.dart';
import 'package:notepad/pages/notes_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const NotesListPage(title: 'Notepad'),
        '/add_note': (context) => const AddNotePage(title: 'Add a note'),
      },
    );
  }
}