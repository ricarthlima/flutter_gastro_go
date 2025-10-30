import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gastro_go/core/constants/app_constants.dart';
import 'package:flutter_gastro_go/core/theme/app_colors.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/entities/restaurant_dto.dart';
import 'package:flutter_gastro_go/features/restaurant/presentation/widgets/restaurant_fallback_image_widget.dart';
import 'package:flutter_gastro_go/l10n/app_localizations.dart';
import 'package:flutter_gastro_go/shared/widgets/image_placeholder_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../core/injection/injection_container.dart';
import '../../core/navigation/app_router.dart';
import '../../features/favorite/presentation/stores/favorites_store.dart';

class RestaurantWidget extends StatelessWidget {
  final RestaurantDto restaurant;
  const RestaurantWidget({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    final FavoritesStore favoritesStore = getIt<FavoritesStore>();

    final String imageUrl =
        AppConstants.imageBaseUrl +
        (restaurant.imageUrl ?? "restaurants/default.png");

    return InkWell(
      onTap: () => _onRestaurantPressed(context),
      child: Stack(
        children: [
          Row(
            spacing: 16,
            children: [
              Hero(
                tag: 'restaurant_image_${restaurant.id}',
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 96,
                    height: 96,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        ImagePlaceholderWidget(height: 96, width: 96),
                    errorWidget: (context, url, error) {
                      return RestaurantFallbackImageWidget(size: 96);
                    },
                  ),
                ),
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
                  tooltip: AppLocalizations.of(context)!.navFavorites,
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
    context.push(
      context.namedLocation(
        AppRouter.dishes,
        pathParameters: {'rid': restaurant.id},
      ),
      extra: restaurant,
    );
  }
}
