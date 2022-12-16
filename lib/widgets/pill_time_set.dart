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

  List<String> listEat = <String>[
    'ก่อนอาหาร',
    'หลังอาหาร',
  ];

  String? time;
  TimeOfDay now = TimeOfDay.now();

  int amount = 0;
  String type = 'เม็ด';

  String timeType = 'ก่อนอาหาร';

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
              await _timePicker(context);
            },
            child: Text(time!)),
        TextButton(
            onPressed: () async {
              await _dialogTimePill(context, _amountController);
            },
            child: Text('$amount $type')),
        TextButton(
            onPressed: () async {
              await _dialogAmoutPill(context);
            },
            child: Text(timeType)),
      ],
    );
  }

  Future<void> _timePicker(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? Container(),
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        time = "${pickedTime.hour} : ${pickedTime.minute}";
      });
    } else {}
  }

  Future<void> _dialogTimePill(
    BuildContext context,
    TextEditingController controller,
  ) {
    List<String> list = <String>[
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
                underline: Container(
                  height: 2,
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

  Future<void> _dialogAmoutPill(
    BuildContext context,
  ) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ปริมาณยา'),
          content: SizedBox(
            width: 50,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                for (int i = 0; i < listEat.length; i++)
                  buttomSelectTimetype(listEat[i]),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buttomSelectTimetype(String label) => ElevatedButton(
      onPressed: () {
        setState(() {
          timeType = label;
          Navigator.of(context).pop();
        });
      },
      child: Text(label));
}
