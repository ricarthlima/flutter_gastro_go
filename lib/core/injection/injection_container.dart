import 'package:flutter_gastro_go/core/services/api/assets_api_service.dart';
import 'package:flutter_gastro_go/core/services/api/i_api_service.dart';
import 'package:flutter_gastro_go/core/services/i_prefs_storage_service.dart';
import 'package:flutter_gastro_go/core/services/shared_prefs_storage_service.dart';
import 'package:flutter_gastro_go/features/dish/data/repositories/dish_repository.dart';
import 'package:flutter_gastro_go/features/dish/data/repositories/i_dish_repository.dart';
import 'package:flutter_gastro_go/features/dish/data/services/dish_service.dart';
import 'package:flutter_gastro_go/features/dish/data/services/i_dish_service.dart';
import 'package:flutter_gastro_go/features/dish/domain/usecases/usecases.dart';
import 'package:flutter_gastro_go/features/favorite/data/repositories/i_favorite_repository.dart';
import 'package:flutter_gastro_go/features/favorite/data/repositories/objectbox_favorites_repository.dart';
import 'package:flutter_gastro_go/features/restaurant/data/repositories/i_restaurant_repository.dart';
import 'package:flutter_gastro_go/features/restaurant/data/repositories/restaurant_repository.dart';
import 'package:flutter_gastro_go/features/restaurant/data/services/i_restaurant_service.dart';
import 'package:flutter_gastro_go/features/restaurant/data/services/restaurant_service.dart';
import 'package:flutter_gastro_go/features/restaurant/presentation/stores/restaurant_list_store.dart';
import 'package:flutter_gastro_go/features/settings/data/repositories/i_settings_repository.dart';
import 'package:flutter_gastro_go/features/settings/data/repositories/settings_repository.dart';
import 'package:flutter_gastro_go/objectbox.g.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../../features/dish/presentation/stores/dish_list_store.dart';
import '../../features/favorite/domain/usecases/usecases.dart';
import '../../features/favorite/presentation/stores/favorites_store.dart';
import '../../features/restaurant/domain/usecases/usecases.dart';
import '../../features/settings/domain/stores/theme_store.dart';

GetIt getIt = GetIt.instance;

Future<void> setupInjections() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // ObjectBox
  final dir = await getApplicationDocumentsDirectory();
  final obStore = await openStore(directory: p.join(dir.path, "gatro-go-db"));
  getIt.registerLazySingleton<Store>(() => obStore);

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
    () => SearchRestaurantsByCategoryUseCase(getIt<IRestaurantRepository>()),
  );

  getIt.registerLazySingleton(() => SortRestaurantsUseCase());

  // Dish
  getIt.registerLazySingleton<IDishService>(
    () => DishService(getIt<IApiService>()),
  );

  getIt.registerLazySingleton<IDishRepository>(
    () => DishRepository(getIt<IDishService>()),
  );

  getIt.registerLazySingleton<SearchDishesByNameOrDescriptionUseCase>(
    () => SearchDishesByNameOrDescriptionUseCase(getIt<IDishRepository>()),
  );

  getIt.registerLazySingleton<FilterDishesByVeganUseCase>(
    () => FilterDishesByVeganUseCase(getIt<IDishRepository>()),
  );

  getIt.registerLazySingleton<SortDishesUseCase>(() => SortDishesUseCase());

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

  getIt.registerLazySingleton<RestaurantListStore>(
    () => RestaurantListStore(
      getIt<IRestaurantRepository>(),
      getIt<SearchRestaurantsByNameUseCase>(),
      getIt<FilterRestaurantsByCategoryUseCase>(),
      getIt<SearchRestaurantsByCategoryUseCase>(),
      getIt<FilterRestaurantsByDistanceUseCase>(),
      getIt<FilterRestaurantsByRatingUseCase>(),
      getIt<FilterRestaurantsWithVeganDishesUseCase>(),
      getIt<SortRestaurantsUseCase>(),
    ),
  );

  // Gera uma nova instancia sempre que precisar
  getIt.registerFactory<DishListStore>(
    () => DishListStore(
      getIt<IDishRepository>(),
      getIt<SearchDishesByNameOrDescriptionUseCase>(),
      getIt<FilterDishesByVeganUseCase>(),
      getIt<SortDishesUseCase>(),
    ),
  );

  // Favoritos
  getIt.registerLazySingleton<IFavoritesRepository>(
    () => ObjectBoxFavoritesRepository(getIt<Store>()),
  );

  getIt.registerLazySingleton(
    () => GetFavoriteRestaurantsUseCase(
      getIt<IRestaurantRepository>(),
      getIt<IFavoritesRepository>(),
    ),
  );

  getIt.registerLazySingleton(
    () => GetFavoriteDishesUseCase(
      getIt<IDishRepository>(),
      getIt<IFavoritesRepository>(),
    ),
  );

  getIt.registerLazySingleton(
    () => IsRestaurantFavoriteUseCase(getIt<IFavoritesRepository>()),
  );

  getIt.registerLazySingleton(
    () => ToggleFavoriteRestaurantUseCase(getIt<IFavoritesRepository>()),
  );

  getIt.registerLazySingleton(
    () => IsDishFavoriteUseCase(getIt<IFavoritesRepository>()),
  );

  getIt.registerLazySingleton(
    () => ToggleFavoriteDishUseCase(getIt<IFavoritesRepository>()),
  );

  getIt.registerLazySingleton<FavoritesStore>(
    () => FavoritesStore(
      getIt<IFavoritesRepository>(),
      getIt<IRestaurantRepository>(),
      getIt<GetFavoriteRestaurantsUseCase>(),
      getIt<GetFavoriteDishesUseCase>(),
      getIt<ToggleFavoriteRestaurantUseCase>(),
      getIt<ToggleFavoriteDishUseCase>(),
    ),
  );
}
