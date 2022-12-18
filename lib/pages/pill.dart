import 'package:flutter/material.dart';
import 'package:pillreminder/constants.dart';
import 'package:pillreminder/db/dbhelper.dart';
import 'package:pillreminder/models/pill_model.dart';

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
          child: FutureBuilder(
            future: DatabaseHelper.queryAllRows(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<Map<String, dynamic>> rows = snapshot.data;
                  return ListView.builder(
                    itemCount: rows.length,
                    itemBuilder: (BuildContext context, int index) {
                      PillModel pill = PillModel.fromJson(rows[index]);
                      return PillList(
                        pillModel: pill,
                      );
                    },
                  );
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
            // child: ListView.builder(
            //   itemCount: 10,
            //   itemBuilder: (context, index) => SizedBox(
            //     width: MediaQuery.of(context).size.width,
            //     child: PillList(
            //       index: index,
            //     ),
            //   ),
            // ),
          ),
        ),
      ),
    );
  }
}
