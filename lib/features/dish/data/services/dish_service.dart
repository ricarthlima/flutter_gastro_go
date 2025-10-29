import 'package:flutter_gastro_go/core/services/api/i_api_service.dart';
import 'package:flutter_gastro_go/features/dish/data/exceptions/dish_not_found_exception.dart';
import 'package:flutter_gastro_go/features/dish/data/services/i_dish_service.dart';
import 'package:flutter_gastro_go/features/dish/domain/entities/dish_dto.dart';

class DishService implements IDishService {
  final IApiService apiService;
  DishService(this.apiService);

  static String url = "assets/data/dishes.json";

  @override
  Future<List<DishDto>> getAll() async {
    Map<String, dynamic> result = await apiService.fetchData(url);
    return (result["dishes"] as List<dynamic>).map((map) {
      return DishDto.fromJson(map);
    }).toList();
  }

  @override
  Future<DishDto> getById(String id) async {
    List<DishDto> result = await getAll();
    Iterable<DishDto> query = result.where((rest) => rest.id == id);
    if (query.isNotEmpty) {
      return query.first;
    }
    throw DishNotFoundException(message: "id $id");
  }

  @override
  Future<List<DishDto>> getByRestaurantId({
    required String restaurantId,
  }) async {
    List<DishDto> result = await getAll();
    return result.where((rest) => rest.restaurantId == restaurantId).toList();
  }
}
