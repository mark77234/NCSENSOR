import 'package:flutter/material.dart';

import '../models/ui/index.dart';

class UiDataProvider with ChangeNotifier {
  UiData? _uiData;

  UiData? get uiData => _uiData;

  void updateData(UiData newData) {
    _uiData = newData;
    notifyListeners();
  }
}
