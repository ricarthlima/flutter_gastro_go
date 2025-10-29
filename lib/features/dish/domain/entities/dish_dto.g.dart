// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dish_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DishDto _$DishDtoFromJson(Map<String, dynamic> json) => DishDto(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  price: (json['price'] as num).toDouble(),
  imageUrl: json['imageUrl'] as String?,
  isVegan: json['isVegan'] as bool,
  restaurantId: json['restaurantId'] as String,
);

Map<String, dynamic> _$DishDtoToJson(DishDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'price': instance.price,
  'imageUrl': instance.imageUrl,
  'isVegan': instance.isVegan,
  'restaurantId': instance.restaurantId,
};
