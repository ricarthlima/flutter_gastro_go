import 'package:flutter/material.dart';
import 'package:flutter_gastro_go/core/injection/injection_container.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/entities/restaurant_dto.dart';
import 'package:flutter_gastro_go/features/restaurant/presentation/stores/restaurant_list_store.dart';
import 'package:flutter_gastro_go/features/restaurant/presentation/widgets/home_app_bar.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../helpers/categories_data.dart';
import '../../helpers/category_model.dart';
import '../widgets/category_widget.dart';
import '../widgets/restaurant_widget.dart';

class RestaurantsScreen extends StatefulWidget {
  const RestaurantsScreen({super.key});

  @override
  State<RestaurantsScreen> createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  final RestaurantListStore store = getIt<RestaurantListStore>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      store.loadRestaurants();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: SafeArea(
        child: Observer(
          builder: (context) {
            if (store.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (store.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      store.errorMessage ?? "Erro",
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton(
                      onPressed: store.loadRestaurants,
                      child: Text("Tentar Novamente"),
                    ),
                  ],
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    Text(
                      "Boas vindas!",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Image.asset("assets/images/banners/banner_promo.png"),
                    Text(
                      "Fome de quê?",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 16,
                        children: List.generate(
                          CategoriesData.listCategories.length,
                          (index) {
                            CategoryModel category =
                                CategoriesData.listCategories[index];
                            return InkWell(
                              onTap: () {
                                onCategoryTap(category.name);
                              },
                              child: CategoryWidget(
                                category: category,
                                isSelected:
                                    store.categoryQuery == category.name,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Text(
                      "Restaurantes para você",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        labelText: "O que você quer comer?",
                      ),
                      onFieldSubmitted: (value) => _animateToEnd(),
                    ),
                    Column(
                      spacing: 16,
                      children: List.generate(store.restaurants.length, (
                        index,
                      ) {
                        RestaurantDto restaurant = store.restaurants[index];
                        return RestaurantWidget(restaurant: restaurant);
                      }),
                    ),
                    SizedBox(height: 64),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void onCategoryTap(String categoryName) {}

  void _animateToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 750),
      curve: Curves.ease,
    );
  }
}
