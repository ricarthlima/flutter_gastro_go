import 'package:flutter/material.dart';
import 'package:flutter_gastro_go/core/injection/injection_container.dart';
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
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 2. Imagem (Baseada no seu layout)
                SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/${dish.imageUrl ?? 'dishes/default.png'}",
                    fit: BoxFit.cover,
                  ),
                ),
                // 3. Informações (Baseado no seu layout)
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
              ],
            ),
            // 4. Botão de Favorito Reativo
            Align(
              alignment: Alignment.topRight,
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
                      color: isFavorite ? Colors.red : null,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onDishPressed(BuildContext context) {}
}
