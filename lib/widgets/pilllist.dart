import 'package:flutter/material.dart';

class PillList extends StatelessWidget {
  const PillList({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

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
                const FlutterLogo(size: 50),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('name pill'),
                    Text('time and frequency'),
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
