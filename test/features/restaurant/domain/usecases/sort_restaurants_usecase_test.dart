import 'package:flutter_gastro_go/features/restaurant/domain/entities/restaurant_dto.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/usecases/sort_restaurants_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late SortRestaurantsUseCase useCase;
  late List<RestaurantDto> tRestaurantList;

  final r1 = RestaurantDto(
    id: 'r1',
    name: 'Restaurante A',
    description: 'Desc',
    distance: 5, // 5 km
    categories: ['Brasileira'],
    rating: 4.5, // Rating 4.5
  );
  final r2 = RestaurantDto(
    id: 'r2',
    name: 'Restaurante B',
    description: 'Desc',
    distance: 1, // 1 km
    categories: ['Italiana'],
    rating: 4.8, // Rating 4.8
  );
  final r3 = RestaurantDto(
    id: 'r3',
    name: 'Restaurante C',
    description: 'Desc',
    distance: 2, // 2 km
    categories: ['Churrascaria'],
    rating: 4.2, // Rating 4.2
  );

  setUp(() {
    useCase = SortRestaurantsUseCase();
    tRestaurantList = [r1, r2, r3];
  });

  test('deve ordenar a lista por rating (do maior para o menor)', () {
    final result = useCase.call(
      restaurants: tRestaurantList,
      sortType: SortType.byRating,
    );

    final ids = result.map((r) => r.id).toList();
    expect(ids, ['r2', 'r1', 'r3']);
  });

  test('deve ordenar a lista por distância (da menor para a maior)', () {
    final result = useCase.call(
      restaurants: tRestaurantList,
      sortType: SortType.byDistance,
    );

    final ids = result.map((r) => r.id).toList();
    expect(ids, ['r2', 'r3', 'r1']);
  });

  test('não deve modificar a lista original (deve retornar uma cópia)', () {
    final originalOrderIds = tRestaurantList.map((r) => r.id).toList();
    expect(originalOrderIds, ['r1', 'r2', 'r3']);

    useCase.call(restaurants: tRestaurantList, sortType: SortType.byRating);

    final afterCallIds = tRestaurantList.map((r) => r.id).toList();
    expect(afterCallIds, ['r1', 'r2', 'r3']);
  });
}
