import 'package:flutter_test/flutter_test.dart';
import 'package:vtime/core/model/day.dart';
import 'package:vtime/core/utils/utils.dart';

void main() {
  const testWeekDays = <Day>[
    Day(name: 'Monday'),
    Day(name: 'Tuesday'),
    Day(name: 'Wednesday'),
    Day(name: 'Thursday'),
    Day(name: 'Friday'),
    Day(name: 'Saturday'),
    Day(name: 'Sunday'),
  ];

  test('weekDays list', () {
    expect(testWeekDays, weekDays);
  });
}
