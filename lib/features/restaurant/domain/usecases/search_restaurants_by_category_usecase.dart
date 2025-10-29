import 'package:flutter_gastro_go/features/restaurant/data/repositories/i_restaurant_repository.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/entities/restaurant_dto.dart';

class SearchRestaurantsByCategoryUseCase {
  final IRestaurantRepository restaurantRepository;

  SearchRestaurantsByCategoryUseCase(this.restaurantRepository);

  Future<List<RestaurantDto>> call(
    String query, {
    List<RestaurantDto>? restaurants,
  }) async {
    try {
      final allRestaurants = restaurants ?? await restaurantRepository.getAll();

      if (query.isEmpty) {
        return allRestaurants;
      }

      final normalizedQuery = query.toLowerCase();

      final filteredList = allRestaurants.where((restaurant) {
        return restaurant.categories.any(
          (category) => category.toLowerCase().contains(normalizedQuery),
        );
      }).toList();

      return filteredList;
    } catch (e) {
      rethrow;
    }
  }
}
