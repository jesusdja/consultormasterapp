import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesLocal {

  static late SharedPreferences prefs;

  static Future<void> configurePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  static int get masterLogin => prefs.getInt("masterLogin") ?? 0;
  static set masterLogin(int value) => prefs.setInt("masterLogin", value);

  static List<String> get masterDataSend => prefs.getStringList("masterDataSend") ?? [];
  static set masterDataSend(List<String> value) => prefs.setStringList("masterDataSend", value);
}
