import 'package:flutter_gastro_go/features/restaurant/data/exceptions/restaurant_not_found_exception.dart';
import 'package:flutter_gastro_go/features/restaurant/data/repositories/restaurant_repository.dart';
import 'package:flutter_gastro_go/features/restaurant/data/services/i_restaurant_service.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/entities/restaurant_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'restaurant_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<IRestaurantService>()])
void main() {
  late MockIRestaurantService mockService;
  late RestaurantRepository repository;

  final tRestaurantDtoList = [
    RestaurantDto(
      id: 'r1',
      name: 'Sabor Mineiro',
      description: 'Desc 1',
      distance: 2,
      categories: ['Brasileira'],
      rating: 4.5,
    ),
  ];
  final tRestaurantId = 'r1';
  final tRestaurantDto = tRestaurantDtoList.first;

  setUp(() {
    mockService = MockIRestaurantService();
    repository = RestaurantRepository(mockService);
  });

  group('getAll', () {
    test(
      'deve retornar a lista de RestaurantDto quando a chamada ao Service for bem-sucedida',
      () async {
        when(mockService.getAll()).thenAnswer((_) async => tRestaurantDtoList);

        final result = await repository.getAll();

        expect(result, equals(tRestaurantDtoList));
        verify(mockService.getAll()).called(1);
        verifyNoMoreInteractions(mockService);
      },
    );

    test('deve lançar exceção se a chamada ao Service falhar', () async {
      when(
        mockService.getAll(),
      ).thenThrow(Exception('Falha de conexão simulada'));

      expect(() => repository.getAll(), throwsA(isA<Exception>()));

      verify(mockService.getAll()).called(1);
    });
  });

  group('getById', () {
    test(
      'deve retornar um RestaurantDto quando a chamada ao Service for bem-sucedida',
      () async {
        when(mockService.getById(any)).thenAnswer((_) async => tRestaurantDto);

        final result = await repository.getById(tRestaurantId);

        expect(result, equals(tRestaurantDto));
        verify(mockService.getById(tRestaurantId)).called(1);
      },
    );

    test(
      'deve lançar RestaurantNotFoundException se o Service lançar',
      () async {
        when(
          mockService.getById(any),
        ).thenThrow(RestaurantNotFoundException(message: 'Não encontrado'));

        expect(
          () => repository.getById('id_inexistente'),
          throwsA(isA<RestaurantNotFoundException>()),
        );

        verify(mockService.getById('id_inexistente')).called(1);
      },
    );
  });
}
