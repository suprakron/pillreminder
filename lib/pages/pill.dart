import 'package:flutter/material.dart';
import 'package:pillreminder/constants.dart';

import '../widgets/pilllist.dart';

class PillPage extends StatelessWidget {
  const PillPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('รายการยา'),
          backgroundColor: kPrimaryColor,
        ),
        body: Container(
          color: kBackgroundColor,
          margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) => SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const PillList(),
            ),
          ),
        ),
      ),
    );
  }
}
