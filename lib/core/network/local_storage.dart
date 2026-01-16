import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences _prefs;

  // Initialize once in main.dart
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveString(String key, String value) async => await _prefs.setString(key, value);
  static String? getString(String key) => _prefs.getString(key);
  
  static Future<void> saveBool(String key, bool value) async => await _prefs.setBool(key, value);
  static bool getBool(String key) => _prefs.getBool(key) ?? false;

  static Future<void> clearAll() async => await _prefs.clear();
}