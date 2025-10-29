// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RestaurantListStore on _RestaurantListStore, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??= Computed<bool>(
    () => super.isLoading,
    name: '_RestaurantListStore.isLoading',
  )).value;
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError => (_$hasErrorComputed ??= Computed<bool>(
    () => super.hasError,
    name: '_RestaurantListStore.hasError',
  )).value;
  Computed<bool>? _$isEmptyComputed;

  @override
  bool get isEmpty => (_$isEmptyComputed ??= Computed<bool>(
    () => super.isEmpty,
    name: '_RestaurantListStore.isEmpty',
  )).value;

  late final _$stateAtom = Atom(
    name: '_RestaurantListStore.state',
    context: context,
  );

  @override
  RestaurantListState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(RestaurantListState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_RestaurantListStore.errorMessage',
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

  late final _$restaurantsAtom = Atom(
    name: '_RestaurantListStore.restaurants',
    context: context,
  );

  @override
  ObservableList<RestaurantDto> get restaurants {
    _$restaurantsAtom.reportRead();
    return super.restaurants;
  }

  @override
  set restaurants(ObservableList<RestaurantDto> value) {
    _$restaurantsAtom.reportWrite(value, super.restaurants, () {
      super.restaurants = value;
    });
  }

  late final _$nameQueryAtom = Atom(
    name: '_RestaurantListStore.nameQuery',
    context: context,
  );

  @override
  String get nameQuery {
    _$nameQueryAtom.reportRead();
    return super.nameQuery;
  }

  @override
  set nameQuery(String value) {
    _$nameQueryAtom.reportWrite(value, super.nameQuery, () {
      super.nameQuery = value;
    });
  }

  late final _$categoryQueryAtom = Atom(
    name: '_RestaurantListStore.categoryQuery',
    context: context,
  );

  @override
  String get categoryQuery {
    _$categoryQueryAtom.reportRead();
    return super.categoryQuery;
  }

  @override
  set categoryQuery(String value) {
    _$categoryQueryAtom.reportWrite(value, super.categoryQuery, () {
      super.categoryQuery = value;
    });
  }

  late final _$selectedCategoryAtom = Atom(
    name: '_RestaurantListStore.selectedCategory',
    context: context,
  );

  @override
  String get selectedCategory {
    _$selectedCategoryAtom.reportRead();
    return super.selectedCategory;
  }

  @override
  set selectedCategory(String value) {
    _$selectedCategoryAtom.reportWrite(value, super.selectedCategory, () {
      super.selectedCategory = value;
    });
  }

  late final _$minRatingAtom = Atom(
    name: '_RestaurantListStore.minRating',
    context: context,
  );

  @override
  double get minRating {
    _$minRatingAtom.reportRead();
    return super.minRating;
  }

  @override
  set minRating(double value) {
    _$minRatingAtom.reportWrite(value, super.minRating, () {
      super.minRating = value;
    });
  }

  late final _$maxDistanceAtom = Atom(
    name: '_RestaurantListStore.maxDistance',
    context: context,
  );

  @override
  double get maxDistance {
    _$maxDistanceAtom.reportRead();
    return super.maxDistance;
  }

  @override
  set maxDistance(double value) {
    _$maxDistanceAtom.reportWrite(value, super.maxDistance, () {
      super.maxDistance = value;
    });
  }

  late final _$filterVeganAtom = Atom(
    name: '_RestaurantListStore.filterVegan',
    context: context,
  );

  @override
  bool get filterVegan {
    _$filterVeganAtom.reportRead();
    return super.filterVegan;
  }

  @override
  set filterVegan(bool value) {
    _$filterVeganAtom.reportWrite(value, super.filterVegan, () {
      super.filterVegan = value;
    });
  }

  late final _$sortTypeAtom = Atom(
    name: '_RestaurantListStore.sortType',
    context: context,
  );

  @override
  SortType get sortType {
    _$sortTypeAtom.reportRead();
    return super.sortType;
  }

  @override
  set sortType(SortType value) {
    _$sortTypeAtom.reportWrite(value, super.sortType, () {
      super.sortType = value;
    });
  }

  late final _$loadRestaurantsAsyncAction = AsyncAction(
    '_RestaurantListStore.loadRestaurants',
    context: context,
  );

  @override
  Future<void> loadRestaurants() {
    return _$loadRestaurantsAsyncAction.run(() => super.loadRestaurants());
  }

  late final _$setNameQueryAsyncAction = AsyncAction(
    '_RestaurantListStore.setNameQuery',
    context: context,
  );

  @override
  Future<void> setNameQuery(String query) {
    return _$setNameQueryAsyncAction.run(() => super.setNameQuery(query));
  }

  late final _$setCategoryQueryAsyncAction = AsyncAction(
    '_RestaurantListStore.setCategoryQuery',
    context: context,
  );

  @override
  Future<void> setCategoryQuery(String query) {
    return _$setCategoryQueryAsyncAction.run(
      () => super.setCategoryQuery(query),
    );
  }

  late final _$setSelectedCategoryAsyncAction = AsyncAction(
    '_RestaurantListStore.setSelectedCategory',
    context: context,
  );

  @override
  Future<void> setSelectedCategory(String category) {
    return _$setSelectedCategoryAsyncAction.run(
      () => super.setSelectedCategory(category),
    );
  }

  late final _$setRatingAsyncAction = AsyncAction(
    '_RestaurantListStore.setRating',
    context: context,
  );

  @override
  Future<void> setRating(double rating) {
    return _$setRatingAsyncAction.run(() => super.setRating(rating));
  }

  late final _$setDistanceAsyncAction = AsyncAction(
    '_RestaurantListStore.setDistance',
    context: context,
  );

  @override
  Future<void> setDistance(double distance) {
    return _$setDistanceAsyncAction.run(() => super.setDistance(distance));
  }

  late final _$toggleVeganFilterAsyncAction = AsyncAction(
    '_RestaurantListStore.toggleVeganFilter',
    context: context,
  );

  @override
  Future<void> toggleVeganFilter(bool value) {
    return _$toggleVeganFilterAsyncAction.run(
      () => super.toggleVeganFilter(value),
    );
  }

  late final _$setSortAsyncAction = AsyncAction(
    '_RestaurantListStore.setSort',
    context: context,
  );

  @override
  Future<void> setSort(SortType type) {
    return _$setSortAsyncAction.run(() => super.setSort(type));
  }

  late final _$_applyFiltersAndSortAsyncAction = AsyncAction(
    '_RestaurantListStore._applyFiltersAndSort',
    context: context,
  );

  @override
  Future<void> _applyFiltersAndSort() {
    return _$_applyFiltersAndSortAsyncAction.run(
      () => super._applyFiltersAndSort(),
    );
  }

  @override
  String toString() {
    return '''
state: ${state},
errorMessage: ${errorMessage},
restaurants: ${restaurants},
nameQuery: ${nameQuery},
categoryQuery: ${categoryQuery},
selectedCategory: ${selectedCategory},
minRating: ${minRating},
maxDistance: ${maxDistance},
filterVegan: ${filterVegan},
sortType: ${sortType},
isLoading: ${isLoading},
hasError: ${hasError},
isEmpty: ${isEmpty}
    ''';
  }
}
