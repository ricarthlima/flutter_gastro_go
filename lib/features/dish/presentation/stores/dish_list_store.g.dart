// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dish_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DishListStore on _DishListStore, Store {
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??= Computed<bool>(
    () => super.isLoading,
    name: '_DishListStore.isLoading',
  )).value;
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError => (_$hasErrorComputed ??= Computed<bool>(
    () => super.hasError,
    name: '_DishListStore.hasError',
  )).value;
  Computed<bool>? _$isEmptyComputed;

  @override
  bool get isEmpty => (_$isEmptyComputed ??= Computed<bool>(
    () => super.isEmpty,
    name: '_DishListStore.isEmpty',
  )).value;

  late final _$stateAtom = Atom(name: '_DishListStore.state', context: context);

  @override
  DishListState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(DishListState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_DishListStore.errorMessage',
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

  late final _$dishesAtom = Atom(
    name: '_DishListStore.dishes',
    context: context,
  );

  @override
  ObservableList<DishDto> get dishes {
    _$dishesAtom.reportRead();
    return super.dishes;
  }

  @override
  set dishes(ObservableList<DishDto> value) {
    _$dishesAtom.reportWrite(value, super.dishes, () {
      super.dishes = value;
    });
  }

  late final _$searchQueryAtom = Atom(
    name: '_DishListStore.searchQuery',
    context: context,
  );

  @override
  String get searchQuery {
    _$searchQueryAtom.reportRead();
    return super.searchQuery;
  }

  @override
  set searchQuery(String value) {
    _$searchQueryAtom.reportWrite(value, super.searchQuery, () {
      super.searchQuery = value;
    });
  }

  late final _$filterVeganAtom = Atom(
    name: '_DishListStore.filterVegan',
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
    name: '_DishListStore.sortType',
    context: context,
  );

  @override
  SortDishType get sortType {
    _$sortTypeAtom.reportRead();
    return super.sortType;
  }

  @override
  set sortType(SortDishType value) {
    _$sortTypeAtom.reportWrite(value, super.sortType, () {
      super.sortType = value;
    });
  }

  late final _$loadDishesAsyncAction = AsyncAction(
    '_DishListStore.loadDishes',
    context: context,
  );

  @override
  Future<void> loadDishes(String restaurantId) {
    return _$loadDishesAsyncAction.run(() => super.loadDishes(restaurantId));
  }

  late final _$setSearchQueryAsyncAction = AsyncAction(
    '_DishListStore.setSearchQuery',
    context: context,
  );

  @override
  Future<void> setSearchQuery(String query) {
    return _$setSearchQueryAsyncAction.run(() => super.setSearchQuery(query));
  }

  late final _$toggleVeganFilterAsyncAction = AsyncAction(
    '_DishListStore.toggleVeganFilter',
    context: context,
  );

  @override
  Future<void> toggleVeganFilter(bool value) {
    return _$toggleVeganFilterAsyncAction.run(
      () => super.toggleVeganFilter(value),
    );
  }

  late final _$setSortAsyncAction = AsyncAction(
    '_DishListStore.setSort',
    context: context,
  );

  @override
  Future<void> setSort(SortDishType type) {
    return _$setSortAsyncAction.run(() => super.setSort(type));
  }

  late final _$_applyFiltersAndSortAsyncAction = AsyncAction(
    '_DishListStore._applyFiltersAndSort',
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
dishes: ${dishes},
searchQuery: ${searchQuery},
filterVegan: ${filterVegan},
sortType: ${sortType},
isLoading: ${isLoading},
hasError: ${hasError},
isEmpty: ${isEmpty}
    ''';
  }
}
