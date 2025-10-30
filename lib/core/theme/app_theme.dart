import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTheme {
  static const _baseTextTheme = TextTheme(
    headlineMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
    bodyMedium: TextStyle(fontSize: 16, height: 1.5),
    titleMedium: TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
    titleSmall: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
  );

  static final _baseShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  );

  static final InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(width: 1, color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(width: 1, color: AppColors.main),
        ),
        focusColor: AppColors.main,
        filled: true,
        fillColor: Colors.grey[900],
      );

  static final AppBarTheme _appBarTheme = AppBarTheme(centerTitle: true);

  static final ElevatedButtonThemeData _elevatedButtonThemeData =
      ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateColor.resolveWith((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.pressed)) {
              return AppColors.main.withAlpha(200);
            } else if (states.contains(WidgetState.disabled)) {
              return AppColors.main.withAlpha(125);
            }
            return AppColors.main;
          }),
          foregroundColor: WidgetStatePropertyAll(Colors.black),
        ),
      );

  static const _lightColorScheme = ColorScheme.light(
    primary: AppColors.main, // Cor principal (botões, appbar)
    onPrimary: Colors.white, // Cor do texto em cima do 'primary'
    secondary: AppColors.detach, // Cor secundária (FABs, toggles)
    surface: AppColors.backgroundLight, // Cor de superfície (Cards)
    onSurface: Colors.black, // Cor do texto em cima do 'surface'
    error: Colors.red,
    onError: Colors.white,
  );

  static const _darkColorScheme = ColorScheme.light(
    primary: AppColors.main, // Cor principal (botões, appbar)
    onPrimary: Colors.white, // Cor do texto em cima do 'primary'
    secondary: AppColors.detach, // Cor secundária (FABs, toggles)
    surface: AppColors.background, // Cor de superfície (Cards)
    onSurface: AppColors.backgroundAccentLight,
    error: Colors.red,
    onError: Colors.white,
  );

  // --- 4. TEMA CLARO (Juntando tudo) ---
  static final ThemeData lightTheme =
      ThemeData.from(
        colorScheme: _lightColorScheme,
        useMaterial3: true,
      ).copyWith(
        scaffoldBackgroundColor: AppColors.backgroundLight,
        elevatedButtonTheme: _elevatedButtonThemeData,
        appBarTheme: _appBarTheme,
        textTheme: _baseTextTheme,
        inputDecorationTheme: _inputDecorationTheme,
        cardTheme: CardThemeData(shape: _baseShape, elevation: 6),
      );

  // --- 6. TEMA ESCURO (Juntando tudo) ---
  static final ThemeData darkTheme =
      ThemeData.from(
        colorScheme: _darkColorScheme,
        useMaterial3: true,
      ).copyWith(
        scaffoldBackgroundColor: AppColors.background,
        elevatedButtonTheme: _elevatedButtonThemeData,
        appBarTheme: _appBarTheme,
        textTheme: _baseTextTheme,
        inputDecorationTheme: _inputDecorationTheme,
        cardTheme: CardThemeData(shape: _baseShape, elevation: 6),
      );
}
