import 'package:flutter_gastro_go/features/restaurant/data/repositories/i_restaurant_repository.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/entities/restaurant_dto.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/usecases/search_restaurants_by_name_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_restaurants_by_name_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<IRestaurantRepository>()])
void main() {
  late MockIRestaurantRepository mockRestaurantRepository;
  late SearchRestaurantsByNameUseCase useCase;

  final tRestaurantList = [
    RestaurantDto(
      id: 'r1',
      name: 'Sabor Mineiro',
      description: 'Comida mineira autêntica',
      distance: 2,
      categories: ['Brasileira', 'Mineira'],
      rating: 4.5,
    ),
    RestaurantDto(
      id: 'r2',
      name: 'Pasta Bella',
      description: 'Massas italianas',
      distance: 1,
      categories: ['Italiana'],
      rating: 4.8,
    ),
    RestaurantDto(
      id: 'r3',
      name: 'O Mineirão',
      description: 'Rodízio de carnes',
      distance: 5,
      categories: ['Brasileira', 'Churrascaria'],
      rating: 4.2,
    ),
  ];

  setUp(() {
    mockRestaurantRepository = MockIRestaurantRepository();
    useCase = SearchRestaurantsByNameUseCase(mockRestaurantRepository);
  });

  test(
    'deve retornar uma lista filtrada de restaurantes (case-insensitive)',
    () async {
      when(
        mockRestaurantRepository.getAll(),
      ).thenAnswer((_) async => tRestaurantList);

      final result = await useCase.call('mineiro');

      expect(result.length, 1);
      expect(result.any((r) => r.id == 'r1'), isTrue);
      expect(result.any((r) => r.id == 'r2'), isFalse);
      expect(result.any((r) => r.id == 'r3'), isFalse);
      verify(mockRestaurantRepository.getAll()).called(1);
    },
  );

  test(
    'deve retornar todos os restaurantes se a query estiver vazia',
    () async {
      when(
        mockRestaurantRepository.getAll(),
      ).thenAnswer((_) async => tRestaurantList);

      final result = await useCase.call('');

      expect(result.length, 3);
      expect(result, tRestaurantList);
      verify(mockRestaurantRepository.getAll()).called(1);
    },
  );

  test(
    'deve retornar uma lista vazia se nenhum restaurante corresponder à query',
    () async {
      when(
        mockRestaurantRepository.getAll(),
      ).thenAnswer((_) async => tRestaurantList);

      final result = await useCase.call('Japonês');

      expect(result, isEmpty);
      verify(mockRestaurantRepository.getAll()).called(1);
    },
  );

  test('deve propagar a exceção se o repositório falhar', () async {
    when(
      mockRestaurantRepository.getAll(),
    ).thenThrow(Exception('Falha ao ler JSON'));

    expect(() => useCase.call('qualquer'), throwsA(isA<Exception>()));
    verify(mockRestaurantRepository.getAll()).called(1);
  });
}
