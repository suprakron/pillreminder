import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pillreminder/constants.dart';
import 'package:pillreminder/models/pilldate_model.dart';

class PillDay extends StatelessWidget {
  const PillDay({
    Key? key,
    required this.name,
    required this.categoty,
    required this.status,
    required this.datetime,
  }) : super(key: key);
  final String name;
  final String categoty;
  final int status;
  final DateTime datetime;
  @override
  Widget build(BuildContext context) {
    print(categoty);
    return Card(
        elevation: 1,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name),
                  Text(DateFormat('Hm').format(datetime)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(status == 0 ? 'ยังไม่ได้กิน' : 'กินแล้ว'),
                  Image.asset(
                    // ignore: unrelated_type_equality_checks
                    category.contains(Category.pill) ? iconPill : iconCapsule,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
