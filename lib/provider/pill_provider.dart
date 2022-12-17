import 'package:flutter/material.dart';

import '../db/dbhelper.dart';
import '../models/pill_model.dart';

class PillProvider with ChangeNotifier {
  PillProvider();

  List<PillModel> _listPill = [];
  List<PillModel> get getPill => _listPill;

  Future<void> insertPill(PillModel pill) async {
    _listPill.add(pill);
    for (var el in _listPill) {
      print(el.name);
      print(el.categoty);
      print(el.begin);
      print(el.day);
    }
    notifyListeners();
  }
}
