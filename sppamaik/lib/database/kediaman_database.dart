import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sppamaik/model/kediaman_model.dart';
import 'package:sppamaik/model/kir_model.dart';

class KediamanDatabase {
  static final KediamanDatabase instance = KediamanDatabase._init();

  static Database? _database;

  KediamanDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('sppamaikdb.db');
    return _database!;
  } //call backgroud proses

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath); //data/data/database/persons.db

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    //const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE $tableKir(
        ${KirFields.nokp} $textType,
        ${KirFields.nama} $textType,
        ${KirFields.notelefon} $textType
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableKediaman(
        ${KediamanFields.nokp} $textType,
        ${KediamanFields.alamat} $textType,
        ${KediamanFields.poskod} $textType,
        ${KediamanFields.bandar} $textType
      )
    ''');
  }

  //run function asynchronous
  Future<Kediaman> create(Kediaman kediaman) async {
    final db = await instance.database;

    //insert into table
    final id = await db.insert(tableKediaman, kediaman.toJson());
    return kediaman.copy(nokp: id.toString());
  }

  Future<Kediaman?> readKediaman(String nokp) async {
/*
    final db = await instance.database;
    final maps = await db.query(
      tableKediaman,
      columns: KediamanFields.values,
      where: '{$KediamanFields.nokp}=?',
      whereArgs: [nokp],
    );

    if (maps.isNotEmpty) {
      return Kediaman.fromJson(maps.first);
    } else {
      throw Exception('NO.KP $nokp tidak dijumpai');
    }
*/

    final db = await instance.database;

    final maps = await db.query(
      tableKediaman,
      columns: KediamanFields.values,
      where: '${KediamanFields.nokp} = ? ',
      whereArgs: [nokp],
    );

    if (maps.isNotEmpty) {
      return Kediaman.fromJson(maps.first);
    } else {
      return null;
      //return Kediaman.fromJson(maps.first);
      //throw Exception('ID $nokp not found');
    }
  }

  Future<List<Kediaman>> readAllKediaman() async {
    final db = await instance.database;
    const orderBy = '${KediamanFields.nokp} ASC'; //,${PersonFields.email} DESC;
    final result = await db.query(tableKediaman, orderBy: orderBy);

    return result.map((json) => Kediaman.fromJson(json)).toList();
  }

  Future<int> update(Kediaman kediaman) async {
    final db = await instance.database;

    return db.update(
      tableKediaman,
      kediaman.toJson(),
      where: '${KediamanFields.nokp} = ? ',
      whereArgs: [kediaman.nokp],
    );
  }

  Future<int> delete(String id) async {
    final db = await instance.database;
    return db.delete(
      tableKediaman,
      where: '${KediamanFields.nokp}=?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    _database = null;
    db.close();
  }
}
