import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sppamaik/model/kir_model.dart';
import 'package:sppamaik/model/kediaman_model.dart';

class KirDatabase {
  static final KirDatabase instance = KirDatabase._init();

  static Database? _database;

  KirDatabase._init();

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
  Future<Kir> create(Kir kir) async {
    final db = await instance.database;

    //insert into table
    final id = await db.insert(tableKir, kir.toJson());
    return kir.copy(nokp: id.toString());
  }

  Future<Kir?> readKir(String nokp) async {
    final db = await instance.database;

    final maps = await db.query(
      tableKir,
      columns: KirFields.values,
      where: '${KirFields.nokp} = ? ',
      whereArgs: [nokp],
    );

    if (maps.isNotEmpty) {
      return Kir.fromJson(maps.first);
    } else {
      return null;
      //throw Exception('ID $nokp not found');
    }
  }

  Future<List<Kir>> readAllKir() async {
    final db = await instance.database;
    const orderBy = '${KirFields.nokp} ASC'; //,${PersonFields.email} DESC;
    final result = await db.query(tableKir, orderBy: orderBy);

    return result.map((json) => Kir.fromJson(json)).toList();
  }

  Future<int> update(Kir kir) async {
    final db = await instance.database;

    return db.update(
      tableKir,
      kir.toJson(),
      where: '${KirFields.nokp} = ? ',
      whereArgs: [kir.nokp],
    );
  }

  Future<int> delete(String id) async {
    final db = await instance.database;
    return db.delete(
      tableKir,
      where: '${KirFields.nokp}=?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    _database = null;
    db.close();
  }
}
