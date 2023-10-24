import 'package:flutter/material.dart';

/// Provider of all the fields used in form tapa expandable
class TapaProvider extends ChangeNotifier {
  String _tapaAsString = "";
  String _brewery = "";
  String _brewCountry = "";
  String _brewCountryCode = "";
  String _type = "";
  String _model = "";
  String _date = "";
  String _place = "";
  Color _color1 = Colors.transparent;
  Color _color2 = Colors.transparent;
  double _rating = 0.0;

  String get tapaAsString => _tapaAsString;
  set tapaAsString(String newValue) {
    _tapaAsString = newValue;
    notifyListeners();
  }

  String get brewery => _brewery;
  set brewery(String newValue) {
    _brewery = newValue;
    notifyListeners();
  }

  String get brewCountry => _brewCountry;
  set brewCountry(String newValue) {
    _brewCountry = newValue;
    notifyListeners();
  }

  String get brewCountryCode => _brewCountryCode;
  set brewCountryCode(String newValue) {
    _brewCountryCode = newValue;
    notifyListeners();
  }

  String get type => _type;
  set type(String newValue) {
    _type = newValue;
    notifyListeners();
  }

  String get model => _model;
  set model(String newValue) {
    _model = newValue;
    notifyListeners();
  }

  String get date => _date;
  set date(String newValue) {
    _date = newValue;
    notifyListeners();
  }

  String get place => _place;
  set place(String newValue) {
    _place = newValue;
    notifyListeners();
  }

  Color get color1 => _color1;
  set color1(Color newValue) {
    _color1 = newValue;
    notifyListeners();
  }

  Color get color2 => _color2;
  set color2(Color newValue) {
    _color2 = newValue;
    notifyListeners();
  }

  double get rating => _rating;
  set rating(double newValue) {
    _rating = newValue;
    notifyListeners();
  }
}
