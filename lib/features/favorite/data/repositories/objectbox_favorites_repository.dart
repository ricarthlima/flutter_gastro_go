// 1. A classe implementa o contrato que definimos
import '../../../../objectbox.g.dart';
import '../../domain/entities/favorite_dish_entity.dart';
import '../../domain/entities/favorite_restaurant_entity.dart';
import 'i_favorite_repository.dart';

class ObjectBoxFavoritesRepository implements IFavoritesRepository {
  final Store _store;
  late final Box<FavoriteRestaurantEntity> _restaurantBox;
  late final Box<FavoriteDishEntity> _dishBox;

  ObjectBoxFavoritesRepository(this._store) {
    _restaurantBox = _store.box<FavoriteRestaurantEntity>();
    _dishBox = _store.box<FavoriteDishEntity>();
  }

  // RESTAURANTES

  @override
  Future<void> addFavoriteRestaurant(String restaurantId) async {
    // Evita duplicatas
    if (await isRestaurantFavorite(restaurantId)) return;

    final entity = FavoriteRestaurantEntity()..restaurantId = restaurantId;

    await _restaurantBox.putAsync(entity);
  }

  @override
  Future<List<String>> getFavoriteRestaurantIds() async {
    final query = _restaurantBox.query().build();
    final results = await query.findAsync();
    query.close();

    return results.map((entity) => entity.restaurantId).toList();
  }

  @override
  Future<bool> isRestaurantFavorite(String restaurantId) async {
    // Constrói uma query: "Busque onde 'restaurantId' == restaurantId"
    final query = _restaurantBox
        .query(FavoriteRestaurantEntity_.restaurantId.equals(restaurantId))
        .build();

    final count = query.count();
    query.close();

    return count > 0;
  }

  @override
  Future<void> removeFavoriteRestaurant(String restaurantId) async {
    final query = _restaurantBox
        .query(FavoriteRestaurantEntity_.restaurantId.equals(restaurantId))
        .build();

    final result = await query.findFirstAsync();
    query.close();

    if (result != null) {
      await _restaurantBox.removeAsync(result.id);
    }
  }

  // RPATOS

  @override
  Future<void> addFavoriteDish(String dishId, {String? restaurantId}) async {
    if (await isDishFavorite(dishId)) return;

    final entity = FavoriteDishEntity()
      ..dishId = dishId
      ..restaurantId = restaurantId; // Salva o ID do restaurante (opcional)

    await _dishBox.putAsync(entity);
  }

  @override
  Future<List<String>> getFavoriteDishIds() async {
    final query = _dishBox.query().build();
    final results = await query.findAsync();
    query.close();

    return results.map((entity) => entity.dishId).toList();
  }

  @override
  Future<bool> isDishFavorite(String dishId) async {
    final query = _dishBox
        .query(FavoriteDishEntity_.dishId.equals(dishId))
        .build();

    final count = query.count();
    query.close();

    return count > 0;
  }

  @override
  Future<void> removeFavoriteDish(String dishId) async {
    final query = _dishBox
        .query(FavoriteDishEntity_.dishId.equals(dishId))
        .build();

    final result = await query.findFirstAsync();
    query.close();

    if (result != null) {
      await _dishBox.removeAsync(result.id);
    }
  }
}
