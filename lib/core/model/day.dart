import 'package:vtime/core/model/task.dart';
import 'package:vtime/core/model/vt_model.dart';

class Day extends VTModel {
  final String? name;
  final List<Task>? tasks;

  const Day({required this.name, this.tasks = const <Task>[]});

  @override
  Day copyWith({String? name, List<Task>? tasks}) {
    return Day(
      name: name ?? this.name,
      tasks: tasks ?? this.tasks,
    );
  }

  @override
  Day.fromJson(Map<String, dynamic>? json)
      : name = json?['name'],
        tasks = json?['tasks'];

  @override
  Map<String, dynamic> toJson() => {'name': name, 'tasks': tasks};
}
