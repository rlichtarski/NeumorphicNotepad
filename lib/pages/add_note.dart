import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notepad/db/notes_db.dart';
import 'package:notepad/models/note.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({ Key? key, required this.title }) : super(key: key);

  final String title;

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final titleController = TextEditingController();
  final textController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    textController.dispose();
    super.dispose();
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
              intensity: 0.8,
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
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Note's title",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade300,
                        fontWeight: FontWeight.normal,
                        fontSize: 20.0,
                        letterSpacing: 1.5
                      ),
                      contentPadding: EdgeInsets.zero
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                      letterSpacing: 1.5
                    ),
                  ),
                  const Divider(height: 30.0, color: Colors.white, thickness: 1),
                  Expanded(
                    child: TextField(
                      controller: textController,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Your note's content",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade300,
                          fontWeight: FontWeight.normal,
                          fontSize: 14.0,
                          height: 1.5,
                        ),
                        contentPadding: EdgeInsets.zero
                      ),
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
                    Icons.close,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
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
                    Icons.check,
                    size: 30,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    String title = titleController.text.toString().trim();
                    String text = textController.text.toString().trim();
                    if(title.isEmpty || text.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Can't save empty notes",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.redAccent,
                        textColor: Colors.white,
                        fontSize: 16.0
                      );
                    } else {
                      addNote(title, text);
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future addNote(String title, String text) async {
    final note = Note(
      noteTitle: title,
      noteText: text,
      createdTime: DateTime.now()
    );

    await NoteDatabase.instance.addNoteToDB(note);
  }

}
