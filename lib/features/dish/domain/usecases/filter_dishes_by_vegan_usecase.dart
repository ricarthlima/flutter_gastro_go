import 'package:flutter_gastro_go/features/dish/domain/entities/dish_dto.dart';

import '../../data/repositories/i_dish_repository.dart';

class FilterDishesByVeganUseCase {
  final IDishRepository dishRepository;

  FilterDishesByVeganUseCase(this.dishRepository);

  Future<List<DishDto>> call({List<DishDto>? dishes}) async {
    try {
      final allDishes = dishes ?? await dishRepository.getAll();

      final filteredList = allDishes.where((dish) {
        return dish.isVegan;
      }).toList();

      return filteredList;
    } catch (e) {
      rethrow;
    }
  }
}
