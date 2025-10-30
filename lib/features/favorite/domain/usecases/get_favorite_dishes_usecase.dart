import 'package:flutter_gastro_go/features/dish/data/repositories/i_dish_repository.dart';
import 'package:flutter_gastro_go/features/dish/domain/entities/dish_dto.dart';

import '../../data/repositories/i_favorite_repository.dart';

class GetFavoriteDishesUseCase {
  final IDishRepository _dishRepo;
  final IFavoritesRepository _favoritesRepo;

  GetFavoriteDishesUseCase(this._dishRepo, this._favoritesRepo);

  Future<List<DishDto>> call() async {
    try {
      final allDishes = await _dishRepo.getAll();

      final favoriteIds = await _favoritesRepo.getFavoriteDishIds();
      final favoriteIdSet = favoriteIds.toSet();

      return allDishes
          .where((dish) => favoriteIdSet.contains(dish.id))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
