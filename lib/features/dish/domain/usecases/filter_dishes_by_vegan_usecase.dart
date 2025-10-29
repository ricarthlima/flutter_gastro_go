import 'package:flutter_gastro_go/features/dish/domain/entities/dish_dto.dart';
import '../../data/repositories/i_dish_repository.dart';

class FilterDishesByVeganUseCase {
  final IDishRepository dishRepository;
  FilterDishesByVeganUseCase(this.dishRepository);

  Future<List<DishDto>> call(bool isVegan, {List<DishDto>? dishes}) async {
    try {
      // Se o filtro não estiver ativo, retorna a lista como está
      if (!isVegan) {
        return dishes ?? await dishRepository.getAll();
      }

      final listToFilter = dishes ?? await dishRepository.getAll();

      final filteredList = listToFilter.where((dish) {
        return dish.isVegan;
      }).toList();

      return filteredList;
    } catch (e) {
      rethrow;
    }
  }
}
