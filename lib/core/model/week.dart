import 'package:vtime/core/model/vt_model.dart';

import 'day.dart';

class Week extends VTModel {
  final List<Day>? weekDays;
  Week({required this.weekDays}) : assert(weekDays!.length <= 7);

  @override
  Week copyWith({List<Day>? weekDays}) {
    return Week(weekDays: weekDays ?? this.weekDays);
  }

  Week.fromJson(Map<String, dynamic>? json) : weekDays = json?['weekDays'];

  @override
  Map<String, dynamic> toJson() => {'weekDays': weekDays};
}
