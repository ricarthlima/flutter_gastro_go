import 'package:flutter/material.dart';
import '../../../../core/injection/injection_container.dart';
import '../stores/favorites_store.dart';
import '../widgets/favorite_dish_widget.dart';
import '../../../../shared/widgets/error_widget.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/restaurant_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../l10n/app_localizations.dart';
import '../stores/favorites_state.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with SingleTickerProviderStateMixin {
  final FavoritesStore store = getIt<FavoritesStore>();

  @override
  void initState() {
    super.initState();
    store.loadFavoritesScreenData();
  }

  @override
  Widget build(BuildContext context) {
    final i18n = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(i18n.navFavorites),
          bottom: TabBar(
            tabs: [
              Tab(icon: const Icon(Icons.store), text: i18n.navRestaurants),
              Tab(icon: const Icon(Icons.fastfood), text: i18n.dishes),
            ],
          ),
        ),
        body: Observer(
          builder: (_) {
            if (store.state == FavoritesState.loading) {
              return const LoadingWidget();
            }

            if (store.state == FavoritesState.error) {
              return AppErrorWidget(
                message: store.errorMessage ?? i18n.errorLoading,
                onPressed: store.loadFavoritesScreenData,
              );
            }

            return TabBarView(
              children: [_buildRestaurantList(), _buildDishList()],
            );
          },
        ),
      ),
    );
  }

  Widget _buildRestaurantList() {
    final i18n = AppLocalizations.of(context)!;

    if (store.favoriteRestaurants.isEmpty) {
      return Center(child: Text(i18n.emptyFavoriteRestaurants));
    }
    return RefreshIndicator(
      onRefresh: store.loadFavoritesScreenData,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: store.favoriteRestaurants.length,
        itemBuilder: (context, index) {
          final restaurant = store.favoriteRestaurants[index];
          return RestaurantWidget(restaurant: restaurant);
        },
        separatorBuilder: (context, index) => const SizedBox(height: 16),
      ),
    );
  }

  Widget _buildDishList() {
    final i18n = AppLocalizations.of(context)!;

    if (store.favoriteDishes.isEmpty) {
      return Center(child: Text(i18n.emptyFavoriteDishes));
    }
    return RefreshIndicator(
      onRefresh: store.loadFavoritesScreenData,
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.9,
        ),
        itemCount: store.favoriteDishes.length,
        itemBuilder: (context, index) {
          final dish = store.favoriteDishes[index];
          final restaurant = store.allRestaurants.firstWhere(
            (r) => r.id == dish.restaurantId,
          );
          return FavoriteDishWidget(dish: dish, restaurant: restaurant);
        },
      ),
    );
  }
}
