abstract class IPrefsStorageService {
  Future<bool> getIsDarkMode();
  Future<void> setIsDarkMode(bool isDarkMode);
}
