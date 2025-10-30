import 'package:flutter/material.dart';
import 'package:flutter_gastro_go/core/injection/injection_container.dart';
import 'package:flutter_gastro_go/features/dish/domain/entities/dish_dto.dart';
import 'package:flutter_gastro_go/features/dish/presentation/pages/dishes_screen.dart';
import 'package:flutter_gastro_go/features/dish/presentation/stores/dish_list_store.dart';
import 'package:flutter_gastro_go/features/favorite/presentation/stores/favorites_store.dart';
import 'package:flutter_gastro_go/features/restaurant/domain/entities/restaurant_dto.dart';
import 'package:flutter_gastro_go/features/settings/domain/stores/theme_store.dart';
import 'package:flutter_gastro_go/l10n/app_localizations.dart';
import 'package:flutter_gastro_go/shared/widgets/loading_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart' show ObservableList;
import 'package:mockito/mockito.dart';

import '../../../mocks/app_mocks.mocks.dart';

// (Helper para embrulhar o widget)
Widget createTestApp(Widget child) {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    locale: Locale('pt', 'BR'),
    home: child,
  );
}

void main() {
  late MockDishListStore mockDishListStore;
  late MockFavoritesStore mockFavoritesStore;
  late MockThemeStore mockThemeStore;

  // Restaurante falso para passar como argumento
  final fakeRestaurant = RestaurantDto(
    id: 'r1',
    name: 'Restaurante de Detalhe',
    description: 'Desc',
    distance: 1,
    categories: ['Teste'],
    rating: 5,
  );

  setUp(() {
    getIt.reset();
    mockDishListStore = MockDishListStore();
    mockFavoritesStore = MockFavoritesStore();
    mockThemeStore = MockThemeStore();

    getIt.registerSingleton<ThemeStore>(mockThemeStore);
    getIt.registerSingleton<FavoritesStore>(mockFavoritesStore);
    // Registra como Factory, assim como no seu setup real
    getIt.registerFactory<DishListStore>(() => mockDishListStore);

    when(mockThemeStore.themeMode).thenReturn(ThemeMode.light);
    when(mockFavoritesStore.isDishFavorite(any)).thenReturn(false);
  });

  testWidgets('deve exibir CircularProgressIndicator quando isLoading é true', (
    WidgetTester tester,
  ) async {
    // 3. Configure o estado do Mock
    when(mockDishListStore.isLoading).thenReturn(true);
    when(mockDishListStore.hasError).thenReturn(false);
    when(mockDishListStore.loadDishes(any)).thenAnswer((_) async => {});

    // 4. Renderize a tela (precisamos passar o restaurante)
    await tester.pumpWidget(
      createTestApp(DishesScreen(restaurant: fakeRestaurant)),
    );
    await tester.pump(); // Aguarda os Futures do initState

    // 5. Verifique
    expect(find.byType(LoadingWidget), findsOneWidget);
  });

  testWidgets('deve exibir a lista de pratos quando carregar com sucesso', (
    WidgetTester tester,
  ) async {
    // 3. Configure o estado do Mock
    final fakeDish = DishDto(
      id: 'd1',
      name: 'Prato Falso Teste',
      description: 'Desc Prato',
      price: 10,
      isVegan: false,
      restaurantId: 'r1',
    );
    when(mockDishListStore.isLoading).thenReturn(false);
    when(mockDishListStore.hasError).thenReturn(false);
    when(mockDishListStore.isEmpty).thenReturn(false);
    when(mockDishListStore.dishes).thenReturn(ObservableList.of([fakeDish]));
    when(mockDishListStore.loadDishes(any)).thenAnswer((_) async => {});

    // 4. Renderize a tela
    await tester.pumpWidget(
      createTestApp(DishesScreen(restaurant: fakeRestaurant)),
    );
    await tester.pump();

    // 5. Verifique
    expect(find.text('Restaurante de Detalhe'), findsOneWidget); // (No AppBar)
    expect(
      find.text('Prato Falso Teste'),
      findsOneWidget,
    ); // (No item da lista)
    expect(find.byType(LoadingWidget), findsNothing);
  });
}
