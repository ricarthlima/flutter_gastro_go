import '../../domain/entities/restaurant_dto.dart';

abstract class IRestaurantService {
  Future<List<RestaurantDto>> getAll();
  Future<RestaurantDto> getById(String id);
}
