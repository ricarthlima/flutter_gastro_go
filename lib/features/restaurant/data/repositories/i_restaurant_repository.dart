import '../../domain/entities/restaurant_dto.dart';

abstract class IRestaurantRepository {
  Future<List<RestaurantDto>> getAll();
  Future<RestaurantDto> getById(String id);
}
