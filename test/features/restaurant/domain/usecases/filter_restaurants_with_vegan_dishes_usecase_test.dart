import 'package:flutter_gastro_go/features/dish/data/repositories/i_dish_repository.dart';
import 'package:flutter_gastro_go/features/dish/domain/entities/dish_dto.dart';
import 'package:flutter_gastro_go/features/restaurant/data/repositories/i_restaurant_repository.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/entities/restaurant_dto.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/usecases/filter_restaurants_with_vegan_dishes_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'filter_restaurants_with_vegan_dishes_usecase_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<IRestaurantRepository>(),
  MockSpec<IDishRepository>(),
])
void main() {
  late MockIRestaurantRepository mockRestaurantRepository;
  late MockIDishRepository mockDishRepository;
  late FilterRestaurantsWithVeganDishesUseCase useCase;

  final tRestaurantList = [
    RestaurantDto(
      id: 'r1',
      name: 'Restaurante Vegano',
      description: 'Desc',
      distance: 2,
      categories: ['Vegano'],
      rating: 4.5,
    ),
    RestaurantDto(
      id: 'r2',
      name: 'Churrascaria',
      description: 'Desc',
      distance: 1,
      categories: ['Carne'],
      rating: 4.8,
    ),
    RestaurantDto(
      id: 'r3',
      name: 'Misto',
      description: 'Desc',
      distance: 5,
      categories: ['Variada'],
      rating: 4.2,
    ),
  ];

  final tDishList = [
    DishDto(
      id: 'd1',
      name: 'Salada Vegana',
      description: 'Desc',
      price: 20.0,
      isVegan: true,
      restaurantId: 'r1',
    ),
    DishDto(
      id: 'd2',
      name: 'Picanha',
      description: 'Desc',
      price: 50.0,
      isVegan: false,
      restaurantId: 'r2',
    ),
    DishDto(
      id: 'd3',
      name: 'Feijoada Vegana',
      description: 'Desc',
      price: 30.0,
      isVegan: true,
      restaurantId: 'r3',
    ),
    DishDto(
      id: 'd4',
      name: 'Frango Grelhado',
      description: 'Desc',
      price: 25.0,
      isVegan: false,
      restaurantId: 'r3',
    ),
  ];

  setUp(() {
    mockRestaurantRepository = MockIRestaurantRepository();
    mockDishRepository = MockIDishRepository();
    useCase = FilterRestaurantsWithVeganDishesUseCase(
      restaurantRepository: mockRestaurantRepository,
      dishRepository: mockDishRepository,
    );
  });

  test(
    'deve retornar apenas restaurantes que possuem pratos veganos no cardápio',
    () async {
      when(
        mockRestaurantRepository.getAll(),
      ).thenAnswer((_) async => tRestaurantList);
      when(mockDishRepository.getAll()).thenAnswer((_) async => tDishList);

      final result = await useCase.call();

      expect(result.length, 2);
      expect(result.any((r) => r.id == 'r1'), isTrue);
      expect(result.any((r) => r.id == 'r3'), isTrue);
      expect(result.any((r) => r.id == 'r2'), isFalse);
      verify(mockRestaurantRepository.getAll()).called(1);
      verify(mockDishRepository.getAll()).called(1);
    },
  );

  test(
    'deve retornar uma lista vazia se nenhum restaurante tiver prato vegano',
    () async {
      final nonVeganDishes = tDishList.where((d) => !d.isVegan).toList();
      when(
        mockRestaurantRepository.getAll(),
      ).thenAnswer((_) async => tRestaurantList);
      when(mockDishRepository.getAll()).thenAnswer((_) async => nonVeganDishes);

      final result = await useCase.call();

      expect(result, isEmpty);
    },
  );

  test('deve propagar a exceção se o restaurant repository falhar', () async {
    when(
      mockRestaurantRepository.getAll(),
    ).thenThrow(Exception('Falha no JSON'));

    expect(() => useCase.call(), throwsA(isA<Exception>()));
    verifyNever(mockDishRepository.getAll());
  });

  test('deve propagar a exceção se o dish repository falhar', () async {
    when(
      mockRestaurantRepository.getAll(),
    ).thenAnswer((_) async => tRestaurantList);
    when(mockDishRepository.getAll()).thenThrow(Exception('Falha no JSON'));

    expect(() => useCase.call(), throwsA(isA<Exception>()));
    verify(mockRestaurantRepository.getAll()).called(1);
  });
}
