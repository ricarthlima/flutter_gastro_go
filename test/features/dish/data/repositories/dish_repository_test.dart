import 'package:flutter_gastro_go/features/dish/data/repositories/dish_repository.dart';
import 'package:flutter_gastro_go/features/dish/data/services/i_dish_service.dart';
import 'package:flutter_gastro_go/features/dish/domain/entities/dish_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'dish_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<IDishService>()])
void main() {
  late MockIDishService mockDishService;
  late DishRepository repository;

  final tDishDto = DishDto(
    id: 'd1',
    name: 'Feijoada',
    description: 'A melhor!',
    price: 39.9,
    isVegan: false,
    restaurantId: 'r1',
  );

  final tDishDtoList = [tDishDto];

  setUp(() {
    mockDishService = MockIDishService();
    repository = DishRepository(mockDishService);
  });

  group('getAll', () {
    test('deve retornar List<DishDto> do service', () async {
      when(mockDishService.getAll()).thenAnswer((_) async => tDishDtoList);

      final result = await repository.getAll();

      expect(result, tDishDtoList);
      verify(mockDishService.getAll()).called(1);
      verifyNoMoreInteractions(mockDishService);
    });
  });

  group('getById', () {
    test('deve retornar um DishDto do service', () async {
      when(mockDishService.getById('d1')).thenAnswer((_) async => tDishDto);

      final result = await repository.getById('d1');

      expect(result, tDishDto);
      verify(mockDishService.getById('d1')).called(1);
      verifyNoMoreInteractions(mockDishService);
    });
  });

  group('getByRestaurantId', () {
    test('deve retornar uma List<DishDto> filtrada do service', () async {
      when(
        mockDishService.getByRestaurantId(restaurantId: 'r1'),
      ).thenAnswer((_) async => tDishDtoList);

      final result = await repository.getByRestaurantId(restaurantId: 'r1');

      expect(result, tDishDtoList);
      verify(mockDishService.getByRestaurantId(restaurantId: 'r1')).called(1);
      verifyNoMoreInteractions(mockDishService);
    });
  });
}
