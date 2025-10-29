import 'package:flutter_gastro_go/features/dish/data/repositories/i_dish_repository.dart';
import 'package:flutter_gastro_go/features/restaurant/data/repositories/i_restaurant_repository.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/entities/restaurant_dto.dart';

class FilterRestaurantsWithVeganDishesUseCase {
  final IRestaurantRepository restaurantRepository;
  final IDishRepository dishRepository;

  FilterRestaurantsWithVeganDishesUseCase({
    required this.restaurantRepository,
    required this.dishRepository,
  });

  Future<List<RestaurantDto>> call() async {
    try {
      // tmb seria uma logica de backend, mas tamo ai
      final allRestaurants = await restaurantRepository.getAll();
      final allDishes = await dishRepository.getAll();

      final veganDishes = allDishes.where((dish) => dish.isVegan);

      final veganRestaurantIds = veganDishes
          .map((dish) => dish.restaurantId)
          .toSet();

      final filteredList = allRestaurants.where((restaurant) {
        return veganRestaurantIds.contains(restaurant.id);
      }).toList();

      return filteredList;
    } catch (e) {
      rethrow;
    }
  }
}
