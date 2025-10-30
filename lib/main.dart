import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gastro_go/core/injection/injection_container.dart';
import 'package:flutter_gastro_go/core/navigation/app_router.dart';
import 'package:flutter_gastro_go/core/theme/app_theme.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'features/favorite/presentation/stores/favorites_store.dart';
import 'features/settings/domain/stores/theme_store.dart';
import 'l10n/app_localizations.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await setupInjections();
  await getIt.allReady();

  await getIt<ThemeStore>().onLoad();
  await getIt<FavoritesStore>().loadAllFavoriteIds();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return Observer(
      builder: (_) => MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        onGenerateTitle: (context) {
          return AppLocalizations.of(context)?.appTitle ?? 'GastroGo';
        },
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: getIt<ThemeStore>().themeMode,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
