import 'package:flutter/material.dart';

class PreferenceState {
  final ThemeData? theme;
  final String? themeName;
  final String? langCode;

  PreferenceState({this.theme, this.themeName, this.langCode});

  PreferenceState copyWith({
    ThemeData? theme,
    String? themeName,
    String? langCode,
  }) {
    return PreferenceState(
      theme: theme ?? this.theme,
      themeName: themeName ?? this.themeName,
      langCode: langCode ?? this.langCode,
    );
  }
}
