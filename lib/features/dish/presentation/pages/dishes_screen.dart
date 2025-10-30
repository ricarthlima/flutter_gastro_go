import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../restaurant/presentation/widgets/restaurant_fallback_image_widget.dart';
import '../../../../shared/widgets/error_widget.dart';
import '../../../../shared/widgets/image_placeholder_widget.dart';
import '../../../../shared/widgets/loading_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/injection/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
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
    final i18n = AppLocalizations.of(context)!;

    final String imageUrl =
        AppConstants.imageBaseUrl +
        (widget.restaurant.imageUrl ?? "restaurants/default.png");

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => store.loadDishes(widget.restaurant.id),
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
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const ImagePlaceholderWidget(),
                          errorWidget: (context, url, error) =>
                              const RestaurantFallbackImageWidget(),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.backgroundAccent,
                              AppColors.backgroundAccent.withAlpha(150),
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.75, 1],
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            widget.restaurant.description,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.backgroundAccentLight,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
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
                        tooltip: i18n.navFavorites,
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
                                labelText: i18n.searchDishes,
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                suffixIcon: store.searchQuery.isEmpty
                                    ? null
                                    : IconButton(
                                        icon: const Icon(Icons.clear),
                                        tooltip: i18n.clean,
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
                              store.filterVegan
                                  ? Icons.eco
                                  : Icons.eco_outlined,
                              color: store.filterVegan
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                            iconSize: 32,
                            tooltip: i18n.filterVeganDishes,
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
                      return const LoadingWidget();
                    }

                    if (store.hasError) {
                      return AppErrorWidget(
                        message: store.errorMessage ?? i18n.dishesLoadingError,
                        onPressed: () {
                          store.loadDishes(widget.restaurant.id);
                        },
                      );
                    }

                    return _buildDishList(store.dishes, i18n);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDishList(List<DishDto> dishes, AppLocalizations i18n) {
    if (dishes.isEmpty) {
      return Center(heightFactor: 5, child: Text(i18n.noDishesOnRestaurant));
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
