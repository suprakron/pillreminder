import 'package:flutter/material.dart';

class ListPill extends StatelessWidget {
  const ListPill({
    Key? key,
  }) : super(key: key);

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
                children: const [
                  Text('8.00 น.'),
                  Text('พาราเซต่มอล'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text('สถานะการกิน'),
                  FlutterLogo(size: 50),
                ],
              ),
            ],
          ),
        ));
  }
}
