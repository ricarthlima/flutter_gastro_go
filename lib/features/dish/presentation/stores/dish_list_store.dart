import 'package:flutter_gastro_go/features/dish/domain/entities/dish_dto.dart';
import 'package:mobx/mobx.dart';

import '../../data/repositories/i_dish_repository.dart';
import 'dish_list_state.dart';

import '../../domain/usecases/usecases.dart';

part 'dish_list_store.g.dart';

class DishListStore = _DishListStore with _$DishListStore;

abstract class _DishListStore with Store {
  final IDishRepository _dishRepository;

  final SearchDishesByNameOrDescriptionUseCase _search;
  final FilterDishesByVeganUseCase _filterVegan;
  final SortDishesUseCase _sort;

  _DishListStore(
    this._dishRepository,
    this._search,
    this._filterVegan,
    this._sort,
  );

  // fonte da verdade
  List<DishDto> _masterList = [];
  String _currentRestaurantId = '';

  // estaod
  @observable
  DishListState state = DishListState.initial;

  @observable
  String? errorMessage;

  @observable
  ObservableList<DishDto> dishes = ObservableList<DishDto>();

  // filtros
  @observable
  String searchQuery = '';

  @observable
  bool filterVegan = false;

  @observable
  SortDishType sortType = SortDishType.byName;

  // computados
  @computed
  bool get isLoading => state == DishListState.loading;

  @computed
  bool get hasError => state == DishListState.error;

  @computed
  bool get isEmpty => state == DishListState.success && dishes.isEmpty;

  // carregar
  @action
  Future<void> loadDishes(String restaurantId) async {
    // Evita recarregar se já estiver na tela do mesmo restaurante
    if (state == DishListState.loading ||
        restaurantId == _currentRestaurantId) {
      return;
    }

    state = DishListState.loading;
    errorMessage = null;
    _currentRestaurantId = restaurantId;

    try {
      // 1. Busca os dados brutos UMA VEZ (filtrado pelo restaurante)
      _masterList = await _dishRepository.getByRestaurantId(
        restaurantId: restaurantId,
      );

      // 2. Aplica os filtros e ordenação
      await _applyFiltersAndSort();
      state = DishListState.success;
    } catch (e) {
      errorMessage = "Falha ao carregar pratos: $e";
      state = DishListState.error;
    }
  }

  // filtrar e pipelinezar

  @action
  Future<void> setSearchQuery(String query) async {
    searchQuery = query;
    await _applyFiltersAndSort();
  }

  @action
  Future<void> toggleVeganFilter(bool value) async {
    filterVegan = value;
    await _applyFiltersAndSort();
  }

  @action
  Future<void> setSort(SortDishType type) async {
    sortType = type;
    await _applyFiltersAndSort();
  }

  // o pipeline
  @action
  Future<void> _applyFiltersAndSort() async {
    if (_masterList.isEmpty && state != DishListState.loading) return;

    errorMessage = null;

    try {
      List<DishDto> filteredList = List.from(_masterList);

      // 1. Pipeline de UseCases
      filteredList = await _search.call(searchQuery, dishes: filteredList);

      filteredList = await _filterVegan.call(filterVegan, dishes: filteredList);

      // 2. Ordenação
      final sortedList = _sort.call(dishes: filteredList, sortType: sortType);

      // 3. Atualiza a UI
      dishes = ObservableList.of(sortedList);
      state = DishListState.success;
    } catch (e) {
      errorMessage = "Erro ao aplicar filtro: $e";
      state = DishListState.error;
    }
  }
}
