import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../data/repositories/i_settings_repository.dart';

part 'theme_store.g.dart';

class ThemeStore = _ThemeStore with _$ThemeStore;

abstract class _ThemeStore with Store {
  final ISettingsRepository settingsRepository;
  _ThemeStore(this.settingsRepository);

  @observable
  bool isDarkTheme = false;

  @computed
  ThemeMode get themeMode => isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  @action
  Future<void> onLoad() async {
    isDarkTheme = await settingsRepository.getThemeMode();
  }

  @action
  void onSave() {
    settingsRepository.saveThemeMode(isDarkTheme);
  }

  @action
  void setDarkTheme(bool value) {
    isDarkTheme = value;
    onSave();
  }

  @action
  void toggleDarkTheme() {
    isDarkTheme = !isDarkTheme;
    onSave();
  }
}
