//
// This source code is distributed under the terms of Bad Code License.
// You are forbidden from distributing software containing this code to
// end users, because it is bad.
//

import 'package:flutter/material.dart';

class PreferenceState {
  final ThemeData? theme;
  final String? themeName;
  final String? langCode;
  final String? selectedAlarmSound;
  final bool? isAnimationsEnabled;

  PreferenceState({
    this.theme,
    this.themeName,
    this.langCode,
    this.selectedAlarmSound,
    this.isAnimationsEnabled,
  });

  PreferenceState copyWith({
    ThemeData? theme,
    String? themeName,
    String? langCode,
    String? selectedAlarmSound,
    bool? isAnimationsEnabled,
  }) {
    return PreferenceState(
      theme: theme ?? this.theme,
      themeName: themeName ?? this.themeName,
      langCode: langCode ?? this.langCode,
      selectedAlarmSound: selectedAlarmSound ?? this.selectedAlarmSound,
      isAnimationsEnabled: isAnimationsEnabled ?? this.isAnimationsEnabled,
    );
  }
}
