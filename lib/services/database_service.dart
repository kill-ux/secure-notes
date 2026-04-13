import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:secure_notes/models/note.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'notes.db');

    return openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    db.execute('''
      CREATE TABLE notes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        position INTEGER NOT NULL
      )
    ''');
  }

  /// READ - get all notes ordered by position
  Future<List<Note>> getAllNotes() async {
    final db = await database;
    final res = await db.query('notes', orderBy: 'position ASC');
    return res.map((map) => Note.fromMap(map)).toList();
  }

  /// CREATE - create a note
  Future<Note> addNote(Note note) async {
    final db = await database;
    final id = await db.insert('notes', note.toMap());
    return note..id = id;
  }

  /// UPDATE - update a note
  Future<void> updateNote(Note note) async {
    final db = await database;
    await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<void> updateAllNote(List<Note> notes) async {
    final db = await database;
    await db.transaction((txn) async {
      for (int i = 0; i < notes.length; i++) {
        final note = notes[i];
        note.position = i;
        await txn.update(
          'notes',
          note.toMap(),
          where: 'id = ?',
          whereArgs: [note.id],
        );
      }
    });
  }

  /// DELETE - delete a note by id
  Future<void> deleteNote(int id) async {
    final db = await database;
    db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  /// DELETE - delete all
  Future<void> deleteAllNotes() async {
    final db = await database;
    db.delete('notes');
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
