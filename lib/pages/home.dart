// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:intl/intl.dart';
// import 'package:pillreminder/db/dbhelper.dart';
// import 'package:scroll_to_index/scroll_to_index.dart';

// import './pill.dart';
// import './add.dart';
// import '../widgets/pillday.dart';
// import '../constants.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final scrollDirection = Axis.vertical;
//   late AutoScrollController controller;
//   late List<List<int>> randomList;
//   late DateTime dateTime;
//   DateTime now = DateTime.now();
//   late String month;

//   List<String> months = [
//     'มกราคม',
//     'กุมภาพันธ์',
//     'มีนาคม',
//     'เมษายน',
//     'พฤษภาคม',
//     'มิถุนายน',
//     'กรกฎาคม',
//     'สิงหาคม',
//     'กันยายน',
//     'ตุลาคม',
//     'พฤศจิกายน',
//     'ธันวาคม'
//   ];
//   List<String> days = ['อา', 'จ.', 'อ.', 'พ.', 'พฤ.', 'ศ.', 'ส.'];

//   int _currentIndex = 0;
//   int selectedIndex = 0;

//   final List<Widget> _pages = [
//     Container(
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       child: FutureBuilder(
//           future: DatabaseHelper.queryAllPillDateRows(
//               DateFormat('yyyy-MM-dd').format(DateTime.now())),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               } else {
//                 List<Map<String, dynamic>> rows = snapshot.data;
//                 return ListView.builder(
//                   itemCount: rows.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return PillDay(
//                       categoty: rows[index]["categoty"] ?? "",
//                       datetime: DateTime.parse(rows[index]["datetime"]),
//                       name: rows[index]["name"] ?? "",
//                       status: rows[index]["status"] ?? 0,
//                     );
//                   },
//                 );
//               }
//             } else {
//               return const Center(child: CircularProgressIndicator());
//             }
//           }),
//     ),
//     const AppPillPage(),
//     const PillPage()
//   ];

//   @override
//   void initState() {
//     selectedIndex = now.day - 1;
//     month = months[now.month - 1];

//     controller = AutoScrollController(
//         viewportBoundaryGetter: () =>
//             Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
//         axis: scrollDirection);
//     _scrollToIndex();
//     super.initState();
//   }

//   Future _scrollToIndex() async {
//     await controller.scrollToIndex(selectedIndex,
//         preferPosition: AutoScrollPosition.middle);
//   }

//   @override
//   Widget build(BuildContext context) {
//     _currentIndex == 0 ? _scrollToIndex() : null;

//     return Scaffold(
//       backgroundColor: kBackgroundColor,
//       appBar: _currentIndex == 0 ? appBarCustom() : null,
//       body: _pages[_currentIndex],
//       bottomNavigationBar: bottomBar(),
//       floatingActionButtonLocation:
//           FloatingActionButtonLocation.miniCenterDocked,
//       floatingActionButton: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: FloatingActionButton(
//             backgroundColor: _currentIndex == 1 ? kIconColor : kPrimaryColor,
//             child: const Icon(Icons.add),
//             onPressed: () => setState(() {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const AppPillPage()),
//               );
//             }),
//           )),
//     );
//   }

//   AppBar appBarCustom() {
//     return AppBar(
//       backgroundColor: kPrimaryColor,
//       toolbarHeight: 148.0,
//       title: Stack(children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: kPrimaryColor,
//                 elevation: 0,
//               ),
//               child: Text(
//                 month,
//                 textAlign: TextAlign.left,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20,
//                   color: kTextColor,
//                 ),
//               ),
//               onPressed: () async {
//                 DateTime? pickedDate = await showDatePicker(
//                     context: context,
//                     initialDate: now,
//                     firstDate: DateTime(1950),
//                     lastDate: DateTime(2100));

//                 if (pickedDate != null) {
//                   setState(() {
//                     dateTime = pickedDate;
//                     selectedIndex = pickedDate.day - 1;
//                     month = months[pickedDate.month - 1];
//                   });
//                   _scrollToIndex();
//                 } else {}
//               },
//             ),
//             dateHorizontal(),
//           ],
//         ),
//       ]),
//     );
//   }

//   BottomAppBar bottomBar() {
//     return BottomAppBar(
//       shape: const CircularNotchedRectangle(),
//       notchMargin: 8.0,
//       clipBehavior: Clip.antiAlias,
//       child: SizedBox(
//         height: kBottomNavigationBarHeight,
//         child: Container(
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             border: Border(
//               top: BorderSide(
//                 color: Colors.grey,
//                 width: 0.5,
//               ),
//             ),
//           ),
//           child: BottomNavigationBar(
//               currentIndex: _currentIndex,
//               backgroundColor: kPrimaryColor,
//               selectedItemColor: Colors.white,
//               onTap: (index) {
//                 setState(() {
//                   _currentIndex = index;
//                 });
//               },
//               items: [
//                 BottomNavigationBarItem(
//                   icon: Icon(
//                     Icons.calendar_today,
//                     size: 20,
//                     color: _currentIndex == 0 ? Colors.white : kIconColor,
//                   ),
//                   label: 'ตารางยา',
//                 ),
//                 const BottomNavigationBarItem(
//                   icon: Icon(
//                     Icons.home,
//                     color: kIconColor,
//                   ),
//                   label: '',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: SvgPicture.asset(
//                     iconpill,
//                     height: 20,
//                     width: 20,
//                     color: _currentIndex == 2 ? Colors.white : kIconColor,
//                   ),
//                   label: 'ยา',
//                 )
//               ]),
//         ),
//       ),
//     );
//   }

//   String dayCase(String date) {
//     String day = '';
//     switch (date) {
//       case 'Sun':
//         day = days[0];
//         break;
//       case 'Mon':
//         day = days[1];
//         break;
//       case 'Tue':
//         day = days[2];
//         break;
//       case 'Wed':
//         day = days[3];
//         break;
//       case 'Thu':
//         day = days[4];
//         break;
//       case 'Fri':
//         day = days[5];
//         break;
//       case 'Sat':
//         day = days[6];
//         break;
//       default:
//     }
//     return day;
//   }

//   SingleChildScrollView dateHorizontal() {
//     int lengthDay = DateTime(dateTime.year, dateTime.month + 1, 0).day;
//     late DateTime firstDay = DateTime(dateTime.year, dateTime.month, 1);
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       controller: controller,
//       physics: const ClampingScrollPhysics(),
//       child: Row(
//         children: List.generate(
//           lengthDay,
//           (index) {
//             final dateShow = firstDay.add(Duration(days: index));
//             final dayName = DateFormat('E').format(dateShow);
//             return AutoScrollTag(
//               key: ValueKey(index),
//               controller: controller,
//               index: index,
//               child: Container(
//                 margin:
//                     EdgeInsets.only(left: index == 0 ? 16.0 : 0.0, right: 16.0),
//                 child: GestureDetector(
//                   onTap: () => setState(() {
//                     selectedIndex = index;
//                   }),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         height: 42.0,
//                         width: 42.0,
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           color: selectedIndex == index
//                               ? kPrimaryColor
//                               : Colors.transparent,
//                           borderRadius: BorderRadius.circular(44.0),
//                         ),
//                         child: Text(
//                           // dayName,
//                           dayCase(dayName),
//                           style: TextStyle(
//                             fontSize: 20.0,
//                             color: selectedIndex == index
//                                 ? kSecondaryColor
//                                 : kTextColor,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 8.0),
//                       Text(
//                         "${index + 1}",
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           color: selectedIndex == index
//                               ? kSecondaryColor
//                               : kTextColor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 8.0),
//                       Container(
//                         height: 2.0,
//                         width: 28.0,
//                         color: selectedIndex == index
//                             ? kPrimaryColor
//                             : Colors.transparent,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// // class Home extends StatefulWidget {
// //   const Home({
// //     Key? key,
// //   }) : super(key: key);

// //   @override
// //   State<Home> createState() => _HomeState();
// // }

// // class _HomeState extends State<Home> {
// //   @override
// //   void initState() {
// //     super.initState();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return;
// //   }
// // }
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pillreminder/constants.dart';

import '../db/dbhelper.dart';
import '../service/notification.dart';
import '../widgets/pillday.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.date,
  }) : super(key: key);

  final DateTime date;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime datetime = widget.date;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: FutureBuilder(
          future: DatabaseHelper.queryAllPillDateRows(
              DateFormat('yyyy-MM-dd').format(datetime)),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                if (snapshot.data.length == 0) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          iconPill,
                          color: kTextNoData,
                        ),
                        const Text(
                          "ไม่มียาที่ต้องทาน",
                          style: TextStyle(
                            color: kTextNoData,
                            fontSize: 20,
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  List<Map<String, dynamic>> rows = snapshot.data;
                  return ListView.builder(
                    itemCount: rows.length,
                    itemBuilder: (BuildContext context, int index) {
                      return PillDay(
                        id: rows[index]["id"] ?? "",
                        categoty: rows[index]["categoty"] ?? "",
                        datetime: DateTime.parse(rows[index]["datetime"]),
                        name: rows[index]["name"] ?? "",
                        status: rows[index]["status"] ?? 0,
                      );
                    },
                  );
                }
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
