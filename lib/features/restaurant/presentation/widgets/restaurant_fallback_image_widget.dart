import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class RestaurantFallbackImageWidget extends StatelessWidget {
  final double? size;
  const RestaurantFallbackImageWidget({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppConstants.fallbackImageRestaurant,
      width: size,
      height: size,
      fit: BoxFit.cover,
    );
  }
}
