import 'package:flutter_gastro_go/features/restaurant/data/repositories/i_restaurant_repository.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/entities/restaurant_dto.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/usecases/filter_restaurants_by_rating_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_restaurants_by_name_usecase_test.mocks.dart'; // Reutiliza o mock gerado

@GenerateNiceMocks([MockSpec<IRestaurantRepository>()])
void main() {
  late MockIRestaurantRepository mockRestaurantRepository;
  late FilterRestaurantsByRatingUseCase useCase;

  final tRestaurantList = [
    RestaurantDto(
      id: 'r1',
      name: 'Sabor Mineiro',
      description: 'Comida mineira autêntica',
      distance: 2,
      categories: ['Brasileira', 'Mineira'],
      rating: 4.5, // Rating 4.5
    ),
    RestaurantDto(
      id: 'r2',
      name: 'Pasta Bella',
      description: 'Massas italianas',
      distance: 1,
      categories: ['Italiana'],
      rating: 4.8, // Rating 4.8
    ),
    RestaurantDto(
      id: 'r3',
      name: 'O Mineirão',
      description: 'Rodízio de carnes',
      distance: 5,
      categories: ['Brasileira', 'Churrascaria'],
      rating: 4.2, // Rating 4.2
    ),
  ];

  setUp(() {
    mockRestaurantRepository = MockIRestaurantRepository();
    useCase = FilterRestaurantsByRatingUseCase(mockRestaurantRepository);
  });

  test(
    'deve retornar restaurantes cujo rating é maior ou igual ao mínimo',
    () async {
      when(
        mockRestaurantRepository.getAll(),
      ).thenAnswer((_) async => tRestaurantList);

      final result = await useCase.call(4.5); // Filtro: 4.5

      expect(result.length, 2);
      expect(result.any((r) => r.id == 'r1'), isTrue); // 4.5 >= 4.5
      expect(result.any((r) => r.id == 'r2'), isTrue); // 4.8 >= 4.5
      expect(result.any((r) => r.id == 'r3'), isFalse); // 4.2 < 4.5
      verify(mockRestaurantRepository.getAll()).called(1);
    },
  );

  test('deve retornar uma lista vazia se nenhum rating corresponder', () async {
    when(
      mockRestaurantRepository.getAll(),
    ).thenAnswer((_) async => tRestaurantList);

    final result = await useCase.call(4.9); // Filtro: 4.9

    expect(result, isEmpty);
    verify(mockRestaurantRepository.getAll()).called(1);
  });

  test(
    'deve retornar todos os restaurantes se o rating for zero ou negativo',
    () async {
      when(
        mockRestaurantRepository.getAll(),
      ).thenAnswer((_) async => tRestaurantList);

      final result = await useCase.call(0);

      expect(result.length, 3);
      expect(result, tRestaurantList);
      verify(mockRestaurantRepository.getAll()).called(1);
    },
  );

  test('deve propagar a exceção se o repositório falhar', () async {
    when(
      mockRestaurantRepository.getAll(),
    ).thenThrow(Exception('Falha ao ler JSON'));

    expect(() => useCase.call(4.0), throwsA(isA<Exception>()));
    verify(mockRestaurantRepository.getAll()).called(1);
  });
}
