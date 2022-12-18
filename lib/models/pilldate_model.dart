import 'package:pillreminder/constants.dart';
import 'package:pillreminder/models/pill_model.dart';

class PillDate {
  final int? id;
  final PillModel? pillid;
  late int? status;
  late DateTime? time;
  late int? amount;
  late String? eat;

  PillDate({
    this.id,
    this.pillid,
    required this.status,
    required this.time,
    required this.amount,
    required this.eat,
  });

  factory PillDate.fromJson(Map<String, dynamic> json) => PillDate(
        id: json['id'],
        pillid: json['pillid'],
        status: json['status'],
        time: json['time'],
        amount: json['amount'],
        eat: json['eat'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pillid': pillid,
      'status': status,
      'time': time,
      'amount': amount,
      'eat': eat,
    };
  }
}
