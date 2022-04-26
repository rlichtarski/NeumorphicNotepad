import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notepad/models/note.dart';
import 'package:notepad/pages/show_note.dart';
import 'package:notepad/view_models/NoteViewModel.dart';
import 'package:notepad/widgets/note_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class NotesListPage extends StatefulWidget {
  const NotesListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<NotesListPage> createState() => NotesListPageState();
}

class NotesListPageState extends State<NotesListPage> {
  late List<Note> notesList;

  @override
  void initState() {
    super.initState();
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
      body: Consumer<NoteViewModel>(
        builder: (consumerContext, value, child) => FutureBuilder(
          future: value.readAllNotes(),
          builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
            switch(snapshot.connectionState) {
              case ConnectionState.none: {
                return Text('none');
              }
              case ConnectionState.waiting: {
                return const SpinKitCircle(color: Colors.white, size: 50.0,);
              }
              case ConnectionState.active: {
                return Text('active');
              }
              case ConnectionState.done: {
                final notes = snapshot.data!;
                return Container(
                  padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 0.0),
                  child: notes.isEmpty ? const Center(
                    child: Text(
                      'EMPTY NOTES LIST',
                      style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 20.0,
                        color: Colors.white
                      ),
                    )
                  ) : GridView.builder(
                    itemCount: notes.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,),
                    itemBuilder: (BuildContext context, int index) => GestureDetector(
                      child: NoteListView(note: notes[index]),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowNotePage(title: 'Note', noteId: notes[index].id!)
                          ) 
                        );
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
                                  value.deleteNote(notesList[index].id!);
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
                );
              }
            }
          },
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