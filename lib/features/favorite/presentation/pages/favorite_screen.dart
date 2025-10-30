import 'package:flutter/material.dart';
import 'package:flutter_gastro_go/core/injection/injection_container.dart';
import 'package:flutter_gastro_go/features/favorite/presentation/stores/favorites_store.dart';
import 'package:flutter_gastro_go/shared/widgets/restaurant_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/dish_widget.dart';
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
              Tab(icon: Icon(Icons.store), text: i18n.navRestaurants),
              Tab(icon: Icon(Icons.fastfood), text: i18n.dishes),
            ],
          ),
        ),
        body: Observer(
          builder: (_) {
            if (store.state == FavoritesState.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (store.state == FavoritesState.error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(store.errorMessage ?? i18n.errorLoading),
                    ElevatedButton(
                      onPressed: store.loadFavoritesScreenData,
                      child: Text(i18n.errorRetry),
                    ),
                  ],
                ),
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
    if (store.favoriteRestaurants.isEmpty) {
      return const Center(
        child: Text("Você ainda não favoritou restaurantes."),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: store.favoriteRestaurants.length,
      itemBuilder: (context, index) {
        final restaurant = store.favoriteRestaurants[index];
        return RestaurantWidget(restaurant: restaurant);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 16),
    );
  }

  Widget _buildDishList() {
    if (store.favoriteDishes.isEmpty) {
      return const Center(child: Text("Você ainda não favoritou pratos."));
    }
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      itemCount: store.favoriteDishes.length,
      itemBuilder: (context, index) {
        final dish = store.favoriteDishes[index];
        return DishWidget(dish: dish);
      },
    );
  }
}
