import '../../domain/entities/dish_dto.dart';

abstract class IDishService {
  Future<List<DishDto>> getAll();
  Future<DishDto> getById(String id);
  Future<List<DishDto>> getByRestaurantId({required String restaurantId});
}
