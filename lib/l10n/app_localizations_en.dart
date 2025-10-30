// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'GastroGo';

  @override
  String get navRestaurants => 'Restaurants';

  @override
  String get navFavorites => 'Favorites';

  @override
  String get searchHint => 'Search restaurants...';

  @override
  String get filterBy => 'Filter by';

  @override
  String get sortBy => 'Sort by';

  @override
  String get rating => 'Rating';

  @override
  String get distance => 'Distance';

  @override
  String get dishes => 'Dishes';

  @override
  String get vegan => 'Vegan';

  @override
  String get favoritesRestaurantsTitle => 'Favorite Restaurants';

  @override
  String get favoritesDishesTitle => 'Favorite Dishes';

  @override
  String get errorLoading => 'Failed to load data';

  @override
  String get errorRetry => 'Try Again';

  @override
  String get searchDishes => 'Search the menu...';

  @override
  String get filterVeganDishes => 'Filter vegan dishes';

  @override
  String get dishesLoadingError => 'Error loading dishes';

  @override
  String get noDishesOnRestaurant => 'This restaurant has no dishes yet.';

  @override
  String get emptyFavoriteRestaurants =>
      'You haven\'t favorited any restaurants yet.';

  @override
  String get emptyFavoriteDishes => 'You haven\'t favorited any dishes yet.';

  @override
  String get onboardingUpperQuote => 'A culinary experience';

  @override
  String get onboardingLowerQuote => 'for those who are \'ready to go\'!';

  @override
  String get onboardingCTA => 'Let\'s go!';

  @override
  String get homeWelcome => 'Welcome!';

  @override
  String get homeCategoryCTA => 'What are you craving?';

  @override
  String get homeRestaurants => 'Restaurants for you';

  @override
  String get homeSearchLabel => 'What do you want to eat?';

  @override
  String get clean => 'Clean';

  @override
  String get filterAndSort => 'Filter and Sort';

  @override
  String get onlyVegans => 'Only vegan';

  @override
  String get minimumRating => 'Minimum Rating';

  @override
  String get maximumDistance => 'Maximum Distance';

  @override
  String get applyFilters => 'Apply Filters';
}
