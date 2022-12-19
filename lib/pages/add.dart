import 'package:flutter/material.dart';
import 'package:pillreminder/constants.dart';
import 'package:pillreminder/db/dbhelper.dart';
import 'package:pillreminder/models/pill_model.dart';
import 'package:pillreminder/models/pilldate_model.dart';

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

  String? category;

  late int count = 3;
  late int day;

  List<PillDate> listPill = [];

  @override
  void initState() {
    super.initState();
    count = 3;
    day = 7;
    _dayController.text = day.toString();
    _countController.text = count.toString();
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              namePill(context, _nameController),
              categoryPill(),
              setDatePill(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                ),
                onPressed: () async {
                  if (_nameController.text.trim().isEmpty ||
                      category!.isEmpty) {
                    return;
                  }
                  PillModel pill = PillModel(
                    name: _nameController.text,
                    categoty: category!,
                    start: DateTime.now().toIso8601String(),
                    day: day,
                  );
                  var pillid = await DatabaseHelper.insertPill(pill);
                  for (var element in listPill) {
                    PillDate datePill = PillDate(
                      pillid: pillid,
                      status: element.status,
                      time: element.time,
                      amount: element.amount,
                      eat: element.eat,
                    );
                    datePill.status ??= 0;
                    await DatabaseHelper.insertDatePill(datePill);
                  }
                  Navigator.of(context).pop();
                },
                child: const SizedBox(
                    width: 100,
                    height: 50,
                    child: Center(
                        child: Text(
                      'เพิ่มยา',
                    ))),
              )
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
                  'จำนวน $count  ครั้ง/วัน',
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
                  'จำนวน $day วัน/สัปดาห์',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: count,
            itemBuilder: (context, index) {
              return TimeSetPill(
                index: index,
                listPill: listPill,
                day: day,
                onListModified: (items) {
                  listPill = items;
                  listPill.forEach((element) {
                    print(element.amount);
                  });
                },
              );
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
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'ประเภทของยา',
              ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          category = Category.pill;
                        });
                      },
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: boxDecationCategory(Category.pill),
                        child: Image.asset(
                          iconPill,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          category = Category.capsule;
                        });
                      },
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: boxDecationCategory(Category.capsule),
                        child: Image.asset(
                          iconPills,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     setState(() {
                    //       category = Category.potion;
                    //     });
                    //   },
                    //   child: Container(
                    //     height: 80,
                    //     width: 80,
                    //     color: Colors.red,
                    //     child: Image.asset(
                    //       iconbottle,
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration boxDecationCategory(String categorySelect) {
    return BoxDecoration(
        color: category == categorySelect
            ? const Color.fromARGB(255, 230, 230, 230)
            : null,
        borderRadius: BorderRadius.circular(10),
        boxShadow: category == categorySelect
            ? const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 1.0,
                  offset: Offset(1, 2),
                )
              ]
            : null);
  }

  Widget namePill(BuildContext context, TextEditingController controller) {
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
            TextField(
              onChanged: ((value) => setState(() => controller.text = value)),
              controller: controller,
              maxLines: 1,
              decoration: const InputDecoration(
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
