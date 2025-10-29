import 'package:flutter_gastro_go/core/services/api/i_api_service.dart';
import 'package:flutter_gastro_go/features/restaurant/data/exceptions/restaurant_not_found_exception.dart';
import 'package:flutter_gastro_go/features/restaurant/data/services/i_restaurant_service.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/entities/restaurant_dto.dart';

class RestaurantService implements IRestaurantService {
  final IApiService apiService;
  RestaurantService(this.apiService);

  static String url = "assets/data/restaurants.json";

  @override
  Future<List<RestaurantDto>> getAll() async {
    Map<String, dynamic> result = await apiService.fetchData(url);
    return (result["restaurants"] as List<dynamic>).map((map) {
      return RestaurantDto.fromJson(map);
    }).toList();
  }

  @override
  Future<RestaurantDto> getById(String id) async {
    List<RestaurantDto> result = await getAll();
    Iterable<RestaurantDto> query = result.where((rest) => rest.id == id);
    if (query.isNotEmpty) {
      return query.first;
    }
    throw RestaurantNotFoundException(message: "id $id");
  }
}
