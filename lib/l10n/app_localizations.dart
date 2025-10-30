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
    Locale('pt', 'BR'),
  ];

  /// Description for appTitle
  ///
  /// In pt, this message translates to:
  /// **'GastroGo'**
  String get appTitle;

  /// Description for navRestaurants
  ///
  /// In pt, this message translates to:
  /// **'Restaurantes'**
  String get navRestaurants;

  /// Description for navFavorites
  ///
  /// In pt, this message translates to:
  /// **'Favoritos'**
  String get navFavorites;

  /// Description for searchHint
  ///
  /// In pt, this message translates to:
  /// **'Buscar restaurantes...'**
  String get searchHint;

  /// Description for filterBy
  ///
  /// In pt, this message translates to:
  /// **'Filtrar por'**
  String get filterBy;

  /// Description for sortBy
  ///
  /// In pt, this message translates to:
  /// **'Ordenar por'**
  String get sortBy;

  /// Description for rating
  ///
  /// In pt, this message translates to:
  /// **'Avaliação'**
  String get rating;

  /// Description for distance
  ///
  /// In pt, this message translates to:
  /// **'Distância'**
  String get distance;

  /// Description for dishes
  ///
  /// In pt, this message translates to:
  /// **'Pratos'**
  String get dishes;

  /// Description for vegan
  ///
  /// In pt, this message translates to:
  /// **'Vegano'**
  String get vegan;

  /// Description for favoritesRestaurantsTitle
  ///
  /// In pt, this message translates to:
  /// **'Restaurantes Favoritos'**
  String get favoritesRestaurantsTitle;

  /// Description for favoritesDishesTitle
  ///
  /// In pt, this message translates to:
  /// **'Pratos Favoritos'**
  String get favoritesDishesTitle;

  /// Description for errorLoading
  ///
  /// In pt, this message translates to:
  /// **'Falha ao carregar dados'**
  String get errorLoading;

  /// Description for errorRetry
  ///
  /// In pt, this message translates to:
  /// **'Tentar Novamente'**
  String get errorRetry;

  /// Description for searchDishes
  ///
  /// In pt, this message translates to:
  /// **'Buscar no cardápio...'**
  String get searchDishes;

  /// Description for filterVeganDishes
  ///
  /// In pt, this message translates to:
  /// **'Filtrar pratos veganos'**
  String get filterVeganDishes;

  /// Description for dishesLoadingError
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar pratos'**
  String get dishesLoadingError;

  /// Description for noDishesOnRestaurant
  ///
  /// In pt, this message translates to:
  /// **'Este restaurante não possui pratos cadastrados.'**
  String get noDishesOnRestaurant;

  /// Description for emptyFavoriteRestaurants
  ///
  /// In pt, this message translates to:
  /// **'Você ainda não favoritou restaurantes.'**
  String get emptyFavoriteRestaurants;

  /// Description for emptyFavoriteDishes
  ///
  /// In pt, this message translates to:
  /// **'Você ainda não favoritou pratos.'**
  String get emptyFavoriteDishes;

  /// Description for onboardingUpperQuote
  ///
  /// In pt, this message translates to:
  /// **'Uma experiência culinária'**
  String get onboardingUpperQuote;

  /// Description for onboardingLowerQuote
  ///
  /// In pt, this message translates to:
  /// **'para quem está \'ready to go\'!'**
  String get onboardingLowerQuote;

  /// Description for onboardingCTA
  ///
  /// In pt, this message translates to:
  /// **'Bora!'**
  String get onboardingCTA;

  /// Description for homeWelcome
  ///
  /// In pt, this message translates to:
  /// **'Boas vindas!'**
  String get homeWelcome;

  /// Description for homeCategoryCTA
  ///
  /// In pt, this message translates to:
  /// **'Fome de quê?'**
  String get homeCategoryCTA;

  /// Description for homeRestaurants
  ///
  /// In pt, this message translates to:
  /// **'Restaurantes para você'**
  String get homeRestaurants;

  /// Description for homeSearchLabel
  ///
  /// In pt, this message translates to:
  /// **'O que você quer comer?'**
  String get homeSearchLabel;

  /// Description for clean
  ///
  /// In pt, this message translates to:
  /// **'Limpar'**
  String get clean;

  /// Description for filterAndSort
  ///
  /// In pt, this message translates to:
  /// **'Filtros e ordenação'**
  String get filterAndSort;

  /// Description for onlyVegans
  ///
  /// In pt, this message translates to:
  /// **'Apenas veganos'**
  String get onlyVegans;

  /// Description for minimumRating
  ///
  /// In pt, this message translates to:
  /// **'Avaliação mínima'**
  String get minimumRating;

  /// Description for maximumDistance
  ///
  /// In pt, this message translates to:
  /// **'Distância máxima'**
  String get maximumDistance;

  /// Description for applyFilters
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
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
        }
        break;
      }
  }

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
