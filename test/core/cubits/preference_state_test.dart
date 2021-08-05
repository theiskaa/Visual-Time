import 'package:flutter_test/flutter_test.dart';
import 'package:vtime/core/cubits/preference_state.dart';
import 'package:vtime/view/widgets/components/themes.dart';

void main() {
  late PreferenceState preferenceState;

  setUpAll(() {
    preferenceState = PreferenceState(
      langCode: 'en',
      themeName: 'default',
      theme: Themes().defaultTheme,
      selectedAlarmSound: 'Sound 1',
      isAnimationsEnabled: true,
    );
  });

  group('[PreferenceState]', () {
    test('executes copyWith correctly', () {
      final sameCopiedState = preferenceState.copyWith();
      final customState = preferenceState.copyWith(
        theme: Themes().dark,
        themeName: 'dark',
        langCode: 'ka', // ka = kartuli -> Georgian language
        selectedAlarmSound: 'Sound 2',
        isAnimationsEnabled: false,
      );

      // Expect nothing was changed in for sameCopiedDay.
      expect(sameCopiedState.theme, preferenceState.theme);
      expect(sameCopiedState.themeName, preferenceState.themeName);
      expect(sameCopiedState.langCode, preferenceState.langCode);
      expect(
        sameCopiedState.selectedAlarmSound,
        preferenceState.selectedAlarmSound,
      );
      expect(
        sameCopiedState.isAnimationsEnabled,
        preferenceState.isAnimationsEnabled,
      );

      // Expect difference between [task] and [customTask].
      expect(customState.theme == preferenceState.theme, false);
      expect(customState.themeName == preferenceState.themeName, false);
      expect(customState.langCode == preferenceState.langCode, false);
      expect(
        customState.selectedAlarmSound == preferenceState.selectedAlarmSound,
        false,
      );
      expect(
        customState.isAnimationsEnabled == preferenceState.isAnimationsEnabled,
        false,
      );
    });
  });
}
