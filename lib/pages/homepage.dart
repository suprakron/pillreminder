import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pillreminder/db/dbhelper.dart';

import '../constants.dart';
import '../service/notification.dart';
import 'add.dart';
import 'home.dart';
import 'pill.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({
    super.key,
  });

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  DateTime now = DateTime.now();
  int _currentIndex = 0;
  DateTime selectedDate = DateTime.now();

  // late String date;
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _notificationService.init();
    _fetchList();
  }

  _fetchList() async {
    DatabaseHelper.queryAllPillDateRows(
            DateFormat('yyyy-MM-dd').format(DateTime.now()))
        .then((result) {
      for (var element in result) {
        print(DateTime.parse(element['datetime']));
        _notificationService.scheduleNotification('แจ้งเตือนกินยา',
            element['name'], DateTime.parse(element['datetime']));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 0
          ? AppBar(
              backgroundColor: kPrimaryColor,
              title: Text(DateFormat.MMMMEEEEd('th').format(selectedDate)),
              actions: [
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null && picked != selectedDate) {
                      setState(() {
                        selectedDate = picked;
                        // date = DateFormat("yyyy-MM-dd").format(selectedDate);
                      });
                    }
                  },
                ),
              ],
            )
          : null,
      body: _currentIndex == 0
          ? HomePage(date: selectedDate)
          : _currentIndex == 2
              ? const PillPage()
              : const AppPillPage(),
      //  _pages[_currentIndex],
      bottomNavigationBar: bottomBar(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            backgroundColor: _currentIndex == 1 ? kIconColor : kPrimaryColor,
            child: const Icon(Icons.add),
            onPressed: () => setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AppPillPage()),
              );
            }),
          )),
    );
  }

  BottomAppBar bottomBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: kBottomNavigationBarHeight,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
          ),
          child: BottomNavigationBar(
              currentIndex: _currentIndex,
              backgroundColor: kPrimaryColor,
              selectedItemColor: Colors.white,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.calendar_today,
                    size: 20,
                    color: _currentIndex == 0 ? Colors.white : kIconColor,
                  ),
                  label: 'ตารางยา',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: kIconColor,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    iconCapsule,
                    height: 20,
                    width: 20,
                    color: _currentIndex == 2 ? Colors.white : kIconColor,
                  ),
                  label: 'ยา',
                )
              ]),
        ),
      ),
    );
  }
}
