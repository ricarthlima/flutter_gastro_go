import 'package:json_annotation/json_annotation.dart';

part 'dish_dto.g.dart';

@JsonSerializable()
class DishDto {
  String id;
  String name;
  String description;
  double price;
  String? imageUrl;
  bool isVegan;
  String restaurantId;

  DishDto({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.imageUrl,
    required this.isVegan,
    required this.restaurantId,
  });
  factory DishDto.fromJson(Map<String, dynamic> json) =>
      _$DishDtoFromJson(json);
  Map<String, dynamic> toJson() => _$DishDtoToJson(this);
}
