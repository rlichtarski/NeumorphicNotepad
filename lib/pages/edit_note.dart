import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notepad/models/note.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notepad/view_models/NoteViewModel.dart';
import 'package:provider/provider.dart';

class EditNotePage extends StatefulWidget {
  const EditNotePage({ Key? key, required this.title, required this.note }) : super(key: key);

  final String title;
  final Note note;

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {

  late String noteTitle = widget.note.noteTitle;
  late String noteText = widget.note.noteText;
  
  late TextEditingController titleController;
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: noteTitle);
    textController = TextEditingController(text: noteText);
  }

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
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                      );
                    } else {
                      final noteViewModel = Provider.of<NoteViewModel>(context, listen: false);
                      noteViewModel.updateNote(
                        Note(
                          id: widget.note.id, 
                          noteTitle: titleController.text.toString().trim(),
                          noteText: textController.text.toString().trim(), 
                          createdTime: DateTime.now()
                        )
                      );
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

}
