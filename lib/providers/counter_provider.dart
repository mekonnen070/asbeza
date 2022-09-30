import 'package:flutter/material.dart';

class CountersProvider extends ChangeNotifier {
  int tabIndex = 0;
  int cartCount = 0;

  void setTabIndex(int index) {
    tabIndex = index;
    notifyListeners();
  }
}
