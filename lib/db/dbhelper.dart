import 'package:pillreminder/models/pill_model.dart';
import 'package:pillreminder/models/pilldate_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = "my_database4.db";
  static const _databaseVersion = 1;

  static const table1 = 'pill';
  static const table2 = 'pill_date';

  static const columnPillId = 'id';
  static const columnPillName = 'name';
  static const columnPillCategory = 'categoty';
  // static const columnPillBegin = 'start';
  static const columnPillDay = 'day';

  static const columnId = 'id';
  static const columnPill = 'pillid';
  static const columnStatus = 'status';
  static const columnTime = 'datetime';
  static const columnAmount = 'amount';
  static const columnEat = 'eat';

  static const queryAndJoinPill = '''
    SELECT t1.*,t2.*
     FROM $table2 t2
     INNER JOIN $table1 t1
     ON t2.$columnPill = t1.$columnPillId
    ''';

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
          ON DELETE CASCADE
          ON UPDATE CASCADE
        );
        ''');
  }

  // Insert a row into the database.
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

  // Query the database.
  static Future<List<Map<String, dynamic>>> queryAllPillDateRows(
    String datetime,
  ) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.rawQuery('''
        $queryAndJoinPill 
        ''');
    // WHERE datetime >= date(\'now\', \'start of day\') AND datetime < date(\'now\', \'start of day\', \'+1 day\')
    List<Map<String, dynamic>> filteredResult = result
        .where((element) => element["datetime"].startsWith(datetime))
        .toList();

    return filteredResult;
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
        .update(table1, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // delete a row in the database.
  static Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table1, where: '$columnId = ?', whereArgs: [id]);
  }

  // update a row status in the database
  static Future<int> updateStatus(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db
        .update(table2, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Query a row with id in the database.
  static Future<Map<String, dynamic>?> queryRowPillDate(int id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result =
        await db.query(table2, where: '$columnId = ?', whereArgs: [id]);
    print(result[0]["eat"]);
    return result.isNotEmpty ? result[0] : null;
  }
}
