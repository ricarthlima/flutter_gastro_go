import 'package:flutter_gastro_go/features/restaurant/data/repositories/i_restaurant_repository.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/entities/restaurant_dto.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/usecases/filter_restaurants_by_distance_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_restaurants_by_name_usecase_test.mocks.dart'; // Reutiliza o mock gerado

@GenerateNiceMocks([MockSpec<IRestaurantRepository>()])
void main() {
  late MockIRestaurantRepository mockRestaurantRepository;
  late FilterRestaurantsByDistanceUseCase useCase;

  final tRestaurantList = [
    RestaurantDto(
      id: 'r1',
      name: 'Sabor Mineiro',
      description: 'Comida mineira autêntica',
      distance: 2, // 2 km
      categories: ['Brasileira', 'Mineira'],
      rating: 4.5,
    ),
    RestaurantDto(
      id: 'r2',
      name: 'Pasta Bella',
      description: 'Massas italianas',
      distance: 1, // 1 km
      categories: ['Italiana'],
      rating: 4.8,
    ),
    RestaurantDto(
      id: 'r3',
      name: 'O Mineirão',
      description: 'Rodízio de carnes',
      distance: 5, // 5 km
      categories: ['Brasileira', 'Churrascaria'],
      rating: 4.2,
    ),
  ];

  setUp(() {
    mockRestaurantRepository = MockIRestaurantRepository();
    useCase = FilterRestaurantsByDistanceUseCase(mockRestaurantRepository);
  });

  test(
    'deve retornar restaurantes cuja distância é menor ou igual à máxima',
    () async {
      when(
        mockRestaurantRepository.getAll(),
      ).thenAnswer((_) async => tRestaurantList);

      final result = await useCase.call(2.5); // Filtro: 2.5 km

      expect(result.length, 2);
      expect(result.any((r) => r.id == 'r1'), isTrue); // 2km <= 2.5km
      expect(result.any((r) => r.id == 'r2'), isTrue); // 1km <= 2.5km
      expect(result.any((r) => r.id == 'r3'), isFalse); // 5km > 2.5km
      verify(mockRestaurantRepository.getAll()).called(1);
    },
  );

  test(
    'deve retornar uma lista vazia se nenhuma distância corresponder',
    () async {
      when(
        mockRestaurantRepository.getAll(),
      ).thenAnswer((_) async => tRestaurantList);

      final result = await useCase.call(0.5); // Filtro: 0.5 km

      expect(result, isEmpty);
      verify(mockRestaurantRepository.getAll()).called(1);
    },
  );

  test(
    'deve retornar todos os restaurantes se a distância for zero ou negativa',
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

    expect(() => useCase.call(3), throwsA(isA<Exception>()));
    verify(mockRestaurantRepository.getAll()).called(1);
  });
}
