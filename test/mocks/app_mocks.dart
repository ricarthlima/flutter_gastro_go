import 'package:flutter_gastro_go/features/favorite/presentation/stores/favorites_store.dart';
import 'package:flutter_gastro_go/features/restaurant/presentation/stores/restaurant_list_store.dart';
import 'package:flutter_gastro_go/features/settings/domain/stores/theme_store.dart';
import 'package:flutter_gastro_go/features/dish/presentation/stores/dish_list_store.dart';
import 'package:mockito/annotations.dart';

// Gera mocks para todas as stores que nossos widgets usam
@GenerateNiceMocks([
  MockSpec<RestaurantListStore>(),
  MockSpec<DishListStore>(),
  MockSpec<FavoritesStore>(),
  MockSpec<ThemeStore>(),
])
void main() {}
