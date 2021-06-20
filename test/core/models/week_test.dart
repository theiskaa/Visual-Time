import 'package:flutter_test/flutter_test.dart';
import 'package:vtime/core/model/day.dart';
import 'package:vtime/core/model/task.dart';
import 'package:vtime/core/model/week.dart';

void main() {
  late Week week;

  List<Day> days = List<Day>.generate(
    7,
    (i) => Day(name: 'Day $i', tasks: <Task>[]),
  );

  Map<String, dynamic> jsonModel = {'weekDays': days};

  setUpAll(() {
    week = Week(weekDays: days);
  });

  group('[Week]', () {
    test('converts from json correctly', () {
      final weekFromJson = Week.fromJson(jsonModel);

      // Need to match properties rather than instances.
      expect(weekFromJson.weekDays, week.weekDays);
    });

    test('converts to json correctly', () {
      final weekToJson = week.toJson();

      expect(jsonModel, weekToJson);
    });

    test('executes copyWith correctly', () {
      List<Day> newDays = List<Day>.generate(
        7,
        (index) => Day(name: '$index', tasks: <Task>[]),
      );

      final sameCopiedWeek = week.copyWith();
      final customWeek = week.copyWith(weekDays: newDays);

      // Expect nothing was changed in for sameCopiedDay.
      expect(sameCopiedWeek.weekDays, week.weekDays);

      // Expect difference between [task] and [customTask].
      expect(customWeek.weekDays == week.weekDays, false);
    });
  });
}
