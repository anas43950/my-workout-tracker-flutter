import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils {
  SharedPrefUtils._();

  static late final SharedPreferences _sp;

  static Future<void> init() async {
    _sp = await SharedPreferences.getInstance();
  }

  static Future<void> storeInt(String key, int value) {
    return _sp.setInt(key, value);
  }

  static Future<void> storeString(String key, String value) {
    return _sp.setString(key, value);
  }

  static int? getInt(String key) {
    return _sp.getInt(key);
  }

  static String? getString(String key) {
    return _sp.getString(key);
  }

  static Future<bool> clear() {
    return _sp.clear();
  }
}
