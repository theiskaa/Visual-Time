import 'package:flutter_test/flutter_test.dart';
import 'package:vtime/core/model/day.dart';

void main() {
  late Day day;

  Map<String, dynamic> jsonModel = {
    'name': 'Saturday',
    'title': 'Saturday',
  };

  setUpAll(() {
    day = const Day(name: 'Saturday', title: 'Saturday');
  });

  group('[Day]', () {
    test('converts from json correctly', () {
      final dayFromJson = Day.fromJson(jsonModel);

      // Need to match properties rather than instances.
      expect(dayFromJson.name, day.name);
      expect(dayFromJson.title, day.title);
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
      );

      // Expect nothing was changed in for sameCopiedDay.
      expect(sameCopiedDay.name, day.name);
      expect(sameCopiedDay.title, day.title);

      // Expect difference between [task] and [customTask].
      expect(customDay.name == day.name, false);
      expect(customDay.title == day.title, false);
    });
  });
}
