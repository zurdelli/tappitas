import 'package:flutter/material.dart';

class SliderProvider extends ChangeNotifier {
  double _value = 0.0;

  double get value => _value;

  set value(double newValue) {
    _value = newValue;
    notifyListeners();
  }
}
