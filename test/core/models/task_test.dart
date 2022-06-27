//
// This source code is distributed under the terms of Bad Code License.
// You are forbidden from distributing software containing this code to
// end users, because it is bad.
//

import 'package:flutter_test/flutter_test.dart';
import 'package:vtime/core/model/task.dart';
import 'package:vtime/view/widgets/utils.dart';

void main() {
  late Task task;

  const Map<String, dynamic> jsonModel = {
    'title': 'Test title',
    'description': 'Test description',
    'hours': 5,
    'minutes': 15,
    'uniquekey': '',
  };

  setUpAll(() {
    task = Task(
      title: 'Test title',
      description: 'Test description',
      uniquekey: '',
      hours: 5,
      minutes: 15,
    );
  });

  group('[Task]', () {
    test('converts from json correctly', () {
      final taskFromJson = Task.fromJson(jsonModel);

      // Need to match properties rather than instances.
      expect(task.title, taskFromJson.title);
      expect(task.description, taskFromJson.description);
      expect(task.uniquekey, taskFromJson.uniquekey);
      expect(task.hours, taskFromJson.hours);
      expect(task.minutes, taskFromJson.minutes);
    });

    test('converts to json correctly', () {
      final taskToJson = task.toJson();

      expect(jsonModel, taskToJson);
    });

    test('executes copyWith correctly', () {
      final sameCopiedTask = task.copyWith();
      final customTask = task.copyWith(
        title: 'different task',
        description: 'different description',
        uniquekey: 'Uniquekey',
        hours: 3,
        minutes: 10,
      );

      // Expect nothing was changed in for sameCopiedTask.
      expect(sameCopiedTask.title, task.title);
      expect(sameCopiedTask.description, task.description);
      expect(sameCopiedTask.uniquekey, task.uniquekey);
      expect(sameCopiedTask.hours, task.hours);
      expect(sameCopiedTask.minutes, task.minutes);

      // Expect difference between [task] and [customTask].
      expect(customTask.title == task.title, false);
      expect(customTask.description == task.description, false);
      expect(customTask.uniquekey == task.uniquekey, false);
      expect(customTask.hours == task.hours, false);
      expect(customTask.minutes == task.minutes, false);
    });

    test('calculates totalTime correctly', () {
      double val = task.totalTime;

      double rightMinute = double.parse('0.${task.minutes}');
      double total = task.hours! + rightMinute;

      expect(total, val);
    });

    test('converts to duration correctly', () {
      var val = task.duration;
      expect(val.inHours, task.hours);
      expect(val.minute, task.minutes);
    });

    test('test remainingTimeFiller', () {
      Task remainingTimeFiller = Task().remainingTimeFiller(task.duration);

      int hours = task.totalTime.floor();
      int minutes = int.parse('${task.totalTime}'.replaceAll('$hours.', ''));

      expect(remainingTimeFiller.title, 'Remaining Time {#@!@#!@#8&**%@#%}');
      expect(remainingTimeFiller.description, '');
      expect(remainingTimeFiller.uniquekey, '');
      expect(remainingTimeFiller.hours, hours);
      expect(remainingTimeFiller.minutes, minutes);
    });
  });
}
