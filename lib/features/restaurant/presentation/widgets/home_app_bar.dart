import 'package:flutter/material.dart';
import 'package:flutter_gastro_go/core/injection/injection_container.dart';
import 'package:flutter_gastro_go/features/settings/domain/stores/theme_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  const HomeAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    final themeStore = getIt<ThemeStore>();

    return AppBar(
      title: title != null
          ? Text(title!)
          : Image.asset("assets/images/logo.png", height: 48),
      centerTitle: title != null,
      toolbarHeight: 72,
      actions: [
        IconButton(icon: Icon(Icons.favorite), onPressed: () {}),
        Observer(
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
        SizedBox(width: 16),
      ],
    );
  }

  // 2. Você DEVE implementar este getter.
  //    Ele informa ao Scaffold a altura da sua AppBar.
  //    kToolbarHeight é a altura padrão da AppBar do Flutter.
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
