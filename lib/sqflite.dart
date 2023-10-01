import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart' as sql;

class Sqflite_Helper {
  // static Database? _db;
  //
  // Future<Database?> get dB async {
  //   _db ??= await initialDB();
  //   return _db;
  // }
  //
  // initialDB() async {
  //   String databasePath = await getDatabasesPath();
  //   String databaseName = "note.db";
  //   String path = join(databasePath, databaseName);
  //   return await openDatabase(path, version: 2, onCreate: _onCreate);
  // }
  // final myTable = "note";
  // final id = "id";
  // final title = "title";
  // final description = "description";
  // final color ="color";
  static Future<void> createTables(sql.Database database) async {
    await database.execute(""" CREATE TABLE items(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    title TEXT,
    description TEXT,
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)
  """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('Nour.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      print("...Creating a table..");
          await createTables(database);
        });
  }

  static Future<int> createItem(String title, String? description) async {
    final db = await Sqflite_Helper.db();
    final data = {'title': title, 'description': description};
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await Sqflite_Helper.db();
    return db.query('items', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await Sqflite_Helper.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(int id, String title,
      String? description) async {
    final db = await Sqflite_Helper.db();
    final data = {
      'title': title,
      'description': description,
      'createdAt': DateTime.now().toString()
    };
    final result = await db.update(
        'items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }
  static Future<void> deleteItem(int id) async {
   final db = await Sqflite_Helper.db();
    try{
     await db.delete('items',where: "id = ?",whereArgs: [id]);
   }
   catch(err)
    {
      debugPrint("Something went wrong when deleting an item : $err");
    }
  }
// _onCreate(Database db,int version) async{
//   await db.execute('''
//   CREATE TABLE "$myTable"(
//   "$id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
//   "$title" TEXT NOT NULL,
//   "$description" TEXT NOT NULL
//   )
// ''');
//   print("Create==================");
// }
// insertData(String sql) async{
// //  Database? myDb = await dB;
//   int response = await _db!.rawInsert((sql));
//   return response;
// }
// readData(String sql) async{
//   //Database? myDb = await dB;
//   List<Map> response = await _db!.rawQuery((sql));
//   return response;
// }
// updateData(String sql) async{
//   //Database? myDb = await dB;
//   int response = await _db!.rawUpdate((sql));
//   return response;
// }
// deleteData(String sql) async{
//   //Database? myDb = await dB;
//   int response = await _db!.rawUpdate((sql));
//   return response;
// }
// deleteDB(String sql) async{
//   String databasePath = await getDatabasesPath();
//   String databaseName = "note.db";
//   String path = join(databasePath, databaseName);
//   await deleteDatabase(path);
// }
}
