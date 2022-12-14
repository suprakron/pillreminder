import 'package:flutter/material.dart';
import 'package:pillreminder/constants.dart';

class AppPillPage extends StatelessWidget {
  const AppPillPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
        ),
        body: Center(child: Text('เพิ่มยา')),
      ),
    );
  }
}
