import '../../data/repositories/i_favorite_repository.dart';

class ToggleFavoriteRestaurantUseCase {
  final IFavoritesRepository _favoritesRepo;

  ToggleFavoriteRestaurantUseCase(this._favoritesRepo);

  /// Adiciona se não for favorito, remove se for.
  Future<bool> call(String restaurantId) async {
    final isCurrentlyFavorite = await _favoritesRepo.isRestaurantFavorite(
      restaurantId,
    );

    if (isCurrentlyFavorite) {
      await _favoritesRepo.removeFavoriteRestaurant(restaurantId);
      return false; // nao favorito
    } else {
      await _favoritesRepo.addFavoriteRestaurant(restaurantId);
      return true; // favorito
    }
  }
}
