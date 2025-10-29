import 'package:flutter_gastro_go/core/services/i_prefs_storage_service.dart';

import 'i_settings_repository.dart';

class SettingRepository implements ISettingsRepository {
  @override
  IPrefsStorageService storageService;

  SettingRepository({required this.storageService});

  @override
  Future<bool> getThemeMode() async {
    return await storageService.getIsDarkMode();
  }

  @override
  Future<void> saveThemeMode(bool isDark) async {
    await storageService.setIsDarkMode(isDark);
  }
}
