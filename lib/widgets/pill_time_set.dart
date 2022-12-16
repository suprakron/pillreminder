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
  TextEditingController _amountController = TextEditingController();

  String? time;
  TimeOfDay now = TimeOfDay.now();

  int amount = 2;
  String type = 'เม็ด';

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
        TextButton(
            onPressed: () {
              _dialogBuilder(context, _amountController);
            },
            child: Text('$amount $type')),
        TextButton(onPressed: () {}, child: Text('หลังอ่าหาร')),
      ],
    );
  }

  Future<void> _dialogBuilder(
    BuildContext context,
    TextEditingController controller,
  ) {
    const List<String> list = <String>[
      'เม็ด',
      'ช้อน',
    ];
    String dropdownValue = list.first;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ปริมาณยา'),
          content: Row(
            children: [
              Expanded(
                child: SizedBox(
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              DropdownButton<String>(
                value: dropdownValue,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('ยกเลิก'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('ตกลง'),
              onPressed: () {
                setState(() {
                  amount = int.parse(controller.text);
                  type = dropdownValue;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
