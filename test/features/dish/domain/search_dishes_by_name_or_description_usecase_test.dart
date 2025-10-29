import 'package:flutter_gastro_go/features/dish/data/repositories/i_dish_repository.dart';
import 'package:flutter_gastro_go/features/dish/domain/entities/dish_dto.dart';
import 'package:flutter_gastro_go/features/dish/domain/usecases/search_dishes_by_name_or_description_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../restaurant/domain/usecases/filter_restaurants_with_vegan_dishes_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<IDishRepository>()])
void main() {
  late MockIDishRepository mockDishRepository;
  late SearchDishesByNameOrDescriptionUseCase useCase;

  final tDishList = [
    DishDto(
      id: 'd1',
      name: 'Feijoada Completa',
      description: 'Acompanha arroz e farofa',
      price: 39.9,
      isVegan: false,
      restaurantId: 'r1',
    ),
    DishDto(
      id: 'd2',
      name: 'Moqueca Capixaba',
      description: 'Peixe fresco e coentro',
      price: 59.9,
      isVegan: false,
      restaurantId: 'r2',
    ),
    DishDto(
      id: 'd3',
      name: 'Prato Vegano',
      description: 'Feita com grão de bico e feijao',
      price: 35.0,
      isVegan: true,
      restaurantId: 'r1',
    ),
  ];

  setUp(() {
    mockDishRepository = MockIDishRepository();
    useCase = SearchDishesByNameOrDescriptionUseCase(mockDishRepository);
  });

  test('deve retornar pratos filtrados pelo nome', () async {
    when(mockDishRepository.getAll()).thenAnswer((_) async => tDishList);

    final result = await useCase.call('moqueca');

    expect(result.length, 1);
    expect(result.first.id, 'd2');
    verify(mockDishRepository.getAll()).called(1);
  });

  test('deve retornar pratos filtrados pela descrição', () async {
    when(mockDishRepository.getAll()).thenAnswer((_) async => tDishList);

    final result = await useCase.call('arroz');

    expect(result.length, 1);
    expect(result.first.id, 'd1');
    verify(mockDishRepository.getAll()).called(1);
  });

  test(
    'deve retornar pratos filtrados pelo nome OU descrição (case-insensitive)',
    () async {
      when(mockDishRepository.getAll()).thenAnswer((_) async => tDishList);

      final result = await useCase.call('feij');

      expect(result.length, 2);
      expect(result.any((d) => d.id == 'd1'), isTrue);
      expect(result.any((d) => d.id == 'd3'), isTrue);
      verify(mockDishRepository.getAll()).called(1);
    },
  );

  test(
    'deve retornar uma lista vazia se nenhum nome ou descrição corresponder',
    () async {
      when(mockDishRepository.getAll()).thenAnswer((_) async => tDishList);

      final result = await useCase.call('Sushi');

      expect(result, isEmpty);
      verify(mockDishRepository.getAll()).called(1);
    },
  );

  test('deve retornar todos os pratos se a query estiver vazia', () async {
    when(mockDishRepository.getAll()).thenAnswer((_) async => tDishList);

    final result = await useCase.call('');

    expect(result.length, 3);
    expect(result, tDishList);
    verify(mockDishRepository.getAll()).called(1);
  });

  test('deve propagar a exceção se o repositório falhar', () async {
    when(mockDishRepository.getAll()).thenThrow(Exception('Falha'));

    expect(() => useCase.call('Moqueca'), throwsA(isA<Exception>()));
    verify(mockDishRepository.getAll()).called(1);
  });
}
