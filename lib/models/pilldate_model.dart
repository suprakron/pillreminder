class PillDate {
  final int? id;
  late int? pillid;
  late int? status;
  late String? datetime;
  late int? amount;
  late String? eat;

  PillDate({
    this.id,
    this.pillid,
    this.status = 0,
    required this.datetime,
    required this.amount,
    required this.eat,
  });

  factory PillDate.fromJson(Map<String, dynamic> json) => PillDate(
        id: json['id'],
        pillid: json['pillid'],
        status: json['status'],
        datetime: json['datetime'],
        amount: json['amount'],
        eat: json['eat'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pillid': pillid,
      'status': status,
      'datetime': datetime,
      'amount': amount,
      'eat': eat,
    };
  }
}
