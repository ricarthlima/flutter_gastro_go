import 'package:flutter_gastro_go/features/restaurant/domain/entities/restaurant_dto.dart';

abstract class IRestaurantRepository {
  Future<List<RestaurantDto>> getAll();
  Future<RestaurantDto> getById(String id);
}
