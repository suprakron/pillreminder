import 'package:flutter/material.dart';
import 'package:pillreminder/constants.dart';
import 'package:pillreminder/db/dbhelper.dart';
import 'package:pillreminder/models/pill_model.dart';

import '../widgets/pilllist.dart';

class PillPage extends StatefulWidget {
  const PillPage({super.key});

  @override
  State<PillPage> createState() => _PillPageState();
}

class _PillPageState extends State<PillPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('รายการยา'),
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10, left: 8, right: 8),
        child: FutureBuilder(
          future: DatabaseHelper.queryAllRows(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<Map<String, dynamic>> rows = snapshot.data;
                if (rows.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/empty.png',
                          height: 50,
                          color: kTextNoData,
                        ),
                        const Text(
                          "ไม่พบข้อมูล",
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: kTextNoData,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: rows.length,
                    itemBuilder: (BuildContext context, int index) {
                      PillModel pill = PillModel.fromJson(rows[index]);
                      return PillList(
                        pillModel: pill,
                        onDelete: () {
                          setState(() {});
                        },
                      );
                    },
                  );
                }
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
