import 'package:flutter_gastro_go/features/restaurant/domain/entities/restaurant_dto.dart';

enum SortType { byRating, byDistance }

class SortRestaurantsUseCase {
  List<RestaurantDto> call({
    required List<RestaurantDto> restaurants,
    required SortType sortType,
  }) {
    final sortedList = List<RestaurantDto>.from(restaurants);

    switch (sortType) {
      case SortType.byRating:
        sortedList.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case SortType.byDistance:
        sortedList.sort((a, b) => a.distance.compareTo(b.distance));
        break;
    }

    return sortedList;
  }
}
