import 'package:flutter_gastro_go/core/services/api/assets_api_service.dart';
import 'package:flutter_gastro_go/core/services/api/i_api_service.dart';
import 'package:flutter_gastro_go/core/services/i_prefs_storage_service.dart';
import 'package:flutter_gastro_go/core/services/shared_prefs_storage_service.dart';
import 'package:flutter_gastro_go/features/dish/data/repositories/dish_repository.dart';
import 'package:flutter_gastro_go/features/dish/data/repositories/i_dish_repository.dart';
import 'package:flutter_gastro_go/features/dish/data/services/dish_service.dart';
import 'package:flutter_gastro_go/features/dish/data/services/i_dish_service.dart';
import 'package:flutter_gastro_go/features/restaurant/data/repositories/i_restaurant_repository.dart';
import 'package:flutter_gastro_go/features/restaurant/data/repositories/restaurant_repository.dart';
import 'package:flutter_gastro_go/features/restaurant/data/services/i_restaurant_service.dart';
import 'package:flutter_gastro_go/features/restaurant/data/services/restaurant_service.dart';
import 'package:flutter_gastro_go/features/settings/data/repositories/i_settings_repository.dart';
import 'package:flutter_gastro_go/features/settings/data/repositories/settings_repository.dart';
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

  getIt.registerLazySingleton<IApiService>(() => AssetsApiService());

  // Restaurant
  getIt.registerLazySingleton<IRestaurantService>(
    () => RestaurantService(getIt<IApiService>()),
  );

  getIt.registerLazySingleton<IRestaurantRepository>(
    () => RestaurantRepository(getIt<IRestaurantService>()),
  );

  // Dish

  getIt.registerLazySingleton<IDishService>(
    () => DishService(getIt<IApiService>()),
  );

  getIt.registerLazySingleton<IDishRepository>(
    () => DishRepository(getIt<IDishService>()),
  );

  // Stores

  getIt.registerLazySingleton<ThemeStore>(
    () => ThemeStore(getIt<ISettingsRepository>()),
  );
}
