import 'package:flutter/material.dart';
import 'package:flutter_gastro_go/core/injection/injection_container.dart';
import 'package:flutter_gastro_go/core/theme/app_colors.dart';
import 'package:flutter_gastro_go/features/dish/domain/entities/dish_dto.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../features/favorite/presentation/stores/favorites_store.dart';

class DishWidget extends StatelessWidget {
  final DishDto dish;

  const DishWidget({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    final FavoritesStore favoritesStore = getIt<FavoritesStore>();

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: InkWell(
        onTap: () => _onDishPressed(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (dish.isVegan)
              Container(
                color: Colors.green[600],
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.eco),
                    Text("Vegano", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            SizedBox(
              height: 160,
              width: double.infinity,
              child: Image.asset(
                "assets/images/dishes/default.png",
                fit: BoxFit.cover,
              ),
            ),

            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dish.name,
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text("R\$${dish.price.toStringAsFixed(2)}"),
                      const SizedBox(height: 8),
                      Text(
                        dish.description,
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
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
                        icon: Icon(
                          isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: isFavorite
                              ? AppColors.main
                              : Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onDishPressed(BuildContext context) {}
}
