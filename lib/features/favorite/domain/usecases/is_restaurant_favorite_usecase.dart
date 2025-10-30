import '../../data/repositories/i_favorite_repository.dart';

class IsRestaurantFavoriteUseCase {
  final IFavoritesRepository _favoritesRepo;

  IsRestaurantFavoriteUseCase(this._favoritesRepo);

  Future<bool> call(String restaurantId) async {
    return _favoritesRepo.isRestaurantFavorite(restaurantId);
  }
}
