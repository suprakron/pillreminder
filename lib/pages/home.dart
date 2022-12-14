import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  DateTime now = DateTime.now();
  late DateTime dateTime;
  @override
  void initState() {
    dateTime = DateTime.now();
    selectedIndex = dateTime.day - 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        toolbarHeight: 148.0,
        title: Column(
          children: [
            titleAppbar(),
            const SizedBox(height: 16.0),
            dateHorizontal(),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: ((context, index) {
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
              // Card(
              //       child: ListTile(
              //         leading: const FlutterLogo(size: 72.0),
              //         title: Text(
              //           'ชื่อยา ${index + 1}',
              //           style: const TextStyle(color: kTextColor),
              //         ),
              //         subtitle: const Text(
              //           '13.00 น.',
              //           style: TextStyle(color: kTextColor),
              //         ),
              //         trailing: IconButton(
              //           icon: const Icon(
              //             Icons.more_vert,
              //             color: kTextColor,
              //           ),
              //           onPressed: () {},
              //         ),
              //       ),
              //     )
              ),
        ),
      ),
    );
  }

  SingleChildScrollView dateHorizontal() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const ClampingScrollPhysics(),
      child: Row(
        children: List.generate(
          DateTime(now.year, now.month + 1, 0).day,
          (index) {
            final dateShow = dateTime.add(Duration(days: index));
            final dayName = DateFormat('E').format(dateShow);
            return Padding(
              padding:
                  EdgeInsets.only(left: index == 0 ? 16.0 : 0.0, right: 16.0),
              child: GestureDetector(
                onTap: () => setState(() {
                  selectedIndex = index;
                }),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 42.0,
                      width: 42.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: selectedIndex == index
                            ? kPrimaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(44.0),
                      ),
                      child: Text(
                        dayName,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: selectedIndex == index
                              ? kSecondaryColor
                              : kTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "${index + 1}",
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: kTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      height: 2.0,
                      width: 28.0,
                      color: selectedIndex == index
                          ? kPrimaryColor
                          : Colors.transparent,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Row titleAppbar() {
    return Row(
      children: const [
        Expanded(
            child: Text("ตารางกินยา",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kTextColor,
                )))
      ],
    );
  }
}
