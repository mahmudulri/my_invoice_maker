import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('clients.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE clients (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        address1 TEXT,
        address2 TEXT,
        phone TEXT,
        website TEXT
      )
    ''');
  }

  Future<int> updateClient(Map<String, dynamic> client) async {
    final db = await database;
    return await db.update(
      'clients',
      client,
      where: 'id = ?',
      whereArgs: [client['id']],
    );
  }

  Future<int> insertClient(Map<String, dynamic> client) async {
    final db = await database;
    return await db.insert('clients', client);
  }

  Future<List<Map<String, dynamic>>> getClients() async {
    final db = await database;
    return await db.query('clients');
  }

  Future<void> deleteClient(int id) async {
    final db = await database;
    await db.delete('clients', where: 'id = ?', whereArgs: [id]);
  }
}
