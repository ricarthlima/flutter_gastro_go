import 'i_restaurant_repository.dart';
import '../services/i_restaurant_service.dart';
import '../../domain/entities/restaurant_dto.dart';

class RestaurantRepository implements IRestaurantRepository {
  IRestaurantService apiService;
  RestaurantRepository(this.apiService);

  @override
  Future<List<RestaurantDto>> getAll() async {
    return await apiService.getAll();
  }

  @override
  Future<RestaurantDto> getById(String id) async {
    return await apiService.getById(id);
  }
}
