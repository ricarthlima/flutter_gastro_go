import '../../domain/usecases/sort_restaurants_usecase.dart';

class RestaurantFilterModel {
  final SortType sortType;
  final double minRating;
  final double maxDistance;
  final bool filterVegan;

  RestaurantFilterModel({
    required this.sortType,
    required this.minRating,
    required this.maxDistance,
    required this.filterVegan,
  });

  RestaurantFilterModel copyWith({
    SortType? sortType,
    double? minRating,
    double? maxDistance,
    bool? filterVegan,
  }) {
    return RestaurantFilterModel(
      sortType: sortType ?? this.sortType,
      minRating: minRating ?? this.minRating,
      maxDistance: maxDistance ?? this.maxDistance,
      filterVegan: filterVegan ?? this.filterVegan,
    );
  }
}
