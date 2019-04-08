import 'package:shared_preferences/shared_preferences.dart';

class SpUtils {
  static Future<SharedPreferences> _getSp() async {
    return await SharedPreferences.getInstance();
  }

  static Future<bool> saveString(String key, String value) async {
    var sp = await _getSp();
    return await sp.setString(key, value);
  }

  static Future<bool> saveBool(String key, bool value) async {
    return await (await _getSp()).setBool(key, value);
  }

  static Future<bool> getBool(String kay) async {
    return await (await _getSp()).getBool(kay);
  }

  static Future<String> getString(String key, String defaultValue) async {
    var value =  (await _getSp()).getString(key);
    if (value == null) {
      return defaultValue;
    }
    return value;
  }

  static Future<dynamic> get(String key) async {
    return await (await _getSp()).get(key);
  }
}
