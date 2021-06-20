import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vtime/core/model/day.dart';
import 'package:vtime/core/model/task.dart';

class LocalDBService {
  static Box<Task> mondayBox() => Hive.box<Task>('monday');
  static Box<Task> tuesdayBox() => Hive.box<Task>('tuesday');
  static Box<Task> wednesdayBox() => Hive.box<Task>('wednesday');
  static Box<Task> thursdayBox() => Hive.box<Task>('thursday');
  static Box<Task> fridayBox() => Hive.box<Task>('friday');
  static Box<Task> saturdayBox() => Hive.box<Task>('saturday');
  static Box<Task> sundayBox() => Hive.box<Task>('sunday');

  ValueListenable<Box<Task>> rightListenableValue(Day day) {
    var values = {
      'monday': LocalDBService.mondayBox().listenable(),
      'tuesday': LocalDBService.tuesdayBox().listenable(),
      'wednesday': LocalDBService.wednesdayBox().listenable(),
      'thursday': LocalDBService.thursdayBox().listenable(),
      'friday': LocalDBService.fridayBox().listenable(),
      'saturday': LocalDBService.fridayBox().listenable(),
      'sunday': LocalDBService.sundayBox().listenable(),
    };
    return values[day.name]!;
  }

  Box<Task> rightBoxByCheckBoxId(int i) {
    var values = {
      0: mondayBox(),
      1: tuesdayBox(),
      2: wednesdayBox(),
      3: thursdayBox(),
      4: fridayBox(),
      5: saturdayBox(),
      6: sundayBox(),
    };

    return values[i]!;
  }

  String rightTaskKeyCheckBoxId(int i) {
    var values = {
      0: 'monday',
      1: 'tuesday',
      2: 'wednesday',
      3: 'thursday',
      4: 'friday',
      5: 'saturday',
      6: 'sunday',
    };

    return values[i]!;
  }
}
