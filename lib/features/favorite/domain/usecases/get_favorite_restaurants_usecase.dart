import 'package:flutter_gastro_go/features/restaurant/data/repositories/i_restaurant_repository.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/entities/restaurant_dto.dart';

import '../../data/repositories/i_favorite_repository.dart';

class GetFavoriteRestaurantsUseCase {
  final IRestaurantRepository _restaurantRepo;
  final IFavoritesRepository _favoritesRepo;

  GetFavoriteRestaurantsUseCase(this._restaurantRepo, this._favoritesRepo);

  Future<List<RestaurantDto>> call() async {
    try {
      final allRestaurants = await _restaurantRepo.getAll();
      final favoriteIds = await _favoritesRepo.getFavoriteRestaurantIds();

      // buscas em O(1)
      final favoriteIdSet = favoriteIds.toSet();

      return allRestaurants
          .where((restaurant) => favoriteIdSet.contains(restaurant.id))
          .toList();
    } catch (e) {
      // Propaga o erro para o mobx tratar
      rethrow;
    }
  }
}
