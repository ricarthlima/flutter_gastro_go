import 'package:flutter_gastro_go/features/dish/data/repositories/i_dish_repository.dart';
import 'package:flutter_gastro_go/features/dish/domain/entities/dish_dto.dart';

class SearchDishesByNameOrDescriptionUseCase {
  final IDishRepository dishRepository;

  SearchDishesByNameOrDescriptionUseCase(this.dishRepository);

  Future<List<DishDto>> call(String query, {List<DishDto>? dishes}) async {
    try {
      final allDishes = dishes ?? await dishRepository.getAll();

      if (query.isEmpty) {
        return allDishes;
      }

      final normalizedQuery = query.toLowerCase();

      final filteredList = allDishes.where((dish) {
        final normalizedName = dish.name.toLowerCase();
        final normalizedDescription = dish.description.toLowerCase();

        return normalizedName.contains(normalizedQuery) ||
            normalizedDescription.contains(normalizedQuery);
      }).toList();

      return filteredList;
    } catch (e) {
      rethrow;
    }
  }
}
