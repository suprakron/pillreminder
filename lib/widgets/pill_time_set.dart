import 'package:flutter/material.dart';
import 'package:pillreminder/models/pilldate_model.dart';

typedef ListModifiedCallback = void Function(List<PillDate> items);

class TimeSetPill extends StatefulWidget {
  const TimeSetPill({
    Key? key,
    required this.index,
    required this.day,
    required this.listPill,
    required this.onListModified,
  }) : super(key: key);

  final int index;
  final int day;
  final List<PillDate> listPill;
  final ListModifiedCallback onListModified;

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
  TimeOfDay nowTime = TimeOfDay.now();

  int amount = 1;
  String type = 'เม็ด';

  String timeType = 'ก่อนอาหาร';

  late List<PillDate> _items;

  @override
  void initState() {
    DateTime nowDate = DateTime.now();
    time = "${nowTime.hour}:${nowTime.minute}";
    _items = widget.listPill;
    for (var i = 0; i < widget.day; i++) {
      _items.add(PillDate(
        pillid: 2,
        status: 0,
        datetime:
            "${DateTime(nowDate.year, nowDate.month, nowDate.day, nowTime.hour, nowTime.minute)}",

        // "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day} $time",
        amount: amount,
        eat: timeType,
      ));
    }
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
        String hourString = pickedTime.hour.toString().padLeft(2, '0');
        String minuteString = pickedTime.minute.toString().padLeft(2, '0');
        time = "$hourString:$minuteString";

        time = "12:34";
        _items[widget.index].datetime =
            "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day} $time";
      });
    }
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
                  _items[widget.index].amount = amount;
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
          _items[widget.index].eat;
          Navigator.of(context).pop();
        });
      },
      child: Text(label));
}
