const String tableName = 'notes';

class NoteFields {
  static final List<String> values = [
    id, noteTitle, noteText, time
  ];

  static const String id = '_id';
  static const String noteTitle = 'noteTitle';
  static const String noteText = 'noteText';
  static const String time = 'createdTime';
}

class Note {
  final int? id;
  final String noteTitle;
  final String noteText;
  final DateTime createdTime;

  const Note({ 
    this.id, 
    required this.noteTitle, 
    required this.noteText, 
    required this.createdTime 
  });

  Map<String, Object?> toJson() => {
    NoteFields.id: id,
    NoteFields.noteTitle: noteTitle,
    NoteFields.noteText: noteText,
    NoteFields.time: createdTime.toIso8601String()
  };

  static Note fromJson(Map<String, Object?> json) => Note(
    id: json[NoteFields.id] as int?,
    noteTitle: json[NoteFields.noteTitle] as String,
    noteText: json[NoteFields.noteText] as String,
    createdTime: DateTime.parse(json[NoteFields.time] as String),
  );

  Note copy({
    int? id,
    String? noteTitle,
    String? noteText,
    DateTime? createdTime
  }) => Note(
    id: id ?? this.id,
    noteTitle: noteTitle ?? this.noteTitle,
    noteText: noteText ?? this.noteText,
    createdTime: createdTime ?? this.createdTime
  );

}