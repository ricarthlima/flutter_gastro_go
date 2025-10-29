import 'package:flutter_gastro_go/features/restaurant/data/repositories/i_restaurant_repository.dart';
import 'package:flutter_gastro_go/features/restaurant/data/services/i_restaurant_service.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/entities/restaurant_dto.dart';

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
