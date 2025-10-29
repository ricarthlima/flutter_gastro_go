// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ThemeStore on _ThemeStore, Store {
  Computed<ThemeMode>? _$themeModeComputed;

  @override
  ThemeMode get themeMode => (_$themeModeComputed ??= Computed<ThemeMode>(
    () => super.themeMode,
    name: '_ThemeStore.themeMode',
  )).value;

  late final _$isDarkThemeAtom = Atom(
    name: '_ThemeStore.isDarkTheme',
    context: context,
  );

  @override
  bool get isDarkTheme {
    _$isDarkThemeAtom.reportRead();
    return super.isDarkTheme;
  }

  @override
  set isDarkTheme(bool value) {
    _$isDarkThemeAtom.reportWrite(value, super.isDarkTheme, () {
      super.isDarkTheme = value;
    });
  }

  late final _$onLoadAsyncAction = AsyncAction(
    '_ThemeStore.onLoad',
    context: context,
  );

  @override
  Future<void> onLoad() {
    return _$onLoadAsyncAction.run(() => super.onLoad());
  }

  late final _$_ThemeStoreActionController = ActionController(
    name: '_ThemeStore',
    context: context,
  );

  @override
  void onSave() {
    final _$actionInfo = _$_ThemeStoreActionController.startAction(
      name: '_ThemeStore.onSave',
    );
    try {
      return super.onSave();
    } finally {
      _$_ThemeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDarkTheme(bool value) {
    final _$actionInfo = _$_ThemeStoreActionController.startAction(
      name: '_ThemeStore.setDarkTheme',
    );
    try {
      return super.setDarkTheme(value);
    } finally {
      _$_ThemeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleDarkTheme() {
    final _$actionInfo = _$_ThemeStoreActionController.startAction(
      name: '_ThemeStore.toggleDarkTheme',
    );
    try {
      return super.toggleDarkTheme();
    } finally {
      _$_ThemeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isDarkTheme: ${isDarkTheme},
themeMode: ${themeMode}
    ''';
  }
}
