import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'tasks_db.db');
    Database myDb = await openDatabase(path,
        onCreate: _onCreate, version: 07, onUpgrade: _onUpgrade);
    return myDb;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE "tasks" (
     "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
     "title" TEXT NOT NULL,
     "date" TEXT NOT NULL ,
     "time" TEXT NOT NULL,
     "status" TEXT NOT NULL
     
    )
    ''');
    debugPrint('onCreate ======================');
  }

  //when change version
  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    debugPrint('onUpgrade ======================== ');
    // await db.execute("ALTER TABLE tasks ADD COLUMN color TEXT");
  }

  Future<List<Map>> readDate(String sql) async {
    Database? myDb =await db;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }

  insertDate(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }

  updateDate(String sql) async {
    Database? myDb =await db;
    int response = await myDb!.rawUpdate(sql);
    return response;
  }

  deleteDate(String sql) async {
    Database? myDb =await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }

  myDeleteDataBase() async {
    String dataBasePath = await getDatabasesPath();
    String path = join(dataBasePath, 'tasks_db.db');
    await deleteDatabase(path);
  }
}
