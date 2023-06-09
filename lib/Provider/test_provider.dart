import 'package:flutter/material.dart';

class TestProvider extends ChangeNotifier {
  String name = '';

  namechange(String value) {
    name = value;
    notifyListeners();
  }
}
