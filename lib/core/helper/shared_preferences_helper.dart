import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  dynamic getValueForKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.get(key);
  }

  static setValueForKey(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (value == null) {
      removeValueForKey(key);
    } else if (value is int) {
      prefs.setInt(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else {
      throw "unknown value type :(";
    }

  }

 static removeAllKeys() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<bool> removeValueForKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
