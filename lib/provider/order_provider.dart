import 'package:flutter/material.dart';

/// Order & total of tappas provider
class OrderProvider extends ChangeNotifier {
  String _orderString = "brewery";

  String get orderString => _orderString;
  set orderString(String newValue) {
    _orderString = newValue;
    notifyListeners();
  }

  int _cantTappas = 0;
  int get cantTappas => _cantTappas;
  set cantTappas(int newValue) {
    _cantTappas = newValue;
    notifyListeners();
  }
}
