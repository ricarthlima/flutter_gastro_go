import 'package:flutter_gastro_go/features/dish/data/repositories/i_dish_repository.dart';
import 'package:flutter_gastro_go/features/dish/data/services/i_dish_service.dart';
import 'package:flutter_gastro_go/features/dish/domain/entities/dish_dto.dart';

class DishRepository implements IDishRepository {
  final IDishService dishService;

  DishRepository(this.dishService);

  @override
  Future<List<DishDto>> getAll() {
    return dishService.getAll();
  }

  @override
  Future<DishDto> getById(String id) {
    return dishService.getById(id);
  }

  @override
  Future<List<DishDto>> getByRestaurantId({required String restaurantId}) {
    return dishService.getByRestaurantId(restaurantId: restaurantId);
  }
}
