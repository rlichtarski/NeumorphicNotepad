import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notepad/db/notes_db.dart';
import 'package:notepad/models/note.dart';
import 'package:notepad/pages/edit_note.dart';

class ShowNotePage extends StatefulWidget {
  const ShowNotePage({ Key? key, required this.title, required this.noteId }) : super(key: key);

  final String title;
  final int noteId;

  @override
  State<ShowNotePage> createState() => _ShowNotePageState();
}

class _ShowNotePageState extends State<ShowNotePage> {

  late Note note;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshPage();
  }

  Future refreshPage() async {
    setState(() {
      isLoading = true;
    });

    note = await NoteDatabase.instance.readNote(widget.noteId);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0),
        child: Center(
          child: Neumorphic(
            margin: const EdgeInsets.fromLTRB(10, 20, 10, 4),
            style: NeumorphicStyle(
              lightSource: LightSource.topLeft,
              intensity: 0.9,
              depth: -10.0,
              shadowLightColorEmboss: const Color.fromARGB(255, 116, 68, 248),
              color: const Color(0xff7344F8),
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.noteTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                      letterSpacing: 1.5
                    ),
                  ),
                  const Divider(height: 30.0, color: Colors.white, thickness: 1),
                  Expanded(
                    child: Text(
                      note.noteText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 14.0,
                        height: 1.5,
                        letterSpacing: 1.1
                      ),
                    ),
                  ),
                ],
              ),
            ),                
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        color: Colors.deepPurpleAccent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    Icons.edit,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditNotePage(title: 'Edit a note', note: note)
                      )
                    ); 
                    refreshPage();
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
