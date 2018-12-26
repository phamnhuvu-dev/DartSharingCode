import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DbHelper {
  static final DbHelper _instance = new DbHelper.internal();

  factory DbHelper() => _instance;

//  final String tableNote = 'noteTable';
//  final String columnId = 'id';
//  final String columnTitle = 'title';
//  final String columnDescription = 'description';

  static Database _db;

  DbHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'app.db');
//    await deleteDatabase(path); // just for testing
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
//    await db.execute(
//        'CREATE TABLE $tableNote($columnId INTEGER PRIMARY KEY, $columnTitle TEXT, $columnDescription TEXT)');
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

//  Future<int> saveNote(Note note) async {
//    var dbClient = await db;
//    var result = await dbClient.insert(tableNote, note.toMap());
////    var result = await dbClient.rawInsert(
////        'INSERT INTO $tableNote ($columnTitle, $columnDescription) VALUES (\'${note.title}\', \'${note.description}\')');
//
//    return result;
//  }

//  Future<List> getAllNotes() async {
//    var dbClient = await db;
//    var result = await dbClient.query(tableNote, columns: [columnId, columnTitle, columnDescription]);
////    var result = await dbClient.rawQuery('SELECT * FROM $tableNote');
//
//    return result.toList();
//  }

//  Future<int> getCount() async {
//    var dbClient = await db;
//    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM $tableNote'));
//  }

//  Future<Note> getNote(int id) async {
//    var dbClient = await db;
//    List<Map> result = await dbClient.query(tableNote,
//        columns: [columnId, columnTitle, columnDescription],
//        where: '$columnId = ?',
//        whereArgs: [id]);
////    var result = await dbClient.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');
//
//    if (result.length > 0) {
//      return new Note.fromMap(result.first);
//    }
//
//    return null;
//  }

//  Future<int> deleteNote(int id) async {
//    var dbClient = await db;
//    return await dbClient.delete(tableNote, where: '$columnId = ?', whereArgs: [id]);
////    return await dbClient.rawDelete('DELETE FROM $tableNote WHERE $columnId = $id');
//  }
//
//  Future<int> updateNote(Note note) async {
//    var dbClient = await db;
//    return await dbClient.update(tableNote, note.toMap(), where: "$columnId = ?", whereArgs: [note.id]);
////    return await dbClient.rawUpdate(
////        'UPDATE $tableNote SET $columnTitle = \'${note.title}\', $columnDescription = \'${note.description}\' WHERE $columnId = ${note.id}');
//  }
}