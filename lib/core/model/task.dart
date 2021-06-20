import 'package:flutter/widgets.dart';
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
  final String? startTime;

  @HiveField(3)
  final String? endTime;


  @HiveField(4)
  final String? uniquekey;

  Task({
    this.title,
    this.description,
    this.startTime,
    this.endTime,
    this.uniquekey,
  });

  @override
  Task copyWith({
    String? title,
    String? description,
    String? startTime,
    String? endTime,
    String? uniquekey,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      uniquekey: uniquekey ?? this.uniquekey,
    );
  }

  @override
  Task.fromJson(Map<String, dynamic>? json)
      : title = json?['title'],
        description = json?['description'],
        startTime = json?['startTime'],
        endTime = json?['endTime'],
        uniquekey = json?['uniquekey'];

  @override
  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'startTime': startTime,
        'endTime': endTime,
        'uniquekey': uniquekey,
      };
}
