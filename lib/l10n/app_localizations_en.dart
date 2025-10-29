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
}
