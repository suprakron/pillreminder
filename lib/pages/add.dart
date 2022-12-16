import 'package:flutter/material.dart';
import 'package:pillreminder/constants.dart';

import '../widgets/pill_time_set.dart';

class AppPillPage extends StatefulWidget {
  const AppPillPage({super.key});

  @override
  State<AppPillPage> createState() => _AppPillPageState();
}

class _AppPillPageState extends State<AppPillPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dayController = TextEditingController();
  TextEditingController _countController = TextEditingController();

  late int count = 3;
  late int day;

  @override
  void initState() {
    super.initState();
    count = 3;
    day = 7;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เพิ่มยา'),
        backgroundColor: kPrimaryColor,
      ),
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              namePill(context),
              categoryPill(),
              setDatePill(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(
    BuildContext context,
    String label,
    TextEditingController controller,
  ) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(label),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
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
                  switch (label) {
                    case 'จำนวนยา':
                      count = int.parse(controller.text);
                      break;
                    case 'จำนวนวัน':
                      day = int.parse(controller.text);
                      break;
                  }
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget setDatePill() {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          const Text('ตั้งเวลาเตือน'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  _dialogBuilder(context, 'จำนวนยา', _countController);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  elevation: 0,
                ),
                child: Text(
                  'จำนวน $count เม็ด',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _dialogBuilder(context, 'จำนวนวัน', _dayController);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  elevation: 0,
                ),
                child: Text(
                  'จำนวน $day วัน',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: count,
            itemBuilder: (context, index) {
              return const TimeSetPill();
            },
          )
        ]),
      ),
    );
  }

  ElevatedButton buttonSetTime(String label, Function onPressed) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget categoryPill() {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ประเภทของยา',
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                        width: 150.0,
                        height: 50,
                        color: Colors.red,
                        child: const Text('น้ำ')),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 160.0,
                      height: 50,
                      color: Colors.blue,
                      child: const Text('เม็ด'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 160.0,
                      height: 50,
                      color: Colors.green,
                      child: const Text("แคปซูล"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget namePill(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Text('ชื่อยา'),
            ),
            const TextField(
              maxLines: 1,
              decoration: InputDecoration(
                  fillColor: Color.fromRGBO(248, 248, 246, 1),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          BorderSide(width: 0, style: BorderStyle.solid))),
            ),
          ],
        ),
      ),
    );
  }
}
