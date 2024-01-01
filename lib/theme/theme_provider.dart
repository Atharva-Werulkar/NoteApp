import 'package:flutter/material.dart';
import 'package:note_app/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  //initially light mode
  ThemeData _themeData = lightMode;

  //getter method to access theme data
  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

//setter method to change theme data
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

//we will use this toggle
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
    notifyListeners();
  }
}
