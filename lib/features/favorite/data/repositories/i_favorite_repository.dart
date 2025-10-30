abstract class IFavoritesRepository {
  // Restaurantes
  Future<void> addFavoriteRestaurant(String restaurantId);
  Future<void> removeFavoriteRestaurant(String restaurantId);
  Future<bool> isRestaurantFavorite(String restaurantId);
  Future<List<String>> getFavoriteRestaurantIds();

  // Pratos
  Future<void> addFavoriteDish(String dishId, {String? restaurantId});
  Future<void> removeFavoriteDish(String dishId);
  Future<bool> isDishFavorite(String dishId);
  Future<List<String>> getFavoriteDishIds();
}
