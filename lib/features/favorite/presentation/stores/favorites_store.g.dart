// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FavoritesStore on _FavoritesStore, Store {
  late final _$stateAtom = Atom(
    name: '_FavoritesStore.state',
    context: context,
  );

  @override
  FavoritesState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(FavoritesState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_FavoritesStore.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$favoriteRestaurantsAtom = Atom(
    name: '_FavoritesStore.favoriteRestaurants',
    context: context,
  );

  @override
  ObservableList<RestaurantDto> get favoriteRestaurants {
    _$favoriteRestaurantsAtom.reportRead();
    return super.favoriteRestaurants;
  }

  @override
  set favoriteRestaurants(ObservableList<RestaurantDto> value) {
    _$favoriteRestaurantsAtom.reportWrite(value, super.favoriteRestaurants, () {
      super.favoriteRestaurants = value;
    });
  }

  late final _$favoriteDishesAtom = Atom(
    name: '_FavoritesStore.favoriteDishes',
    context: context,
  );

  @override
  ObservableList<DishDto> get favoriteDishes {
    _$favoriteDishesAtom.reportRead();
    return super.favoriteDishes;
  }

  @override
  set favoriteDishes(ObservableList<DishDto> value) {
    _$favoriteDishesAtom.reportWrite(value, super.favoriteDishes, () {
      super.favoriteDishes = value;
    });
  }

  late final _$allRestaurantsAtom = Atom(
    name: '_FavoritesStore.allRestaurants',
    context: context,
  );

  @override
  ObservableList<RestaurantDto> get allRestaurants {
    _$allRestaurantsAtom.reportRead();
    return super.allRestaurants;
  }

  @override
  set allRestaurants(ObservableList<RestaurantDto> value) {
    _$allRestaurantsAtom.reportWrite(value, super.allRestaurants, () {
      super.allRestaurants = value;
    });
  }

  late final _$restaurantFavoriteIdsAtom = Atom(
    name: '_FavoritesStore.restaurantFavoriteIds',
    context: context,
  );

  @override
  ObservableSet<String> get restaurantFavoriteIds {
    _$restaurantFavoriteIdsAtom.reportRead();
    return super.restaurantFavoriteIds;
  }

  @override
  set restaurantFavoriteIds(ObservableSet<String> value) {
    _$restaurantFavoriteIdsAtom.reportWrite(
      value,
      super.restaurantFavoriteIds,
      () {
        super.restaurantFavoriteIds = value;
      },
    );
  }

  late final _$dishFavoriteIdsAtom = Atom(
    name: '_FavoritesStore.dishFavoriteIds',
    context: context,
  );

  @override
  ObservableSet<String> get dishFavoriteIds {
    _$dishFavoriteIdsAtom.reportRead();
    return super.dishFavoriteIds;
  }

  @override
  set dishFavoriteIds(ObservableSet<String> value) {
    _$dishFavoriteIdsAtom.reportWrite(value, super.dishFavoriteIds, () {
      super.dishFavoriteIds = value;
    });
  }

  late final _$loadAllFavoriteIdsAsyncAction = AsyncAction(
    '_FavoritesStore.loadAllFavoriteIds',
    context: context,
  );

  @override
  Future<void> loadAllFavoriteIds() {
    return _$loadAllFavoriteIdsAsyncAction.run(
      () => super.loadAllFavoriteIds(),
    );
  }

  late final _$loadFavoritesScreenDataAsyncAction = AsyncAction(
    '_FavoritesStore.loadFavoritesScreenData',
    context: context,
  );

  @override
  Future<void> loadFavoritesScreenData() {
    return _$loadFavoritesScreenDataAsyncAction.run(
      () => super.loadFavoritesScreenData(),
    );
  }

  late final _$toggleRestaurantFavoriteAsyncAction = AsyncAction(
    '_FavoritesStore.toggleRestaurantFavorite',
    context: context,
  );

  @override
  Future<void> toggleRestaurantFavorite(String restaurantId) {
    return _$toggleRestaurantFavoriteAsyncAction.run(
      () => super.toggleRestaurantFavorite(restaurantId),
    );
  }

  late final _$toggleDishFavoriteAsyncAction = AsyncAction(
    '_FavoritesStore.toggleDishFavorite',
    context: context,
  );

  @override
  Future<void> toggleDishFavorite({
    required String dishId,
    String? restaurantId,
  }) {
    return _$toggleDishFavoriteAsyncAction.run(
      () =>
          super.toggleDishFavorite(dishId: dishId, restaurantId: restaurantId),
    );
  }

  @override
  String toString() {
    return '''
state: ${state},
errorMessage: ${errorMessage},
favoriteRestaurants: ${favoriteRestaurants},
favoriteDishes: ${favoriteDishes},
allRestaurants: ${allRestaurants},
restaurantFavoriteIds: ${restaurantFavoriteIds},
dishFavoriteIds: ${dishFavoriteIds}
    ''';
  }
}
