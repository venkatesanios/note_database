import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/note.dart';

class ProgramDatabase {
  static final ProgramDatabase instance = ProgramDatabase._init();

  static Database? _database;

  ProgramDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableNotes ( 
  ${ProgramFields.id} $idType, 
  ${ProgramFields.isImportant} $boolType,
  ${ProgramFields.number} $integerType,
  ${ProgramFields.title} $textType,
  ${ProgramFields.description} $textType,
  ${ProgramFields.time} $textType,
  ${ProgramFields.setting1} $textType,
  ${ProgramFields.setting2} $textType,
  ${ProgramFields.setting3} $textType
  )
''');

  }

  Future<Program> create(Program program) async {
    final db = await instance.database;

    final id = await db.insert(tableNotes, program.toJson());
    return program.copy(id: id);
  }

  Future<Program> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableNotes,
      columns: ProgramFields.values,
      where: '${ProgramFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Program.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Program>> readAllNotes() async {
    final db = await instance.database;

    const orderBy = '${ProgramFields.time} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableNotes, orderBy: orderBy);

    return result.map((json) => Program.fromJson(json)).toList();
  }

  Future<int> update(Program note) async {
    final db = await instance.database;

    return db.update(
      tableNotes,
      note.toJson(),
      where: '${ProgramFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableNotes,
      where: '${ProgramFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
