import 'package:flutter/material.dart';
import 'package:flutter_gastro_go/shared/widgets/error_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/injection/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/dish_widget.dart';
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

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    store.loadDishes(widget.restaurant.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
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
                    Center(child: Text(widget.restaurant.description)),
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
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Observer(
                  builder: (_) {
                    return Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              labelText: "Buscar no cardápio...",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              suffixIcon: store.searchQuery.isEmpty
                                  ? null
                                  : IconButton(
                                      icon: Icon(Icons.clear),
                                      onPressed: () {
                                        _searchController.clear();
                                        store.setSearchQuery('');
                                      },
                                    ),
                            ),
                            onChanged: store.setSearchQuery,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            store.filterVegan ? Icons.eco : Icons.eco_outlined,
                            color: store.filterVegan
                                ? Colors.green
                                : Colors.grey,
                          ),
                          iconSize: 32,
                          tooltip: "Filtrar pratos veganos",

                          onPressed: () {
                            store.toggleVeganFilter(!store.filterVegan);
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Observer(
                builder: (_) {
                  if (store.isLoading) {
                    return const Center(
                      heightFactor: 5,
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (store.hasError) {
                    return AppErrorWidget(
                      message: store.errorMessage ?? "Erro ao carregar pratos",
                      onPressed: () {
                        store.loadDishes(widget.restaurant.id);
                      },
                    );
                  }

                  return _buildDishList(store.dishes);
                },
              ),
            ),
          ],
        ),
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
