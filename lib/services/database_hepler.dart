import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Database? _database;

  Future<Database> getDatabase() async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'dreamapp.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS "Journal" (
       id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        mood TEXT,
        voice_path TEXT,date TEXT
      )
    """);
  }

  Future<int> insertJournal(Map<String, dynamic> row) async {
    final db = await getDatabase();
    return await db.insert('Journal', row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    final db = await getDatabase();
    return await db.query('Journal');
  }

  Future<int> updateJournal(Map<String, dynamic> row) async {
    final db = await getDatabase();
    final id = row['id'];
    return await db.update('Journal', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteJournal(int id) async {
    final db = await getDatabase();
    return await db.delete('Journal', where: 'id = ?', whereArgs: [id]);
  }
}
