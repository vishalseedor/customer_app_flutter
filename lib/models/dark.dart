import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreference {
  // ignore: constant_identifier_names
  static const THEME_STATUS = "THEMESTATUS";
  setdarkTheme(bool value) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    preference.setBool(THEME_STATUS, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getBool(THEME_STATUS) ?? false;
  }
}
