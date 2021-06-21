import 'package:flutter_test/flutter_test.dart';
import 'package:vtime/core/model/task.dart';

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
  });
}
