import 'package:hive/hive.dart';
import 'package:vtime/core/model/vt_model.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject implements VTModel {
  @HiveField(0)
  final String? title;

  @HiveField(1)
  final String? description;

  @HiveField(2)
  final String? uniquekey;

  @HiveField(3)
  final int? hours;

  @HiveField(4)
  final int? minutes;

  Task({
    this.title,
    this.description,
    this.uniquekey,
    this.hours,
    this.minutes,
  });

  @override
  Task copyWith({
    String? title,
    String? description,
    String? uniquekey,
    int? hours,
    int? minutes,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      uniquekey: uniquekey ?? this.uniquekey,
      hours: hours ?? this.hours,
      minutes: minutes ?? this.minutes,
    );
  }

  @override
  Task.fromJson(Map<String, dynamic>? json)
      : title = json?['title'],
        description = json?['description'],
        uniquekey = json?['uniquekey'],
        hours = json?['hours'],
        minutes = json?['minutes'];

  double get totalTime {
    double rightMinute = double.parse('0.$minutes');
    double total = hours! + rightMinute;
    return total;
  }

  Task remainingTimeFiller(double totalTime) {
    int hours = totalTime.floor();
    int minutes = int.parse('$totalTime'.replaceAll('$hours.', ''));

    return Task(
      title: 'Remaining Time {#@!@#!@#8&**%@#%}',
      description: '',
      uniquekey: '',
      hours: hours,
      minutes: minutes,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'uniquekey': uniquekey,
        'hours': hours,
        'minutes': minutes,
      };
}
