import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In pt, this message translates to:
  /// **'GastroGo'**
  String get appTitle;

  /// No description provided for @navRestaurants.
  ///
  /// In pt, this message translates to:
  /// **'Restaurantes'**
  String get navRestaurants;

  /// No description provided for @navFavorites.
  ///
  /// In pt, this message translates to:
  /// **'Favoritos'**
  String get navFavorites;

  /// No description provided for @searchHint.
  ///
  /// In pt, this message translates to:
  /// **'Buscar restaurantes...'**
  String get searchHint;

  /// No description provided for @filterBy.
  ///
  /// In pt, this message translates to:
  /// **'Filtrar por'**
  String get filterBy;

  /// No description provided for @sortBy.
  ///
  /// In pt, this message translates to:
  /// **'Ordenar por'**
  String get sortBy;

  /// No description provided for @rating.
  ///
  /// In pt, this message translates to:
  /// **'Avaliação'**
  String get rating;

  /// No description provided for @distance.
  ///
  /// In pt, this message translates to:
  /// **'Distância'**
  String get distance;

  /// No description provided for @dishes.
  ///
  /// In pt, this message translates to:
  /// **'Pratos'**
  String get dishes;

  /// No description provided for @vegan.
  ///
  /// In pt, this message translates to:
  /// **'Vegano'**
  String get vegan;

  /// No description provided for @favoritesRestaurantsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Restaurantes Favoritos'**
  String get favoritesRestaurantsTitle;

  /// No description provided for @favoritesDishesTitle.
  ///
  /// In pt, this message translates to:
  /// **'Pratos Favoritos'**
  String get favoritesDishesTitle;

  /// No description provided for @errorLoading.
  ///
  /// In pt, this message translates to:
  /// **'Falha ao carregar dados'**
  String get errorLoading;

  /// No description provided for @errorRetry.
  ///
  /// In pt, this message translates to:
  /// **'Tentar Novamente'**
  String get errorRetry;

  /// No description provided for @searchDishes.
  ///
  /// In pt, this message translates to:
  /// **'Buscar no cardápio...'**
  String get searchDishes;

  /// No description provided for @filterVeganDishes.
  ///
  /// In pt, this message translates to:
  /// **'Filtrar pratos veganos'**
  String get filterVeganDishes;

  /// No description provided for @dishesLoadingError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar pratos'**
  String get dishesLoadingError;

  /// No description provided for @noDishesOnRestaurant.
  ///
  /// In pt, this message translates to:
  /// **'Este restaurante não possui pratos cadastrados.'**
  String get noDishesOnRestaurant;

  /// No description provided for @emptyFavoriteRestaurants.
  ///
  /// In pt, this message translates to:
  /// **'Você ainda não favoritou restaurantes.'**
  String get emptyFavoriteRestaurants;

  /// No description provided for @emptyFavoriteDishes.
  ///
  /// In pt, this message translates to:
  /// **'Você ainda não favoritou pratos.'**
  String get emptyFavoriteDishes;

  /// No description provided for @onboardingUpperQuote.
  ///
  /// In pt, this message translates to:
  /// **'Uma experiência culinária'**
  String get onboardingUpperQuote;

  /// No description provided for @onboardingLowerQuote.
  ///
  /// In pt, this message translates to:
  /// **'para quem está \'ready to go\'!'**
  String get onboardingLowerQuote;

  /// No description provided for @onboardingCTA.
  ///
  /// In pt, this message translates to:
  /// **'Bora!'**
  String get onboardingCTA;

  /// No description provided for @homeWelcome.
  ///
  /// In pt, this message translates to:
  /// **'Boas vindas!'**
  String get homeWelcome;

  /// No description provided for @homeCategoryCTA.
  ///
  /// In pt, this message translates to:
  /// **'Fome de quê?'**
  String get homeCategoryCTA;

  /// No description provided for @homeRestaurants.
  ///
  /// In pt, this message translates to:
  /// **'Restaurantes para você'**
  String get homeRestaurants;

  /// No description provided for @homeSearchLabel.
  ///
  /// In pt, this message translates to:
  /// **'O que você quer comer?'**
  String get homeSearchLabel;

  /// No description provided for @clean.
  ///
  /// In pt, this message translates to:
  /// **'Limpar'**
  String get clean;

  /// No description provided for @filterAndSort.
  ///
  /// In pt, this message translates to:
  /// **'Filtros e ordenação'**
  String get filterAndSort;

  /// No description provided for @onlyVegans.
  ///
  /// In pt, this message translates to:
  /// **'Apenas veganos'**
  String get onlyVegans;

  /// No description provided for @minimumRating.
  ///
  /// In pt, this message translates to:
  /// **'Avaliação mínima'**
  String get minimumRating;

  /// No description provided for @maximumDistance.
  ///
  /// In pt, this message translates to:
  /// **'Distância máxima'**
  String get maximumDistance;

  /// No description provided for @applyFilters.
  ///
  /// In pt, this message translates to:
  /// **'Aplicar filtros'**
  String get applyFilters;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
