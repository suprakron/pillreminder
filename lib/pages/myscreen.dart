import 'package:flutter/material.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 50,
          flexibleSpace: DateHorizontal(
            dates: [
              DateTime(2022, 12, 19),
              DateTime(2022, 12, 20),
              DateTime(2022, 12, 21),
              DateTime(2022, 12, 22),
            ],
            onDateSelected: (date) {
              setState(() {
                selectedDate = date;
              });
            },
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return SizedBox(
                height: 50,
                child: Center(
                  child: Text(selectedDate.toString()),
                ),
              );
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }
}

class DateHorizontal extends StatelessWidget {
  final List<DateTime> dates;
  final Function(DateTime) onDateSelected;

  const DateHorizontal({
    Key? key,
    required this.dates,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        itemBuilder: (BuildContext context, int index) {
          final date = dates[index];
          return InkWell(
            onTap: () {
              if (onDateSelected != null) {
                onDateSelected(date);
              }
            },
            child: Container(
              width: 50,
              child: Center(
                child: Text(date.day.toString()),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 50,
              flexibleSpace: DateHorizontal(
                dates: [
                  DateTime(2022, 12, 19),
                  DateTime(2022, 12, 20),
                  DateTime(2022, 12, 21),
                  DateTime(2022, 12, 22),
                ],
                onDateSelected: (date) {
                  setState(() {
                    selectedDate = date;
                  });
                },
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return SizedBox(
                    height: 50,
                    child: Center(
                      child: Text(selectedDate.toString()),
                    ),
                  );
                },
                childCount: 1,
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
