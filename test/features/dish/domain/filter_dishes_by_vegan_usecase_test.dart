import 'package:flutter_gastro_go/features/dish/data/repositories/i_dish_repository.dart';
import 'package:flutter_gastro_go/features/dish/domain/entities/dish_dto.dart';
import 'package:flutter_gastro_go/features/dish/domain/usecases/filter_dishes_by_vegan_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_dishes_by_name_or_description_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<IDishRepository>()])
void main() {
  late MockIDishRepository mockDishRepository;
  late FilterDishesByVeganUseCase useCase;

  final tDishList = [
    DishDto(
      id: 'd1',
      name: 'Feijoada Completa',
      description: 'Desc',
      price: 39.9,
      isVegan: false,
      restaurantId: 'r1',
    ),
    DishDto(
      id: 'd2',
      name: 'Moqueca Capixaba',
      description: 'Desc',
      price: 59.9,
      isVegan: false,
      restaurantId: 'r2',
    ),
    DishDto(
      id: 'd3',
      name: 'Feijoada Vegana',
      description: 'Desc',
      price: 35.0,
      isVegan: true,
      restaurantId: 'r1',
    ),
  ];

  setUp(() {
    mockDishRepository = MockIDishRepository();
    useCase = FilterDishesByVeganUseCase(mockDishRepository);
  });

  test('deve retornar apenas os pratos que são veganos', () async {
    when(mockDishRepository.getAll()).thenAnswer((_) async => tDishList);

    final result = await useCase.call(true);

    expect(result.length, 1);
    expect(result.first.id, 'd3');
    verify(mockDishRepository.getAll()).called(1);
  });

  test('deve retornar uma lista vazia se nenhum prato for vegano', () async {
    final nonVeganList = tDishList.where((d) => !d.isVegan).toList();
    when(mockDishRepository.getAll()).thenAnswer((_) async => nonVeganList);

    final result = await useCase.call(true);

    expect(result, isEmpty);
    verify(mockDishRepository.getAll()).called(1);
  });

  test('deve propagar a exceção se o repositório falhar', () async {
    when(mockDishRepository.getAll()).thenThrow(Exception('Falha'));

    expect(() => useCase.call(true), throwsA(isA<Exception>()));
    verify(mockDishRepository.getAll()).called(1);
  });
}
