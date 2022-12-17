import 'package:flutter/material.dart';
import 'package:pillreminder/constants.dart';
import 'package:pillreminder/models/pilldate_model.dart';

class PillDateProvider with ChangeNotifier {
  List<PillDate> listdate = [];

  List<PillDate> get getPillDate => listdate;

  void insertTime(int index, DateTime time) {
    listdate[index].time = time;
  }

  void insertAmount(int index, int amount) {
    listdate[index].amount = amount;
  }

  void insertType(int index, Eat eat) {
    listdate[index].eat = eat;
  }

  Future<void> insertPillDate(PillDate pillDate) async {
    listdate.add(pillDate);
    for (var element in listdate) {
      print(element.pillid);
      print(element.time);
      print(element.status);
      print(element.amount);
      print(element.eat);
    }
    notifyListeners();
  }
}
