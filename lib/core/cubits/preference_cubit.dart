import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtime/core/cubits/preference_state.dart';
import 'package:vtime/core/services/local_db_service.dart';
import 'package:vtime/view/widgets/themes.dart';

class PreferenceCubit extends Cubit<PreferenceState> {
  final LocalDBService? localDBService = LocalDBService();

  PreferenceCubit() : super(PreferenceState(theme: null, themeName: null));

  Future<void> changeTheme(dynamic newTheme) async {
    await LocalDBService.preferences().put('theme', newTheme);

    var themes = {
      'dark': Themes().dark,
      'default': Themes().defaultTheme,
    };
    emit(state.copyWith(
      theme: themes[newTheme] ?? themes['default'],
      themeName: newTheme,
    ));
  }

  Future<ThemeData?> getCurrentTheme() async {
    var themeName = await LocalDBService.preferences().get('theme');

    var themes = {
      'dark': Themes().dark,
      'default': Themes().defaultTheme,
    };

    emit(state.copyWith(
      theme: themes[themeName] ?? themes['default'],
      themeName: themeName,
    ));

    return themes[themeName] ?? themes['default'];
  }

  // Method to change language and emit new language to cubit state.
  Future<void> changeLang(dynamic newLang) async {
    await LocalDBService.preferences().put('lang', newLang);

    emit(state.copyWith(langCode: newLang));
  }

  // Method to change language and emit new language to cubit state.
  Future<String?> getCurrentLang() async {
    var lang = await LocalDBService.preferences().get('lang');

    emit(state.copyWith(langCode: lang ?? 'en'));

    return lang ?? 'en';
  }
}
