import '../../domain/entities/restaurant_dto.dart';
import 'package:mobx/mobx.dart';

import '../../data/repositories/i_restaurant_repository.dart';
import 'restaurant_list_state.dart';

import '../../domain/usecases/usecases.dart';

part 'restaurant_list_store.g.dart';

class RestaurantListStore = _RestaurantListStore with _$RestaurantListStore;

abstract class _RestaurantListStore with Store {
  final IRestaurantRepository _restaurantRepository;

  // caos de uso
  final SearchRestaurantsByNameUseCase _searchByName;
  final FilterRestaurantsByCategoryUseCase _filterByCategory;
  final SearchRestaurantsByCategoryUseCase _searchByCategory;
  final FilterRestaurantsByDistanceUseCase _filterByDistance;
  final FilterRestaurantsByRatingUseCase _filterByRating;
  final FilterRestaurantsWithVeganDishesUseCase _filterVegan;
  final SortRestaurantsUseCase _sort;

  _RestaurantListStore(
    this._restaurantRepository,
    this._searchByName,
    this._filterByCategory,
    this._searchByCategory,
    this._filterByDistance,
    this._filterByRating,
    this._filterVegan,
    this._sort,
  );

  // essa vai servir como fonte da vdd, por isso não é observavel
  List<RestaurantDto> _masterList = [];

  // estado
  @observable
  RestaurantListState state = RestaurantListState.initial;

  @observable
  String? errorMessage;

  @observable
  ObservableList<RestaurantDto> restaurants = ObservableList<RestaurantDto>();

  // filtros
  @observable
  String nameQuery = '';

  @observable
  String categoryQuery = '';

  @observable
  String selectedCategory = '';

  @observable
  double minRating = 0;

  @observable
  double maxDistance = 0;

  @observable
  bool filterVegan = false;

  @observable
  SortType sortType = SortType.byDistance;

  // estados computados
  @computed
  bool get isLoading => state == RestaurantListState.loading;

  @computed
  bool get hasError => state == RestaurantListState.error;

  @computed
  bool get isEmpty =>
      state == RestaurantListState.success && restaurants.isEmpty;

  // carregar
  @action
  Future<void> loadRestaurants() async {
    state = RestaurantListState.loading;
    errorMessage = null;
    try {
      _masterList = await _restaurantRepository.getAll();
      await _applyFiltersAndSort();
      state = RestaurantListState.success;
    } catch (e) {
      errorMessage = "Falha ao carregar restaurantes: $e";
      state = RestaurantListState.error;
    }
  }

  // acoes dos filtros
  // cada uma atualiza seu observable e re-executa o pipeline
  @action
  Future<void> setNameQuery(String query) async {
    nameQuery = query;
    await _applyFiltersAndSort();
  }

  @action
  Future<void> setCategoryQuery(String query) async {
    categoryQuery = query;
    await _applyFiltersAndSort();
  }

  @action
  Future<void> setSelectedCategory(String category) async {
    selectedCategory = category;
    await _applyFiltersAndSort();
  }

  @action
  Future<void> setRating(double rating) async {
    minRating = rating;
    await _applyFiltersAndSort();
  }

  @action
  Future<void> setDistance(double distance) async {
    maxDistance = distance;
    await _applyFiltersAndSort();
  }

  @action
  Future<void> toggleVeganFilter(bool value) async {
    filterVegan = value;
    await _applyFiltersAndSort();
  }

  @action
  Future<void> setSort(SortType type) async {
    sortType = type;
    await _applyFiltersAndSort();
  }

  // pipeline de filtragem
  @action
  Future<void> _applyFiltersAndSort() async {
    if (_masterList.isEmpty && state != RestaurantListState.loading) return;

    state = RestaurantListState.loading;
    errorMessage = null;

    try {
      List<RestaurantDto> filteredList = List.from(_masterList);

      // 1. Pipeline de UseCases (com a lista otimizada)
      filteredList = await _searchByName.call(
        nameQuery,
        restaurants: filteredList,
      );

      filteredList = await _searchByCategory.call(
        categoryQuery,
        restaurants: filteredList,
      );

      filteredList = await _filterByCategory.call(
        selectedCategory,
        restaurants: filteredList,
      );

      filteredList = await _filterByRating.call(
        minRating,
        restaurants: filteredList,
      );

      filteredList = await _filterByDistance.call(
        maxDistance,
        restaurants: filteredList,
      );

      // 2. Filtro Vegano (Lógica especial)
      if (filterVegan) {
        // O UseCase busca todos os restaurantes/pratos internamente
        final allVeganRestaurants = await _filterVegan.call();
        final veganIds = allVeganRestaurants.map((r) => r.id).toSet();

        filteredList = filteredList
            .where((r) => veganIds.contains(r.id))
            .toList();
      }

      // 3. Ordenação
      final sortedList = _sort.call(
        restaurants: filteredList,
        sortType: sortType,
      );

      // 4. Atualiza a UI
      restaurants = ObservableList.of(sortedList);
      state = RestaurantListState.success;
    } catch (e) {
      errorMessage = "Erro ao aplicar filtro: $e";
      state = RestaurantListState.error;
    }
  }
}
