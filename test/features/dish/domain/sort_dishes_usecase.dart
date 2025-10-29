import 'package:flutter_gastro_go/features/dish/domain/entities/dish_dto.dart';
import 'package:flutter_gastro_go/features/dish/domain/usecases/sort_dishes_usecase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late SortDishesUseCase useCase;
  late List<DishDto> tDishList;

  final d1 = DishDto(
    id: 'd1',
    name: 'Moqueca',
    description: 'Desc',
    price: 59.9,
    isVegan: false,
    restaurantId: 'r2',
  );
  final d2 = DishDto(
    id: 'd2',
    name: 'Feijoada Vegana',
    description: 'Desc',
    price: 35.0,
    isVegan: true,
    restaurantId: 'r1',
  );
  final d3 = DishDto(
    id: 'd3',
    name: 'Arroz Carreteiro',
    description: 'Desc',
    price: 39.9,
    isVegan: false,
    restaurantId: 'r1',
  );

  setUp(() {
    useCase = SortDishesUseCase();
    tDishList = [d1, d2, d3];
  });

  test('deve ordenar a lista por preço (do menor para o maior)', () {
    final result = useCase.call(
      dishes: tDishList,
      sortType: SortDishType.byPrice,
    );

    final ids = result.map((d) => d.id).toList();
    expect(ids, ['d2', 'd3', 'd1']);
  });

  test('deve ordenar a lista por nome (ordem alfabética)', () {
    final result = useCase.call(
      dishes: tDishList,
      sortType: SortDishType.byName,
    );

    final ids = result.map((d) => d.id).toList();
    expect(ids, ['d3', 'd2', 'd1']);
  });

  test('não deve modificar a lista original (deve retornar uma cópia)', () {
    final originalOrderIds = tDishList.map((d) => d.id).toList();
    expect(originalOrderIds, ['d1', 'd2', 'd3']);

    useCase.call(dishes: tDishList, sortType: SortDishType.byPrice);

    final afterCallIds = tDishList.map((d) => d.id).toList();
    expect(afterCallIds, ['d1', 'd2', 'd3']);
  });
}
