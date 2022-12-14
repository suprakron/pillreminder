import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import './pill.dart';
import './add.dart';
import '../widgets/pillday.dart';
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
  late String month;
  List<String> months = [
    'มกราคม',
    'กุมภาพันธ์',
    'มีนาคม',
    'เมษายน',
    'พฤษภาคม',
    'มิถุนายน',
    'กรกฎาคม',
    'สิงหาคม',
    'กันยายน',
    'ตุลาคม',
    'พฤศจิกายน',
    'ธันวาคม'
  ];
  int _currentIndex = 0;

  List<Widget> _pages = [Home(), AppPillPage(), PillPage()];

  @override
  void initState() {
    dateTime = DateTime.now();
    selectedIndex = dateTime.day - 1;
    month = months[dateTime.month - 1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: _currentIndex == 0 ? appBarCustom() : null,
      body: _pages[_currentIndex],
      bottomNavigationBar: bottomBar(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FloatingActionButton(
            backgroundColor: _currentIndex == 1 ? kIconColor : kPrimaryColor,
            child: const Icon(Icons.add),
            onPressed: () => setState(() {
              // _currentIndex = 1;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AppPillPage()),
              );
            }),
          )),
    );
  }

  AppBar appBarCustom() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      toolbarHeight: 148.0,
      title: Stack(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                elevation: 0,
              ),
              child: Text(
                month,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: kTextColor,
                ),
              ),
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100));

                if (pickedDate != null) {
                  setState(() {
                    dateTime = pickedDate;
                    selectedIndex = pickedDate.day - 1;
                    month = months[pickedDate.month - 1];
                    print(month);
                  });
                } else {}
              },
            ),
            dateHorizontal(),
          ],
        ),
      ]),
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
                  icon: SvgPicture.asset(
                    'assets/pill.svg',
                    height: 20,
                    color: _currentIndex == 2 ? Colors.white : kIconColor,
                  ),
                  label: 'ยา',
                )
              ]),
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
                      style: TextStyle(
                        fontSize: 16.0,
                        color: selectedIndex == index
                            ? kSecondaryColor
                            : kTextColor,
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
}

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: ((context, index) {
          return const PillDay();
        }),
      ),
    );
  }
}
