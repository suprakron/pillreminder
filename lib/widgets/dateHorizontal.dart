import 'package:flutter/material.dart';

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
