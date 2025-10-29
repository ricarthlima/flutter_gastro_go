import 'package:flutter_gastro_go/features/restaurant/data/repositories/i_restaurant_repository.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/entities/restaurant_dto.dart';

class FilterRestaurantsByDistanceUseCase {
  final IRestaurantRepository restaurantRepository;

  FilterRestaurantsByDistanceUseCase(this.restaurantRepository);

  Future<List<RestaurantDto>> call(
    double maxDistance, {
    List<RestaurantDto>? restaurants,
  }) async {
    try {
      final allRestaurants = restaurants ?? await restaurantRepository.getAll();

      if (maxDistance <= 0) {
        return allRestaurants;
      }

      final filteredList = allRestaurants.where((restaurant) {
        return restaurant.distance <= maxDistance;
      }).toList();

      return filteredList;
    } catch (e) {
      rethrow;
    }
  }
}
