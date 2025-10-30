import 'package:go_router/go_router.dart';

import '../../features/dish/presentation/pages/dishes_screen.dart';
import '../../features/favorite/presentation/pages/favorite_screen.dart';
import '../../features/onboarding/presentation/pages/onboarding_screen.dart';
import '../../features/restaurant/domain/entities/restaurant_dto.dart';
import '../../features/restaurant/presentation/pages/restaurants_screen.dart';

class AppRouter {
  static const String onboarding = '/';
  static const String restaurants = '/restaurants';
  static const String dishes = 'dishes/:rid'; // Rota filha
  static const String favorites = '/favorites';

  static final GoRouter router = GoRouter(
    initialLocation: onboarding,
    routes: [
      GoRoute(
        path: onboarding,
        name: onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: restaurants,
        name: restaurants,
        builder: (context, state) => const RestaurantsScreen(),
        routes: [
          GoRoute(
            path: dishes,
            name: dishes,
            builder: (context, state) {
              final restaurant = state.extra as RestaurantDto;
              return DishesScreen(restaurant: restaurant);
            },
          ),
        ],
      ),
      GoRoute(
        path: favorites,
        name: favorites,
        builder: (context, state) => const FavoriteScreen(),
      ),
    ],
  );
}
