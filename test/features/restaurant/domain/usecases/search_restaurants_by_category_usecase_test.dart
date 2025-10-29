import 'package:flutter_gastro_go/features/restaurant/data/repositories/i_restaurant_repository.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/entities/restaurant_dto.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/usecases/search_restaurants_by_category_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_restaurants_by_name_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<IRestaurantRepository>()])
void main() {
  late MockIRestaurantRepository mockRestaurantRepository;
  late SearchRestaurantsByCategoryUseCase useCase;

  final tRestaurantList = [
    RestaurantDto(
      id: 'r1',
      name: 'Sabor Mineiro',
      description: 'Desc',
      distance: 2,
      categories: ['Brasileira', 'Mineira'],
      rating: 4.5,
    ),
    RestaurantDto(
      id: 'r2',
      name: 'Pasta Bella',
      description: 'Desc',
      distance: 1,
      categories: ['Italiana'],
      rating: 4.8,
    ),
    RestaurantDto(
      id: 'r3',
      name: 'O Mineirão',
      description: 'Desc',
      distance: 5,
      categories: ['Brasileira', 'Churrascaria'],
      rating: 4.2,
    ),
  ];

  setUp(() {
    mockRestaurantRepository = MockIRestaurantRepository();
    useCase = SearchRestaurantsByCategoryUseCase(mockRestaurantRepository);
  });

  test(
    'deve retornar restaurantes cuja categoria contenha o texto (case-insensitive)',
    () async {
      when(
        mockRestaurantRepository.getAll(),
      ).thenAnswer((_) async => tRestaurantList);

      final result = await useCase.call('brasil');

      expect(result.length, 2);
      expect(result.any((r) => r.id == 'r1'), isTrue);
      expect(result.any((r) => r.id == 'r3'), isTrue);
      expect(result.any((r) => r.id == 'r2'), isFalse);
      verify(mockRestaurantRepository.getAll()).called(1);
    },
  );

  test(
    'deve retornar uma lista vazia se nenhuma categoria corresponder',
    () async {
      when(
        mockRestaurantRepository.getAll(),
      ).thenAnswer((_) async => tRestaurantList);

      final result = await useCase.call('Japonesa');

      expect(result, isEmpty);
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

  test('deve propagar a exceção se o repositório falhar', () async {
    when(
      mockRestaurantRepository.getAll(),
    ).thenThrow(Exception('Falha ao ler JSON'));

    expect(() => useCase.call('Italiana'), throwsA(isA<Exception>()));
    verify(mockRestaurantRepository.getAll()).called(1);
  });
}
