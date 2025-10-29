import 'package:flutter_gastro_go/features/restaurant/data/repositories/i_restaurant_repository.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/entities/restaurant_dto.dart';

class FilterRestaurantsByRatingUseCase {
  final IRestaurantRepository restaurantRepository;

  FilterRestaurantsByRatingUseCase(this.restaurantRepository);

  Future<List<RestaurantDto>> call(
    double minRating, {
    List<RestaurantDto>? restaurants,
  }) async {
    try {
      final allRestaurants = restaurants ?? await restaurantRepository.getAll();

      if (minRating <= 0) {
        return allRestaurants;
      }

      final filteredList = allRestaurants.where((restaurant) {
        return restaurant.rating >= minRating;
      }).toList();

      return filteredList;
    } catch (e) {
      rethrow;
    }
  }
}
