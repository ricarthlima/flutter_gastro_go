import '../../../../core/services/api/i_api_service.dart';
import '../exceptions/restaurant_not_found_exception.dart';
import 'i_restaurant_service.dart';
import '../../domain/entities/restaurant_dto.dart';

class RestaurantService implements IRestaurantService {
  final IApiService apiService;
  RestaurantService(this.apiService);

  static String url = "assets/data/restaurants.json";

  @override
  Future<List<RestaurantDto>> getAll() async {
    final Map<String, dynamic> result = await apiService.fetchData(url);
    return (result["restaurants"] as List<dynamic>).map((map) {
      return RestaurantDto.fromJson(map);
    }).toList();
  }

  @override
  Future<RestaurantDto> getById(String id) async {
    final List<RestaurantDto> result = await getAll();
    final Iterable<RestaurantDto> query = result.where((rest) => rest.id == id);
    if (query.isNotEmpty) {
      return query.first;
    }
    throw RestaurantNotFoundException(message: "id $id");
  }
}
