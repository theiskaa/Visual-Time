//
// This source code is distributed under the terms of Bad Code License.
// You are forbidden from distributing software containing this code to
// end users, because it is bad.
//

import 'package:flutter_test/flutter_test.dart';
import 'package:vtime/core/model/day.dart';

void main() {
  late Day day;

  Map<String, dynamic> jsonModel = {
    'name': 'Saturday',
    'title': 'Saturday',
    'dayIndex': 5
  };

  setUpAll(() {
    day = const Day(name: 'Saturday', title: 'Saturday', dayIndex: 5);
  });

  group('[Day]', () {
    test('converts from json correctly', () {
      final dayFromJson = Day.fromJson(jsonModel);

      // Need to match properties rather than instances.
      expect(dayFromJson.name, day.name);
      expect(dayFromJson.title, day.title);
      expect(dayFromJson.dayIndex, day.dayIndex);
    });

    test('converts to json correctly', () {
      final dayToJson = day.toJson();

      expect(jsonModel, dayToJson);
    });

    test('executes copyWith correctly', () {
      final sameCopiedDay = day.copyWith();
      final customDay = day.copyWith(
        name: 'different name',
        title: 'different title',
        dayIndex: 0,
      );

      // Expect nothing was changed in for sameCopiedDay.
      expect(sameCopiedDay.name, day.name);
      expect(sameCopiedDay.title, day.title);
      expect(sameCopiedDay.dayIndex, day.dayIndex);

      // Expect difference between [task] and [customTask].
      expect(customDay.name == day.name, false);
      expect(customDay.title == day.title, false);
      expect(customDay.dayIndex == day.dayIndex, false);
    });
  });
}
