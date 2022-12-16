import 'package:flutter/material.dart';

class TimeSetPill extends StatelessWidget {
  const TimeSetPill({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(onPressed: () {}, child: Text('8.00')),
        TextButton(onPressed: () {}, child: Text('2 เม็ด')),
        TextButton(onPressed: () {}, child: Text('หลังอ่าหาร')),
      ],
    );
  }
}
