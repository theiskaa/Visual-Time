import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vtime/view/widgets/utils.dart';

void main() {
  late ViewUtils viewUtils;

  setUpAll(() {
    viewUtils = ViewUtils();
  });

  group('[ViewUtils]', () {
    test('test rightDayNameGenerator', () {
      expect(viewUtils.rightDayNameGenerator(0), 'Monday');
      expect(viewUtils.rightDayNameGenerator(1), 'Tuesday');
      expect(viewUtils.rightDayNameGenerator(2), 'Wednesday');
      expect(viewUtils.rightDayNameGenerator(3), 'Thursday');
      expect(viewUtils.rightDayNameGenerator(4), 'Friday');
      expect(viewUtils.rightDayNameGenerator(5), 'Saturday');
      expect(viewUtils.rightDayNameGenerator(6), 'Sunday');
    });

    test('test nonBorderInputDecoration', () {
      var nonBorderInputDecoration =
          viewUtils.nonBorderInputDecoration(hint: 'test');
      expect(nonBorderInputDecoration?.hintText, 'test');
      expect(nonBorderInputDecoration?.border, InputBorder.none);
      expect(nonBorderInputDecoration?.focusedBorder, InputBorder.none);
      expect(nonBorderInputDecoration?.enabledBorder, InputBorder.none);
      expect(nonBorderInputDecoration?.errorBorder, InputBorder.none);
      expect(nonBorderInputDecoration?.disabledBorder, InputBorder.none);
      expect(nonBorderInputDecoration?.focusedErrorBorder, InputBorder.none);
    });
  });

  group('Exts', () {
    test('DurationToHumanLangEXT', () {
      Duration minute = const Duration(minutes: 10, hours: 0);
      Duration hour = const Duration(hours: 5, minutes: 0);
      Duration hourAndMinute = const Duration(hours: 5, minutes: 10);

      expect(Duration.zero.toHumanLang(), 'How long the todo will take?');
      expect(minute.toHumanLang(), '10 minutes');
      expect(hour.toHumanLang(), '5 hours');
      expect(hourAndMinute.toHumanLang(), '5 hours and 10 minutes');
    });
  });
}
