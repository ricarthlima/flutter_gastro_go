import 'i_dish_repository.dart';
import '../services/i_dish_service.dart';
import '../../domain/entities/dish_dto.dart';

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
