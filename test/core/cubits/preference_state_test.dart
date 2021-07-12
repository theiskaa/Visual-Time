import 'package:flutter_test/flutter_test.dart';
import 'package:vtime/core/cubits/preference_state.dart';
import 'package:vtime/view/widgets/themes.dart';

void main() {
  late PreferenceState preferenceState;

  setUpAll(() {
    preferenceState = PreferenceState(
      langCode: 'en',
      themeName: 'default',
      theme: Themes().defaultTheme,
    );
  });

  group('[PreferenceState]', () {
    test('executes copyWith correctly', () {
      final sameCopiedState = preferenceState.copyWith();
      final customState = preferenceState.copyWith(
        theme: Themes().dark,
        themeName: 'dark',
        langCode: 'ka', // ka = kartuli -> Georgian language
      );

      // Expect nothing was changed in for sameCopiedDay.
      expect(sameCopiedState.theme, preferenceState.theme);
      expect(sameCopiedState.themeName, preferenceState.themeName);
      expect(sameCopiedState.langCode, preferenceState.langCode);

      // Expect difference between [task] and [customTask].
       expect(customState.theme == preferenceState.theme, false);
      expect(customState.themeName == preferenceState.themeName, false);
      expect(customState.langCode== preferenceState.langCode, false);
    });
  });
}
