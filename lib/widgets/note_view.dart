import 'package:intl/intl.dart';
import 'package:notepad/models/note.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NoteListView extends StatelessWidget {
  const NoteListView({ Key? key, required this.note }) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 4),
      child: Neumorphic(
        style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          lightSource: LightSource.topLeft,
          intensity: 0.3,
          surfaceIntensity: 0.3,
          color: const Color(0xff7344F8),
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(25.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.noteTitle,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                DateFormat.yMMMd().format(note.createdTime),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 12.0
                ),
              ),
              const SizedBox(height: 10.0),
              Flexible(
                child: Text(
                  note.noteText,
                  softWrap: true,
                  maxLines: null,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 14.0
                  ),
                ),
              ),
            ],
          ),
        ),                
      ),
    );
  }
}