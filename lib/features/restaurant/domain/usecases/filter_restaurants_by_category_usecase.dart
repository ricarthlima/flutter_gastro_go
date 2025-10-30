import '../../data/repositories/i_restaurant_repository.dart';
import '../entities/restaurant_dto.dart';

class FilterRestaurantsByCategoryUseCase {
  final IRestaurantRepository restaurantRepository;

  FilterRestaurantsByCategoryUseCase(this.restaurantRepository);

  Future<List<RestaurantDto>> call(
    String category, {
    List<RestaurantDto>? restaurants,
  }) async {
    try {
      // de novo :D
      final allRestaurants = restaurants ?? await restaurantRepository.getAll();

      if (category.isEmpty) {
        return allRestaurants;
      }

      final normalizedCategory = category.toLowerCase();

      final filteredList = allRestaurants.where((restaurant) {
        return restaurant.categories.any(
          (cat) => cat.toLowerCase() == normalizedCategory,
        );
      }).toList();

      return filteredList;
    } catch (e) {
      rethrow;
    }
  }
}
