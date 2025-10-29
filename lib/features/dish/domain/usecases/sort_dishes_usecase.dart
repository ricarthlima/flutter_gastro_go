import 'package:flutter_gastro_go/features/dish/domain/entities/dish_dto.dart';

enum SortDishType { byPrice, byName }

class SortDishesUseCase {
  List<DishDto> call({
    required List<DishDto> dishes,
    required SortDishType sortType,
  }) {
    final sortedList = List<DishDto>.from(dishes);

    switch (sortType) {
      case SortDishType.byPrice:
        sortedList.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortDishType.byName:
        sortedList.sort((a, b) => a.name.compareTo(b.name));
        break;
    }

    return sortedList;
  }
}
