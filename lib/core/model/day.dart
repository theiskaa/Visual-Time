import 'package:vtime/core/model/vt_model.dart';

class Day extends VTModel {
  final String? name;
  final String? title;
  final int? dayIndex;

  const Day({required this.name, this.title, required this.dayIndex});

  @override
  Day copyWith({String? name, String? title, int? dayIndex}) {
    return Day(
        name: name ?? this.name,
        title: title ?? this.title,
        dayIndex: dayIndex);
  }

  @override
  Day.fromJson(Map<String, dynamic>? json)
      : name = json?['name'],
        title = json?['title'],
        dayIndex = json?['dayIndex'];

  @override
  Map<String, dynamic> toJson() =>
      {'name': name, 'title': title, 'dayIndex': dayIndex};
}
