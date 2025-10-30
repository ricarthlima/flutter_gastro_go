import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gastro_go/core/injection/injection_container.dart';
import 'package:flutter_gastro_go/features/dish/domain/entities/dish_dto.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/entities/restaurant_dto.dart';
import 'package:flutter_gastro_go/features/restaurant/presentation/widgets/restaurant_fallback_image_widget.dart';
import 'package:flutter_gastro_go/shared/widgets/image_placeholder_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';
import '../stores/favorites_store.dart';

class FavoriteDishWidget extends StatelessWidget {
  final DishDto dish;
  final RestaurantDto? restaurant;
  const FavoriteDishWidget({super.key, required this.dish, this.restaurant});

  @override
  Widget build(BuildContext context) {
    final FavoritesStore favoritesStore = getIt<FavoritesStore>();
    final i18n = AppLocalizations.of(context)!;

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: InkWell(
        onTap: () => _onDishPressed(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 120,
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/dishes/default.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Observer(
                    builder: (_) {
                      final isFavorite = favoritesStore.isDishFavorite(dish.id);
                      return IconButton(
                        onPressed: () {
                          favoritesStore.toggleDishFavorite(
                            dishId: dish.id,
                            restaurantId: dish.restaurantId,
                          );
                        },
                        tooltip: i18n.navFavorites,
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.white,
                          shadows: [
                            Shadow(color: Colors.black54, blurRadius: 4),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                if (dish.isVegan)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green[600],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.eco, color: Colors.white, size: 14),
                          SizedBox(width: 4),
                          Text(
                            i18n.vegan,
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ),

                if (restaurant != null)
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: _RestaurantChip(restaurant: restaurant!),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dish.name,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "R\$${dish.price.toStringAsFixed(2)}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onDishPressed(BuildContext context) {}
}

class _RestaurantChip extends StatelessWidget {
  final RestaurantDto restaurant;
  const _RestaurantChip({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final String imageUrl =
        AppConstants.imageBaseUrl +
        (restaurant.imageUrl ?? "restaurants/default.png");

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(150),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        spacing: 4,
        children: [
          CircleAvatar(
            radius: 8,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => ImagePlaceholderWidget(),
              errorWidget: (context, url, error) =>
                  RestaurantFallbackImageWidget(),
            ),
          ),
          Text(
            restaurant.name,
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
