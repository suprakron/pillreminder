import 'package:flutter/material.dart';
import 'package:pillreminder/db/dbhelper.dart';

import '../constants.dart';
import '../models/pill_model.dart';

class PillList extends StatefulWidget {
  const PillList({
    Key? key,
    required this.pillModel,
    required this.onDelete,
  }) : super(key: key);

  final PillModel pillModel;
  final VoidCallback onDelete;
  @override
  State<PillList> createState() => _PillListState();
}

class _PillListState extends State<PillList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DatabaseHelper.queryRowPillDate(widget.pillModel.id!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              Map<String, dynamic>? rows = snapshot.data;
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
                              widget.pillModel.categoty == Category.pill
                                  ? iconPill
                                  : iconCapsule,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.pillModel.name,
                                style: const TextStyle(fontSize: 20),
                              ),
                              Text(
                                "?????????${rows!["eat"]}",
                                style: const TextStyle(fontSize: 15),
                              ),
                              Text(
                                "??????????????? ${rows["amount"]} ????????????",
                                style: const TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          _dialogDelete(context, widget.pillModel.name);
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
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Future<void> _dialogDelete(BuildContext context, String name) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('?????????????????????'),
          content: Text('?????????????????????????????????????????????????????????????????????????????????????????? $name.'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('??????????????????'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('????????????'),
              onPressed: () {
                DatabaseHelper.delete(widget.pillModel.id!);
                widget.onDelete();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
