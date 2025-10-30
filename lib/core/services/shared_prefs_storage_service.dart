import 'package:flutter_gastro_go/core/services/i_prefs_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class _Keys {
  static const String darkMode = "darkmode";
}

class SharedPrefsStorageService implements IPrefsStorageService {
  final SharedPreferences _prefs;
  SharedPrefsStorageService(this._prefs);

  @override
  Future<bool> getIsDarkMode() async {
    return _prefs.getBool(_Keys.darkMode) ?? true;
  }

  @override
  Future<void> setIsDarkMode(bool isDarkMode) async {
    _prefs.setBool(_Keys.darkMode, isDarkMode);
  }
}
