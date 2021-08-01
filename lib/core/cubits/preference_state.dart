import 'package:flutter/material.dart';

class PreferenceState {
  final ThemeData? theme;
  final String? themeName;
  final String? langCode;
  final String? selectedAlarmSound;

  PreferenceState({
    this.theme,
    this.themeName,
    this.langCode,
    this.selectedAlarmSound,
  });

  PreferenceState copyWith({
    ThemeData? theme,
    String? themeName,
    String? langCode,
    String? selectedAlarmSound,
  }) {
    return PreferenceState(
      theme: theme ?? this.theme,
      themeName: themeName ?? this.themeName,
      langCode: langCode ?? this.langCode,
      selectedAlarmSound: selectedAlarmSound ?? this.selectedAlarmSound,
    );
  }
}
