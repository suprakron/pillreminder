// กำหนดชื่อตารางไว้ในตัวแปร
const String tablePills = 'pill';

// กำหนดฟิลด์ข้อมูลของตาราง
class PillFields {
  // สร้างเป็นลิสรายการสำหรับคอลัมน์ฟิลด์
  static final List<String> values = [
    id,
    book_id,
    name,
    categoty,
    publication_date
  ];

  // กำหนดแต่ละฟิลด์ของตาราง ต้องเป็น String ทั้งหมด
  static const String id = '_id'; // ตัวแรกต้องเป็น _id ส่วนอื่นใช้ชื่อะไรก็ได้
  static const String book_id = 'book_id';
  static const String name = 'name';
  static const String categoty = 'categoty';
  static const String publication_date = 'publication_date';
}

// ส่วนของ Data Model ของหนังสือ
class Pill {
  final int? id; // จะใช้ค่าจากที่ gen ในฐานข้อมูล
  final int bookid;
  final String name;
  final String categoty;
  final DateTime publicationdate;

  // constructor
  const Pill({
    this.id,
    required this.bookid,
    required this.name,
    required this.categoty,
    required this.publicationdate,
  });

  // ฟังก์ชั่นสำหรับ สร้างข้อมูลใหม่ โดยรองรับแก้ไขเฉพาะฟิลด์ที่ต้องการ
  Pill copy({
    int? id,
    int? bookid,
    String? name,
    String? categoty,
    DateTime? publicationdate,
  }) =>
      Pill(
        id: id ?? this.id,
        bookid: bookid ?? this.bookid,
        name: name ?? this.name,
        categoty: categoty ?? this.categoty,
        publicationdate: publicationdate ?? this.publicationdate,
      );

  // สำหรับแปลงข้อมูลจาก Json เป็น Book object
  static Pill fromJson(Map<String, Object?> json) => Pill(
        id: json[PillFields.id] as int?,
        bookid: json[PillFields.book_id] as int,
        name: json[PillFields.name] as String,
        categoty: json[PillFields.categoty] as String,
        publicationdate:
            DateTime.parse(json[PillFields.publication_date] as String),
      );

  // สำหรับแปลง Book object เป็น Json บันทึกลงฐานข้อมูล
  Map<String, Object?> toJson() => {
        PillFields.id: id,
        PillFields.book_id: bookid,
        PillFields.name: name,
        PillFields.categoty: categoty,
        PillFields.publication_date: publicationdate.toIso8601String(),
      };
}
