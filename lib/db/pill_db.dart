// import 'dart:async';

// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// import '../models/pill_model.dart';

// // สร้าง class จัดการข้อมูล
// class PillDatabase {
//   // กำหนดตัวแปรสำหรับอ้างอิงฐานข้อมูล
//   static final PillDatabase instance = PillDatabase._init();

//   // กำหนดตัวแปรฐานข้อมูล
//   static Database? _database;

//   PillDatabase._init();

//   Future<Database> get database async {
//     // ถ้ามีฐานข้อมูลนี้แล้วคืนค่า
//     if (_database != null) return _database!;
//     // ถ้ายังไม่มี สร้างฐานข้อมูล กำหนดชื่อ นามสกุล .db
//     _database = await _initDB('pill.db');
//     // คืนค่าฐานข้อมูล
//     return _database!;
//   }

//   // ฟังก์ชั่นสร้างฐานข้อมูล รับชื่อไฟล์ที่กำหนดเข้ามา
//   Future<Database> _initDB(String filePath) async {
//     // หาตำแหน่งที่จะจัดเก็บในระบบ ที่เตรียมไว้ให้
//     final dbPath = await getDatabasesPath();
//     // ต่อกับชื่อที่ส่งมา จะเป็น path เต็มของไฟล์
//     final path = join(dbPath, filePath);
//     // สร้างฐานข้อมูล และเปิดใช้งาน หากมีการแก้ไข ให้เปลี่ยนเลขเวอร์ชั่น เพิ่มขึ้นไปเรื่อยๆ
//     return await openDatabase(path, version: 1, onCreate: _createDB);
//   }

//   // สร้างตาราง
//   Future _createDB(Database db, int version) async {
//     // รูปแบบข้อมูล sqlite ที่รองรับ
//     const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
//     const textType = 'TEXT NOT NULL';

//     // ทำคำสั่งสร้างตาราง
//     await db.execute('''
// CREATE TABLE $tablePills (
//   ${PillFields.id} $idType,
//   ${PillFields.name} $textType,
//   ${PillFields.categoty} $textType,
// );

// CREATE TABLE $tablePills (
//   ${PillFields.id} $idType,
//   ${PillFields.name} $textType,
//   ${PillFields.categoty} $textType,
// );
// ''');
//   }

//   Future<PillModel> create(PillModel book) async {
//     final db = await instance.database; // อ้างอิงฐานข้อมูล

//     final id = await db.insert(tablePills, book.toJson());
//     return book.copy(id: id);
//   }

//   Future<PillModel> readPill(int id) async {
//     final db = await instance.database; // อ้างอิงฐานข้อมูล

//     // ทำคำสั่งคิวรี่ข้อมูลตามเงื่อนไข
//     final maps = await db.query(
//       tablePills,
//       columns: PillFields.values,
//       where: '${PillFields.id} = ?',
//       whereArgs: [id],
//     );

//     // ถ้ามีข้อมูล แสดงข้อมูลกลับออกไป
//     if (maps.isNotEmpty) {
//       return PillModel.fromJson(maps.first);
//     } else {
//       // ถ้าไม่มีแสดง error
//       throw Exception('ID $id not found');
//     }
//   }

//   Future<List<PillModel>> readAllPill() async {
//     final db = await instance.database; // อ้างอิงฐานข้อมูล

//     // กำหนดเงื่อนไขต่างๆ รองรับเงื่อนไขและรูปแบบของคำสั่ง sql ตัวอย่าง
//     // ใช้แค่การจัดเรียงข้อมูล
//     const orderBy = '${PillFields.id} DESC';
//     final result = await db.query(tablePills, orderBy: orderBy);

//     // ข้อมูลในฐานข้อมูลปกติเป็น json string data เวลาสั่งค่ากลับต้องทำการ
//     // แปลงข้อมูล จาก json ไปเป็น object กรณีแสดงหลายรายการก็ทำเป็น List
//     return result.map((json) => PillModel.fromJson(json)).toList();
//   }

//   Future<int> update(PillModel pill) async {
//     final db = await instance.database; // อ้างอิงฐานข้อมูล

//     // คืนค่าเป็นตัวเลขจำนวนรายการที่มีการเปลี่ยนแปลง
//     return db.update(
//       tablePills,
//       pill.toJson(),
//       where: '${PillFields.id} = ?',
//       whereArgs: [pill.id],
//     );
//   }

//   Future<int> delete(int id) async {
//     final db = await instance.database; // อ้างอิงฐานข้อมูล

//     // คืนค่าเป็นตัวเลขจำนวนรายการที่มีการเปลี่ยนแปลง
//     return db.delete(
//       tablePills,
//       where: '${PillFields.id} = ?',
//       whereArgs: [id],
//     );
//   }

//   Future<int> deleteAll() async {
//     final db = await instance.database; // อ้างอิงฐานข้อมูล
//     // คืนค่าเป็นตัวเลขจำนวนรายการที่มีการเปลี่ยนแปลง
//     return db.delete(
//       tablePills,
//     );
//   }

//   // คำสั่งสำหรับปิดฐานข้อมูล เท่าที่ลองใช้ เราไม่ควรปิด หรือใช้คำสั่งนี้
//   // เหมือนจะเป็น bug เพราะถ้าปิดฐานข้อมูล จะอ้างอิงไม่ค่อยได้ ในตัวอย่าง
//   // จะไม่ปิดหรือใช้คำสั่งนี้
//   Future close() async {
//     final db = await instance.database; // อ้างอิงฐานข้อมูล
//     db.close();
//   }
// }
