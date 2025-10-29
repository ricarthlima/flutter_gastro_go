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
import 'package:flutter_gastro_go/features/restaurant/domain/usecases/filter_restaurants_by_category_usecase.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/usecases/filter_restaurants_by_distance_usecase.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/usecases/filter_restaurants_by_rating_usecase.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/usecases/filter_restaurants_with_vegan_dishes_usecase.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/usecases/sort_restaurants_usecase.dart';
import 'package:flutter_gastro_go/features/settings/data/repositories/i_settings_repository.dart';
import 'package:flutter_gastro_go/features/settings/data/repositories/settings_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/restaurant/domain/usecases/search_restaurants_by_name_usecase.dart';
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

  getIt.registerLazySingleton(
    () => SearchRestaurantsByNameUseCase(getIt<IRestaurantRepository>()),
  );

  getIt.registerLazySingleton(
    () => FilterRestaurantsByCategoryUseCase(getIt<IRestaurantRepository>()),
  );

  getIt.registerLazySingleton(
    () => FilterRestaurantsByDistanceUseCase(getIt<IRestaurantRepository>()),
  );

  getIt.registerLazySingleton(
    () => FilterRestaurantsByRatingUseCase(getIt<IRestaurantRepository>()),
  );

  getIt.registerLazySingleton(
    () => SearchRestaurantsByNameUseCase(getIt<IRestaurantRepository>()),
  );

  getIt.registerLazySingleton(() => SortRestaurantsUseCase());

  // Dish
  getIt.registerLazySingleton<IDishService>(
    () => DishService(getIt<IApiService>()),
  );

  getIt.registerLazySingleton<IDishRepository>(
    () => DishRepository(getIt<IDishService>()),
  );

  // Esse carinha precisa dos repos de Restaurant e Dish
  getIt.registerLazySingleton(
    () => FilterRestaurantsWithVeganDishesUseCase(
      restaurantRepository: getIt<IRestaurantRepository>(),
      dishRepository: getIt<IDishRepository>(),
    ),
  );

  // Stores

  getIt.registerLazySingleton<ThemeStore>(
    () => ThemeStore(getIt<ISettingsRepository>()),
  );
}
