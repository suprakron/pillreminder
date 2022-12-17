// กำหนดชื่อตารางไว้ในตัวแปร
import 'package:pillreminder/constants.dart';

const String tablePills = 'pill';

// ส่วนของ Data Model ของหนังสือ
class PillModel {
  final int? id;
  final String name;
  final String categoty;
  final DateTime begin;
  final int day;

  const PillModel({
    this.id,
    required this.name,
    required this.categoty,
    required this.begin,
    required this.day,
  });

  static PillModel fromJson(Map<String, dynamic> json) => PillModel(
        id: json['id'],
        name: json['name'],
        categoty: json['categoty'],
        begin: json['begin'],
        day: json['day'],
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'categoty': categoty,
        'begin': begin,
        'day': day,
      };
}
