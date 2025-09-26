import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static SharedPreferences? _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<void> saveData(String key, dynamic value) async {
    if (_preferences == null) await init();
    
    if (value is String) {
      await _preferences!.setString(key, value);
    } else if (value is int) {
      await _preferences!.setInt(key, value);
    } else if (value is double) {
      await _preferences!.setDouble(key, value);
    } else if (value is bool) {
      await _preferences!.setBool(key, value);
    } else if (value is List<String>) {
      await _preferences!.setStringList(key, value);
    }
  }

  Future<dynamic> getData(String key) async {
    if (_preferences == null) await init();
    return _preferences!.get(key);
  }

  Future<void> removeData(String key) async {
    if (_preferences == null) await init();
    await _preferences!.remove(key);
  }

  Future<void> clearAll() async {
    if (_preferences == null) await init();
    await _preferences!.clear();
  }
}