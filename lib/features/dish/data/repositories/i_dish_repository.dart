import 'package:flutter_gastro_go/features/dish/domain/entities/dish_dto.dart';

abstract class IDishRepository {
  Future<List<DishDto>> getAll();
  Future<DishDto> getById(String id);
  Future<List<DishDto>> getByRestaurantId({required String restaurantId});
}
