import 'package:flutter_gastro_go/core/services/i_prefs_storage_service.dart';
import 'package:flutter_gastro_go/core/services/shared_prefs_storage_service.dart';
import 'package:flutter_gastro_go/features/settings/repositories/i_settings_repository.dart';
import 'package:flutter_gastro_go/features/settings/repositories/settings_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/settings/domain/stores/theme_store.dart';

GetIt getIt = GetIt.instance;

Future<void> setupInjections() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Interfaces

  getIt.registerLazySingleton<IPrefsStorageService>(
    () => SharedPrefsStorageService(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<ISettingsRepository>(
    () => SettingRepository(storageService: getIt<IPrefsStorageService>()),
  );

  // Stores

  getIt.registerLazySingleton<ThemeStore>(
    () => ThemeStore(getIt<ISettingsRepository>()),
  );
}
