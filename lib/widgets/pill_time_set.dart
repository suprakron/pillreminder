import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';

class TimeSetPill extends StatefulWidget {
  const TimeSetPill({
    Key? key,
  }) : super(key: key);

  @override
  State<TimeSetPill> createState() => _TimeSetPillState();
}

class _TimeSetPillState extends State<TimeSetPill> {
  String? time;
  TimeOfDay now = TimeOfDay.now();
  @override
  void initState() {
    time = "${now.hour} : ${now.minute}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
            onPressed: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                initialTime: TimeOfDay.now(),
                context: context,
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(alwaysUse24HourFormat: true),
                    child: child ?? Container(),
                  );
                },
              );

              if (pickedTime != null) {
                setState(() {
                  time = "${pickedTime.hour} : ${pickedTime.minute}";
                });
                print(pickedTime.hour);
              } else {
                print("Time is not selected");
              }
            },
            child: Text(time!)),
        TextButton(onPressed: () {}, child: Text('2 เม็ด')),
        TextButton(onPressed: () {}, child: Text('หลังอ่าหาร')),
      ],
    );
  }
}
