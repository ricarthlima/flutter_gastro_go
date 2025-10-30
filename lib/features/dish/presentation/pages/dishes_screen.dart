import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/dish_widget.dart';
import '../../../favorite/presentation/stores/favorites_store.dart';
import '../../../restaurant/domain/entities/restaurant_dto.dart';
import '../../domain/entities/dish_dto.dart';
import '../stores/dish_list_store.dart';

class DishesScreen extends StatefulWidget {
  final RestaurantDto restaurant;
  const DishesScreen({super.key, required this.restaurant});

  @override
  State<DishesScreen> createState() => _DishesScreenState();
}

class _DishesScreenState extends State<DishesScreen> {
  final DishListStore store = getIt<DishListStore>();
  final FavoritesStore favoritesStore = getIt<FavoritesStore>();

  @override
  void initState() {
    super.initState();
    store.loadDishes(widget.restaurant.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 256,
            pinned: true,
            title: Text(widget.restaurant.name),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'restaurant_image_${widget.restaurant.id}',
                    child: Image.asset(
                      "assets/images/${widget.restaurant.imageUrl ?? 'restaurants/default.png'}",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(
                            context,
                          ).scaffoldBackgroundColor.withAlpha(225),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 1],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Observer(
                builder: (context) {
                  final isFavorite = favoritesStore.isRestaurantFavorite(
                    widget.restaurant.id,
                  );

                  return IconButton(
                    onPressed: () {
                      favoritesStore.toggleRestaurantFavorite(
                        widget.restaurant.id,
                      );
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
            ],
          ),

          // 6. O Observer que lida com os estados da lista de PRATOS
          SliverToBoxAdapter(
            child: Observer(
              builder: (_) {
                // 7. Estado de Loading
                if (store.isLoading) {
                  return const Center(
                    heightFactor: 5,
                    child: CircularProgressIndicator(),
                  );
                }

                // 8. Estado de Erro
                if (store.hasError) {
                  return Center(
                    heightFactor: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(store.errorMessage ?? "Erro ao carregar pratos"),
                        ElevatedButton(
                          onPressed: () =>
                              store.loadDishes(widget.restaurant.id),
                          child: const Text("Tentar Novamente"),
                        ),
                      ],
                    ),
                  );
                }

                // 9. Estado de Sucesso (Lista de Pratos)
                return _buildDishList(store.dishes);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDishList(List<DishDto> dishes) {
    if (dishes.isEmpty) {
      return const Center(
        heightFactor: 5,
        child: Text("Este restaurante não possui pratos cadastrados."),
      );
    }
    return ListView.separated(
      itemCount: dishes.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final dish = dishes[index];
        return DishWidget(dish: dish);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 16),
    );
  }
}
