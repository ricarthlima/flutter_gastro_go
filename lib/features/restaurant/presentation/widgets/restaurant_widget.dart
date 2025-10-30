import 'package:flutter/material.dart';
import 'package:flutter_gastro_go/core/theme/app_colors.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/entities/restaurant_dto.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../favorite/presentation/stores/favorites_store.dart';

class RestaurantWidget extends StatelessWidget {
  final RestaurantDto restaurant;
  const RestaurantWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final FavoritesStore favoritesStore = getIt<FavoritesStore>();

    return InkWell(
      onTap: () => _onRestaurantPressed(context),
      child: Stack(
        children: [
          Row(
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
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: List.generate(restaurant.rating.floor(), (
                          index,
                        ) {
                          return Image.asset(
                            "assets/images/others/star.png",
                            width: 18,
                          );
                        }),
                      ),
                      Text(restaurant.rating.toString()),
                    ],
                  ),
                  Text("${restaurant.distance}km"),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Observer(
              builder: (context) {
                final isFavorite = favoritesStore.isRestaurantFavorite(
                  restaurant.id,
                );

                return IconButton(
                  onPressed: () {
                    favoritesStore.toggleRestaurantFavorite(restaurant.id);
                  },
                  icon: Icon(
                    isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color: isFavorite ? AppColors.main : null,
                  ),
                );
              },
            ),
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
