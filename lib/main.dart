import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notepad/pages/add_note.dart';
import 'package:notepad/pages/notes_list.dart';
import 'package:notepad/view_models/NoteViewModel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NoteViewModel>(
      create: (_) => NoteViewModel(),
      child: NeumorphicApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const NotesListPage(title: 'Notepad'),
          '/add_note': (context) => const AddNotePage(title: 'Add a note'),
        },
      ),
    );
  }
}