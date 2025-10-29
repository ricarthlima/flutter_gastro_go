class RestaurantNotFoundException implements Exception {
  final String message;
  RestaurantNotFoundException({required this.message});

  @override
  String toString() {
    return 'RestaurantNotFoundException: $message';
  }
}
