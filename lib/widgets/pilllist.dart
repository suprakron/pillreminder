import 'package:flutter/material.dart';

import '../constants.dart';
import '../models/pill_model.dart';

class PillList extends StatelessWidget {
  const PillList({
    Key? key,
    required this.pillModel,
  }) : super(key: key);

  final PillModel pillModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 230, 230, 230),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 1.0,
                        offset: Offset(1, 2),
                      )
                    ],
                  ),
                  child: Image.asset(
                    pillModel.categoty == Category.pill ? iconPill : iconPills,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(pillModel.name),
                    Text(pillModel.categoty),
                  ],
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                print('Delete');
              },
              icon: const Icon(
                Icons.delete_forever,
                color: Colors.grey,
                size: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}
