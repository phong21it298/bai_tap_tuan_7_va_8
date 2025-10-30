import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'photo.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'photos.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE photos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            path TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertPhoto(Photo photo) async {
    final db = await database;
    return await db.insert('photos', photo.toMap());
  }

  Future<List<Photo>> getPhotos() async {
    final db = await database;
    final maps = await db.query('photos', orderBy: 'id DESC');
    return List.generate(maps.length, (i) => Photo.fromMap(maps[i]));
  }

  Future<int> deletePhoto(int id) async {
    final db = await database;
    return await db.delete('photos', where: 'id = ?', whereArgs: [id]);
  }
}
