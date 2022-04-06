import 'dart:async';
import 'package:notepad/models/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NoteDatabase {
  static final NoteDatabase instance = NoteDatabase._init();

  static Database? _database;

  NoteDatabase._init();

  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;

  }

  Future<Database> _initDB(String path) async {
    String dbPath = await getDatabasesPath();
    String filesPath = join(dbPath, path);

    return openDatabase(filesPath, version: 1, onCreate: _createDB);    
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE $tableName (
        ${NoteFields.id} $idType,
        ${NoteFields.noteTitle} $textType,
        ${NoteFields.noteText} $textType,
        ${NoteFields.time} $textType
      )
    ''');
  }

  Future<Note> addNoteToDB(Note note) async {
    final db = await instance.database;
    final id = await db.insert(tableName, note.toJson());
    return note.copy(id: id);
  }

  Future<Note> readNote(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableName,
      columns: NoteFields.values,
      where: '${NoteFields.id} = ?',
      whereArgs: [id]
    );

    if(maps.isNotEmpty) {
      return Note.fromJson(maps.first);
    } else {
      throw Exception('ID $id is not found!');
    }
  }

  Future<List<Note>> readAllNotes() async {
    final db = await instance.database;

    const orderBy = '${NoteFields.time} ASC';
    final result = await db.query(tableName, orderBy: orderBy);
    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<int> update(Note note) async {
    final db = await instance.database;
    return await db.update(
      tableName,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id] 
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableName,
      where: '${NoteFields.id} = ?',
      whereArgs: [id]
    );
  }

  Future closeDB() async {
    final db = await instance.database;
    db.close();
  }

}