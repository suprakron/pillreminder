import 'package:pillreminder/models/pill_model.dart';
import 'package:pillreminder/models/pilldate_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = "my_database.db";
  static const _databaseVersion = 1;

  static const table1 = 'pill';
  static const table2 = 'pill_date';

  static const columnPillId = 'id';
  static const columnPillName = 'name';
  static const columnPillCategory = 'categoty';
  static const columnPillBegin = 'start';
  static const columnPillDay = 'day';

  static const columnId = 'id';
  static const columnPill = 'pillid';
  static const columnStatus = 'status';
  static const columnTime = 'time';
  static const columnAmount = 'amount';
  static const columnEat = 'eat';

  // Make this a singleton class.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Only allow a single open connection to the database.
  static Database? _database;
  Future<Database> get database async {
    if (DatabaseHelper._database != null) return DatabaseHelper._database!;
    DatabaseHelper._database = await _initDatabase();
    return DatabaseHelper._database!;
  }

  // Open the database.
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // Create the database.
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table1 (
            $columnPillId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnPillName TEXT NOT NULL,
            $columnPillCategory TEXT NOT NULL,
            $columnPillBegin DATETIME NOT NULL,
            $columnPillDay INTEGER NOT NULL
          );
          ''');

    await db.execute('''
        CREATE TABLE $table2 (
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnPill INTEGER NOT NULL,
          $columnStatus INTEGER NOT NULL,
          $columnTime DATETIME NOT NULL,
          $columnAmount INTEGER NOT NULL,
          $columnEat TEXT NOT NULL,
          FOREIGN KEY ($columnPill) REFERENCES $table1($columnPillId)
        );
        ''');

    print("Create Database");
  }

  // Insert a row into the database.
  // static Future<int> insertPill(Map<String, dynamic> row) async {
  //   Database db = await instance.database;
  //   return await db.insert(table1, row);
  // }
  static Future<int> insertPill(PillModel row) async {
    Database db = await instance.database;
    return await db.insert(table1, row.toJson());
  }

  // Insert a row into the database.
  static Future<int> insertDatePill(PillDate row) async {
    Database db = await instance.database;
    return await db.insert(table2, row.toJson());
  }

  // Query the database.
  static Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table1);
  }

  // Query a row with id in the database.
  static Future<Map<String, dynamic>?> queryRow(int id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result =
        await db.query(table1, where: '$columnId = ?', whereArgs: [id]);
    return result.isNotEmpty ? result[0] : null;
  }

  // Update a row in the database.
  static Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnPillId];
    return await db
        .update(table1, row, where: '$columnPillId = ?', whereArgs: [id]);
  }
}
