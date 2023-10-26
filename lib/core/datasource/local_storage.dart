
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final SharedPreferences sharedPreferences;
  final FlutterSecureStorage flutterSecureStorage;

  LocalStorage({
    required this.sharedPreferences,
    required this.flutterSecureStorage,
  });

  Future<bool> writeBool(String key, bool value) async {
 return   await sharedPreferences.setBool(key, value);
  }

  bool? readBool(String key) {
    return sharedPreferences.getBool(key) ?? false;
  }

  Future writeString({required String key, required String value}) async {
    await sharedPreferences.setString(key, value);
  }

  String? readString(String key) {
    return sharedPreferences.getString(key);
  }

  Future writeSecureString({required String key, required String value}) async {
    await flutterSecureStorage.write(key: key, value: value);
  }

  Future<String?> readSecureString(String key) async {
    return flutterSecureStorage.read(key: key);
  }

  /// ----------------------------------------------------------
  /// Method that clears all shared preference
  /// ----------------------------------------------------------
  Future<bool> clearAll() async {
    return sharedPreferences.clear();
  }

  /// ----------------------------------------------------------
  /// Method that clears all shared preference except
  /// ----------------------------------------------------------
  Future<bool> clearAllExcept(String myKey) async {
    for(String key in sharedPreferences.getKeys()) {
      if(key != myKey) {
        sharedPreferences.remove(key);
      }
    }
    return true;
  }

  /// ----------------------------------------------------------
  /// Method that clears selected shared preference
  /// ----------------------------------------------------------
  Future<bool> clearOnly(String mKey) async {
    return sharedPreferences.remove(mKey);
  }
}
