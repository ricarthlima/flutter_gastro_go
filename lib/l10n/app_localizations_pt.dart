// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'GastroGo';

  @override
  String get navRestaurants => 'Restaurantes';

  @override
  String get navFavorites => 'Favoritos';

  @override
  String get searchHint => 'Buscar restaurantes...';

  @override
  String get filterBy => 'Filtrar por';

  @override
  String get sortBy => 'Ordenar por';

  @override
  String get rating => 'Avaliação';

  @override
  String get distance => 'Distância';

  @override
  String get dishes => 'Pratos';

  @override
  String get vegan => 'Vegano';

  @override
  String get favoritesRestaurantsTitle => 'Restaurantes Favoritos';

  @override
  String get favoritesDishesTitle => 'Pratos Favoritos';

  @override
  String get errorLoading => 'Falha ao carregar dados';

  @override
  String get errorRetry => 'Tentar Novamente';
}
