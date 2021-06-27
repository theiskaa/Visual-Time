import 'package:vtime/core/model/vt_model.dart';

class Day extends VTModel {
  final String? name;
  final String? title;

  const Day({
    required this.name,
    this.title,
  });

  @override
  Day copyWith({String? name,  String? title}) {
    return Day(
      name: name ?? this.name,
      title: title ?? this.title,
    );
  }

  @override
  Day.fromJson(Map<String, dynamic>? json)
      : name = json?['name'],
        title = json?['title'];

  @override
  Map<String, dynamic> toJson() => {'name': name, 'title': title};
}
