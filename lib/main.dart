import 'package:flutter/material.dart';
import 'package:flutter_gastro_go/core/injection/injection_container.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'features/settings/domain/stores/theme_store.dart';

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
      builder: (_) => MaterialApp(
        theme: ThemeData(),
        darkTheme: ThemeData.dark(),
        themeMode: getIt<ThemeStore>().themeMode,
        home: ChangeThemeScreen(),
      ),
    );
  }
}

// Só pra testar a reação do thememode
class ChangeThemeScreen extends StatelessWidget {
  const ChangeThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeStore = getIt<ThemeStore>();

    return Scaffold(
      body: Center(
        child: Observer(
          builder: (_) => Switch(
            value: themeStore.isDarkTheme,
            thumbIcon: WidgetStateProperty.resolveWith((states) {
              if (!states.contains(WidgetState.selected)) {
                return Icon(Icons.sunny);
              }
              return Icon(Icons.nightlight);
            }),
            onChanged: (value) {
              themeStore.toggleDarkTheme();
            },
          ),
        ),
      ),
    );
  }
}
