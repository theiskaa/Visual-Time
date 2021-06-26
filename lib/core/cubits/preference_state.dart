import 'package:flutter/material.dart';

class PreferenceState {
  final ThemeData? theme;
  final String? themeName;

  PreferenceState({this.theme, this.themeName});

  PreferenceState copyWith({ThemeData? theme, String? themeName}) {
    return PreferenceState(
      theme: theme ?? this.theme,
      themeName: themeName ?? this.themeName,
    );
  }
}
