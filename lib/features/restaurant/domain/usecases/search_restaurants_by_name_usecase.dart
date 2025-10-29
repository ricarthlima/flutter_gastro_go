import 'package:flutter_gastro_go/features/restaurant/domain/entities/restaurant_dto.dart';
import 'package:flutter_gastro_go/features/restaurant/data/repositories/i_restaurant_repository.dart';

class SearchRestaurantsByNameUseCase {
  final IRestaurantRepository restaurantRepository;
  SearchRestaurantsByNameUseCase(this.restaurantRepository);

  Future<List<RestaurantDto>> call(String query) async {
    try {
      // No mundo ideal, isso ficaria com o backend ne
      final allRestaurants = await restaurantRepository.getAll();

      //Se a busca for vazia, retorna tudo
      if (query.isEmpty) {
        return allRestaurants;
      }

      final normalizedQuery = query.toLowerCase();

      final filteredList = allRestaurants.where((restaurant) {
        final normalizedName = restaurant.name.toLowerCase();
        return normalizedName.contains(normalizedQuery);
      }).toList();

      return filteredList;
    } catch (e) {
      rethrow;
    }
  }
}
