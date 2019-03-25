import 'package:shared_preferences/shared_preferences.dart';

class SpUtils {
  static Future<SharedPreferences> _getSp() async {
    return SharedPreferences.getInstance();
  }

  static Future<bool> saveString(String key, String value) async {
    var sp = await _getSp();
    return sp.setString(key, value);
  }

  static Future<bool> saveBool(String key, bool value) async {
    return (await _getSp()).setBool(key, value);
  }

  static Future<bool> getBool(String kay) async {
    return (await _getSp()).getBool(kay);
  }
}
