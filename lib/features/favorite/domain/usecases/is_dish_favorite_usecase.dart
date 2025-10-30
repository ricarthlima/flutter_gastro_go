import '../../data/repositories/i_favorite_repository.dart';

class IsDishFavoriteUseCase {
  final IFavoritesRepository _favoritesRepo;

  IsDishFavoriteUseCase(this._favoritesRepo);

  Future<bool> call(String dishId) async {
    return _favoritesRepo.isDishFavorite(dishId);
  }
}
