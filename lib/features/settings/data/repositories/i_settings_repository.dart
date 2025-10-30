import '../../../../core/services/i_prefs_storage_service.dart';

abstract class ISettingsRepository {
  IPrefsStorageService get storageService;

  Future<void> saveThemeMode(bool isDark);
  Future<bool> getThemeMode();
}
