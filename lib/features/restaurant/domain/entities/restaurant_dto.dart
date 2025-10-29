import 'package:json_annotation/json_annotation.dart';

part 'restaurant_dto.g.dart';

@JsonSerializable()
class RestaurantDto {
  String id;
  String name;
  String description;
  int distance;
  List<String> categories;
  double rating;
  String? imageUrl;

  RestaurantDto({
    required this.id,
    required this.name,
    required this.description,
    required this.distance,
    required this.categories,
    required this.rating,
    this.imageUrl,
  });

  factory RestaurantDto.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDtoFromJson(json);
  Map<String, dynamic> toJson() => _$RestaurantDtoToJson(this);
}
