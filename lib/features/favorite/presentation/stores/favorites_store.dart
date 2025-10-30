import 'package:flutter_gastro_go/features/dish/domain/entities/dish_dto.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/entities/restaurant_dto.dart';
import 'package:mobx/mobx.dart';

import '../../data/repositories/i_favorite_repository.dart';
import '../../domain/usecases/usecases.dart';
import 'favorites_state.dart';

part 'favorites_store.g.dart';

class FavoritesStore = _FavoritesStore with _$FavoritesStore;

abstract class _FavoritesStore with Store {
  final IFavoritesRepository _favoritesRepo;
  final GetFavoriteRestaurantsUseCase _getFavoriteRestaurants;
  final GetFavoriteDishesUseCase _getFavoriteDishes;
  final ToggleFavoriteRestaurantUseCase _toggleRestaurant;
  final ToggleFavoriteDishUseCase _toggleDish;

  _FavoritesStore(
    this._favoritesRepo,
    this._getFavoriteRestaurants,
    this._getFavoriteDishes,
    this._toggleRestaurant,
    this._toggleDish,
  );

  @observable
  FavoritesState state = FavoritesState.initial;

  @observable
  String? errorMessage;

  @observable
  ObservableList<RestaurantDto> favoriteRestaurants = ObservableList();

  @observable
  ObservableList<DishDto> favoriteDishes = ObservableList();

  // global, geralzao
  @observable
  ObservableSet<String> restaurantFavoriteIds = ObservableSet<String>();

  @observable
  ObservableSet<String> dishFavoriteIds = ObservableSet<String>();

  bool isRestaurantFavorite(String id) => restaurantFavoriteIds.contains(id);

  bool isDishFavorite(String id) => dishFavoriteIds.contains(id);

  /// Carregar todos os favoritos
  @action
  Future<void> loadAllFavoriteIds() async {
    try {
      final restIds = await _favoritesRepo.getFavoriteRestaurantIds();
      final dishIds = await _favoritesRepo.getFavoriteDishIds();

      restaurantFavoriteIds = ObservableSet.of(restIds);
      dishFavoriteIds = ObservableSet.of(dishIds);
    } catch (e) {
      // Falha silenciosa na inicialização, ou logar
      print("Erro ao carregar IDs de favoritos: $e");
    }
  }

  /// Carrega os DTOs para usarmos na tela
  @action
  Future<void> loadFavoritesScreenData() async {
    state = FavoritesState.loading;
    errorMessage = null;
    try {
      // Roda as duas buscas em paralelo
      final results = await Future.wait([
        _getFavoriteRestaurants.call(),
        _getFavoriteDishes.call(),
      ]);

      favoriteRestaurants = ObservableList.of(
        results[0] as List<RestaurantDto>,
      );
      favoriteDishes = ObservableList.of(results[1] as List<DishDto>);

      state = FavoritesState.success;
    } catch (e) {
      errorMessage = "Erro ao carregar favoritos: $e";
      state = FavoritesState.error;
    }
  }

  /// Alterna restaurante
  @action
  Future<void> toggleRestaurantFavorite(String restaurantId) async {
    try {
      final bool isNowFavorite = await _toggleRestaurant.call(restaurantId);

      // Atualiza o Set reativo instantaneamente
      if (isNowFavorite) {
        restaurantFavoriteIds.add(restaurantId);
      } else {
        restaurantFavoriteIds.remove(restaurantId);
      }
    } catch (e) {
      // Tratar erro na UI (ex: com um SnackBar)
      print("Erro ao alternar favorito: $e");
    }
  }

  /// Alterna prato
  @action
  Future<void> toggleDishFavorite({
    required String dishId,
    String? restaurantId,
  }) async {
    try {
      final bool isNowFavorite = await _toggleDish.call(
        dishId: dishId,
        restaurantId: restaurantId,
      );

      // Atualiza o Set reativo instantaneamente
      if (isNowFavorite) {
        dishFavoriteIds.add(dishId);
      } else {
        dishFavoriteIds.remove(dishId);
      }
    } catch (e) {
      print("Erro ao alternar favorito: $e");
    }
  }
}
