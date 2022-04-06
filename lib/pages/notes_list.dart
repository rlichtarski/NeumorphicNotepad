import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notepad/models/note.dart';
import 'package:notepad/db/notes_db.dart';
import 'package:notepad/pages/show_note.dart';
import 'package:notepad/widgets/note_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NotesListPage extends StatefulWidget {
  const NotesListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<NotesListPage> createState() => NotesListPageState();
}

class NotesListPageState extends State<NotesListPage> {
  late List<Note> notesList;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() {
      isLoading = true;
    });

    notesList = await NoteDatabase.instance.readAllNotes();

    setState(() {
      isLoading = false;
    });
  }

  Future deleteNote(int id) async {
    await NoteDatabase.instance.delete(id);
    refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
            fontSize: 20.0
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
        child: isLoading ? const SpinKitCircle(color: Colors.white, size: 50.0,) : notesList.isEmpty ? const Center(
          child: Text(
            'EMPTY NOTES LIST',
            style: TextStyle(
              letterSpacing: 1.5,
              fontSize: 20.0,
              color: Colors.white
            ),
          )
        ) : GridView.builder(
          itemCount: notesList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (BuildContext context, int index) => 
          GestureDetector(
            child: NoteListView(note: notesList[index]),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowNotePage(title: 'Note', noteId: notesList[index].id!)
                ) 
              );
              refreshNotes();
            },
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.deepPurpleAccent,
                  content: const Text(
                    'Do you want to delete this note?',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'CANCEL',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      )
                    ),
                    TextButton(
                      onPressed: () async {
                        deleteNote(notesList[index].id!);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'DELETE',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      )
                    ),
                  ],
                )
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        color: Colors.deepPurpleAccent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Neumorphic(
                style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  lightSource: LightSource.topLeft,
                  intensity: 0.3,
                  surfaceIntensity: 0.1,
                  color: const Color(0xff7344F8),
                  boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.add,
                    size: 50,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await Navigator.pushNamed(context, '/add_note');
                    refreshNotes();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}