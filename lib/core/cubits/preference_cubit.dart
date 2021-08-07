import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtime/core/cubits/preference_state.dart';
import 'package:vtime/core/services/local_db_service.dart';
import 'package:vtime/view/widgets/components/themes.dart';

class PreferenceCubit extends Cubit<PreferenceState> {
  final LocalDBService? localDBService = LocalDBService();

  PreferenceCubit()
      : super(
          PreferenceState(
            theme: null,
            themeName: null,
            isAnimationsEnabled: true,
            selectedAlarmSound: 'Nonimooley',
          ),
        );

  // It used to initialize preferences of application.
  // Just looks at every preference setup and emit them to actual state.
  Future<void> initApp() async {
    var themeName = await LocalDBService.preferences().get('theme');
    var lang = await LocalDBService.preferences().get('lang');
    var alarmSound = await LocalDBService.preferences().get('alarmSound');
    var value = await LocalDBService.preferences().get('isAnimationsEnabled');

    var themes = {
      'dark': Themes().dark,
      'default': Themes().defaultTheme,
    };

    emit(state.copyWith(
      theme: themes[themeName] ?? themes['default'],
      themeName: themeName,
      langCode: lang ?? 'en',
      selectedAlarmSound: alarmSound ?? 'Nonimooley',
      isAnimationsEnabled: value ?? true,
    ));
  }

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

  Future<ThemeData?> get currentTheme async {
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

  Future<String?> get currentLang async {
    var lang = await LocalDBService.preferences().get('lang');

    emit(state.copyWith(langCode: lang ?? 'en'));

    return lang ?? 'en';
  }

  // Method to change alarm sound and emit it to cubit state.
  Future<void> changeAlarmSound(String alarmSound) async {
    await LocalDBService.preferences().put('alarmSound', alarmSound);

    emit(state.copyWith(selectedAlarmSound: alarmSound));
  }

  Future<String?> get currentAlarmSound async {
    var alarmSound = await LocalDBService.preferences().get('alarmSound');

    emit(state.copyWith(selectedAlarmSound: alarmSound ?? 'Nonimooley'));

    return alarmSound ?? 'Nonimooley';
  }

  // Method to make disable/enable animations.
  Future<void> changeStateOfAnimations(bool isAnimationsEnabled) async {
    await LocalDBService.preferences().put(
      'isAnimationsEnabled',
      isAnimationsEnabled,
    );

    emit(state.copyWith(isAnimationsEnabled: isAnimationsEnabled));
  }

  Future<bool?> get isAnimationsEnabled async {
    var value = await LocalDBService.preferences().get('isAnimationsEnabled');

    emit(state.copyWith(isAnimationsEnabled: value ?? true));

    return value ?? true;
  }
}
