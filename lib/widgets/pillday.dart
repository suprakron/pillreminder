// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pillreminder/constants.dart';
import 'package:pillreminder/db/dbhelper.dart';
import 'package:pillreminder/pages/homepage.dart';

class PillDay extends StatelessWidget {
  const PillDay({
    Key? key,
    required this.id,
    required this.name,
    required this.categoty,
    required this.status,
    required this.datetime,
  }) : super(key: key);

  final int id;
  final String name;
  final String categoty;
  final int status;
  final DateTime datetime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _dialogBuilder(context);
      },
      child: Card(
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
                    Text(DateFormat('Hm').format(datetime),
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
                      categoty == Category.pill ? iconPill : iconCapsule,
                      fit: BoxFit.cover,
                      color: status == 0 ? Colors.red : Colors.green,
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                onPressed: () async {
                  await DatabaseHelper.updateStatus({
                    "id": id,
                    "status": 1,
                  });
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const MyWidget()),
                      (route) => false);
                },
                child: const Text(
                  'ทานแล้ว',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                onPressed: () async {
                  await DatabaseHelper.updateStatus({
                    "id": id,
                    "status": 0,
                  });
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const MyWidget()),
                      (route) => false);
                },
                child: const Text(
                  'ยังไม่ทาน',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ));
      },
    );
  }
}
