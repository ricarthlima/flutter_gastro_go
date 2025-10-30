import '../../data/repositories/i_favorite_repository.dart';

class ToggleFavoriteDishUseCase {
  final IFavoritesRepository _favoritesRepo;

  ToggleFavoriteDishUseCase(this._favoritesRepo);

  /// Adiciona se não for favorito, remove se for.
  Future<bool> call({required String dishId, String? restaurantId}) async {
    final isCurrentlyFavorite = await _favoritesRepo.isDishFavorite(dishId);

    if (isCurrentlyFavorite) {
      await _favoritesRepo.removeFavoriteDish(dishId);
      return false;
    } else {
      await _favoritesRepo.addFavoriteDish(dishId, restaurantId: restaurantId);
      return true;
    }
  }
}
