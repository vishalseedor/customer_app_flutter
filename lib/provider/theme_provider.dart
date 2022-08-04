import 'package:flutter/material.dart';
import 'package:food_app/models/dark.dart';

class ThemeProvider with ChangeNotifier {
  DarkThemePreference darkthemePrefernce = DarkThemePreference();
  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;
  set darkThemeval(bool value) {
    _darkTheme = value;
    darkthemePrefernce.setdarkTheme(value);
    notifyListeners();
  }
}
