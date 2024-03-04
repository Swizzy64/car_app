import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'carApp.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE carApp (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            dist REAL,
            cost REAL,
            fuel REAL,
            avg_f_com REAL,
            date TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE carApp2 (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            cost REAL,
            description TEXT,
            date TEXT
          )
        ''');
      },
    );
  }
  // CRUD Operations
  // Create
  Future<int> insert(String table, Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert(table, row);
  }
  // Read
  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    Database db = await database;
    return await db.query(table);
  }
  // Update
  Future<int> update(String table, Map<String, dynamic> row) async {
    Database db = await database;
    return await db.update(table, row, where: 'id = ?', whereArgs: [row['id']]);
  }
  // Delete
  Future<int> delete(String table, int id) async {
    Database db = await database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
