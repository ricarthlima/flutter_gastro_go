import 'package:flutter/material.dart';
import 'package:flutter_gastro_go/core/injection/injection_container.dart';
import 'package:flutter_gastro_go/core/navigation/app_router.dart';
import 'package:flutter_gastro_go/core/theme/app_theme.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'features/settings/domain/stores/theme_store.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupInjections();
  await getIt.allReady();

  await getIt<ThemeStore>().onLoad();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
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
