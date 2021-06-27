// import 'package:flutter_test/flutter_test.dart';
// import 'package:vtime/core/model/day.dart';
// import 'package:vtime/core/model/task.dart';

// void main() {
//   late Day day;

//   List<Task> tasks = List<Task>.generate(
//     4,
//     (i) => Task(title: 'Task $i', description: 'Des $i'),
//   );

//   Map<String, dynamic> jsonModel = {
//     'name': 'Saturday',
//     'tasks': tasks,
//   };

//   setUpAll(() {
//     day = Day(name: 'Saturday', tasks: tasks);
//   });

//   group('[Day]', () {
//     test('converts from json correctly', () {
//       final dayFromJson = Day.fromJson(jsonModel);

//       // Need to match properties rather than instances.
//       expect(dayFromJson.name, day.name);
//       expect(dayFromJson.tasks, day.tasks);
//     });

//     test('converts to json correctly', () {
//       final dayToJson = day.toJson();

//       expect(jsonModel, dayToJson);
//     });

//     test('executes copyWith correctly', () {
//       List<Task> newTasks = tasks.getRange(0, 2).toList();

//       final sameCopiedDay = day.copyWith();
//       final customDay = day.copyWith(
//         name: 'different name',
//         tasks: newTasks,
//       );

//       // Expect nothing was changed in for sameCopiedDay.
//       expect(sameCopiedDay.name, day.name);
//       expect(sameCopiedDay.tasks, day.tasks);

//       // Expect difference between [task] and [customTask].
//       expect(customDay.name == day.name, false);
//       expect(customDay.tasks == day.tasks, false);
//     });
//   });
// }
