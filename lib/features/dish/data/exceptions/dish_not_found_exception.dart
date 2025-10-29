class DishNotFoundException implements Exception {
  final String message;
  DishNotFoundException({required this.message});

  @override
  String toString() {
    return 'RestaurantNotFoundException: $message';
  }
}
