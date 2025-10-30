import 'package:flutter/material.dart';
import 'package:flutter_gastro_go/core/injection/injection_container.dart';
import 'package:flutter_gastro_go/features/favorite/presentation/stores/favorites_store.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/entities/restaurant_dto.dart';
import 'package:flutter_gastro_go/features/restaurant/presentation/pages/restaurants_screen.dart';
import 'package:flutter_gastro_go/features/restaurant/presentation/stores/restaurant_list_store.dart';
import 'package:flutter_gastro_go/features/settings/domain/stores/theme_store.dart';
import 'package:flutter_gastro_go/l10n/app_localizations.dart';
import 'package:flutter_gastro_go/shared/widgets/loading_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' show ObservableList;
import 'package:mockito/mockito.dart';

// Importe o mock gerado
import '../../../mocks/app_mocks.mocks.dart';

// Um helper para embrulhar nossos widgets no MaterialApp
Widget createTestApp(Widget child) {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    locale: Locale('pt', 'BR'),
    home: child,
  );
}

void main() {
  // 1. Declare os Mocks
  late MockRestaurantListStore mockRestaurantListStore;
  late MockFavoritesStore mockFavoritesStore;
  late MockThemeStore mockThemeStore;

  // 2. Registre os Mocks no GetIt
  setUp(() {
    getIt.reset(); // Limpa o GetIt
    mockRestaurantListStore = MockRestaurantListStore();
    mockFavoritesStore = MockFavoritesStore();
    mockThemeStore = MockThemeStore();

    // Registra os mocks
    getIt.registerSingleton<ThemeStore>(mockThemeStore);
    getIt.registerSingleton<FavoritesStore>(mockFavoritesStore);
    getIt.registerSingleton<RestaurantListStore>(mockRestaurantListStore);

    // Configuração padrão para os mocks
    when(mockThemeStore.themeMode).thenReturn(ThemeMode.light);
    when(mockFavoritesStore.isRestaurantFavorite(any)).thenReturn(false);
  });

  testWidgets('deve exibir CircularProgressIndicator quando isLoading é true', (
    WidgetTester tester,
  ) async {
    // 3. Configure o estado do Mock
    when(mockRestaurantListStore.isLoading).thenReturn(true);
    when(mockRestaurantListStore.hasError).thenReturn(false);

    // 4. Renderize a tela
    await tester.pumpWidget(createTestApp(const RestaurantsScreen()));

    // 5. Verifique
    expect(find.byType(LoadingWidget), findsOneWidget);
  });

  testWidgets(
    'deve exibir a lista de restaurantes quando carregar com sucesso',
    (WidgetTester tester) async {
      // 3. Configure o estado do Mock
      final fakeRestaurant = RestaurantDto(
        id: 'r1',
        name: 'Restaurante Falso Teste',
        description: 'Desc',
        distance: 1,
        categories: ['Teste'],
        rating: 5,
      );
      when(mockRestaurantListStore.isLoading).thenReturn(false);
      when(mockRestaurantListStore.hasError).thenReturn(false);
      when(mockRestaurantListStore.isEmpty).thenReturn(false);
      // (Usando 'restaurants' da sua versão revertida)
      when(
        mockRestaurantListStore.restaurants,
      ).thenReturn(ObservableList.of([fakeRestaurant]));

      // 4. Renderize a tela
      await tester.pumpWidget(createTestApp(const RestaurantsScreen()));

      // 5. Verifique
      expect(find.text("Boas vindas!"), findsOneWidget);
      expect(find.text("Restaurante Falso Teste"), findsOneWidget);
      expect(find.byType(LoadingWidget), findsNothing);
    },
  );
}
