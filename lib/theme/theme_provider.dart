import 'package:flutter/material.dart';
import 'package:january_2023/theme/theme_preference.dart';


class ThemeProvider extends ChangeNotifier {
  Color mainColor = Colors.blue;
  void changeThemeColor(Color color) {
    mainColor = color;
    notifyListeners();
  }
}



class DarkThemeProvider with ChangeNotifier {
  DarkThemePreference darkThemePreference = DarkThemePreference();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}