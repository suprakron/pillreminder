import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pillreminder/constants.dart';

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
                  Text(name,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(DateFormat('yMd').format(datetime),
                      // Text(DateFormat('Hm').format(datetime),
                      style: const TextStyle(
                        fontSize: 20,
                      ))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(status == 0 ? 'ยังไม่ได้กิน' : 'กินแล้ว',
                      style: const TextStyle(
                        fontSize: 20,
                      )),
                  Image.asset(
                    category.contains(Category.pill) ? iconPill : iconCapsule,
                    fit: BoxFit.cover,
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
