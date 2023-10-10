import 'package:flutter/material.dart';

class TotalCapsProvider extends ChangeNotifier {
  int _totalCaps = 0;

  int get totalCaps => _totalCaps;

  set value(int newValue) {
    _totalCaps = newValue;
    notifyListeners();
  }
}
