import 'package:shared_preferences/shared_preferences.dart';

class CacheData {
  static const String _usernameKey = 'username';

  /// Save a string value
  static Future<void> saveString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  /// Get a string value
  static Future<String?> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  /// Remove a specific key
  static Future<void> remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  /// Save username specifically
  static Future<void> saveUsername(String username) async {
    await saveString(_usernameKey, username);
  }

  /// Get saved username
  static Future<String?> getUsername() async {
    return getString(_usernameKey);
  }

  /// Clear all data
  static Future<void> clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
