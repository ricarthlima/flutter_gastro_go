// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantDto _$RestaurantDtoFromJson(Map<String, dynamic> json) =>
    RestaurantDto(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      distance: (json['distance'] as num).toInt(),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      rating: (json['rating'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$RestaurantDtoToJson(RestaurantDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'distance': instance.distance,
      'categories': instance.categories,
      'rating': instance.rating,
      'imageUrl': instance.imageUrl,
    };
