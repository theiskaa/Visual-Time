import 'package:flutter_test/flutter_test.dart';
import 'package:vtime/core/model/task.dart';

void main() {
  late Task task;

  const Map<String, dynamic> jsonModel = {
    'title': 'Test title',
    'description': 'Test description',
    'startTime': '12:00',
    'endTime': '18:00',
    'uniquekey': '',
  };

  setUpAll(() {
    task = Task(
      title: 'Test title',
      description: 'Test description',
      startTime: '12:00',
      endTime: '18:00',
      uniquekey: '',
    );
  });

  group('[Task]', () {
    test('converts from json correctly', () {
      final taskFromJson = Task.fromJson(jsonModel);

      // Need to match properties rather than instances.
      expect(task.title, taskFromJson.title);
      expect(task.description, taskFromJson.description);
      expect(task.startTime, taskFromJson.startTime);
      expect(task.endTime, taskFromJson.endTime);
      expect(task.uniquekey, taskFromJson.uniquekey);
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
        startTime: '18:00',
        endTime: '12:00',
        uniquekey: 'Uniquekey',
      );

      // Expect nothing was changed in for sameCopiedTask.
      expect(sameCopiedTask.title, task.title);
      expect(sameCopiedTask.description, task.description);
      expect(sameCopiedTask.startTime, task.startTime);
      expect(sameCopiedTask.endTime, task.endTime);
      expect(sameCopiedTask.uniquekey, task.uniquekey);

      // Expect difference between [task] and [customTask].
      expect(customTask.title == task.title, false);
      expect(customTask.description == task.description, false);
      expect(customTask.startTime == task.startTime, false);
      expect(customTask.endTime == task.endTime, false);
      expect(customTask.uniquekey == task.uniquekey, false);
    });
  });
}
