import 'package:flutter/material.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/entities/restaurant_dto.dart';

class RestaurantWidget extends StatelessWidget {
  final RestaurantDto restaurant;
  const RestaurantWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onRestaurantPressed(context),
      child: Row(
        spacing: 16,
        children: [
          Image.asset(
            "assets/images/${restaurant.imageUrl ?? 'restaurants/default.png'}",
            width: 96,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                restaurant.name,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
              ),
              Row(
                children: List.generate(restaurant.rating.floor(), (index) {
                  return Image.asset(
                    "assets/images/others/star.png",
                    width: 16,
                  );
                }),
              ),
              Text("${restaurant.distance}km"),
            ],
          ),
        ],
      ),
    );
  }

  void _onRestaurantPressed(BuildContext context) {
    // context.push(AppRouter.restaurant, extra: restaurant);
    // context.go("${AppRouter.restaurant}/${restaurant.id}");
  }
}
