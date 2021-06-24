import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vtime/core/model/day.dart';
import 'package:vtime/core/model/task.dart';

/// A utilities class which contains shortcuts for hive db.
class LocalDBService {
  static Box<Task> mondayBox() => Hive.box<Task>('monday');
  static Box<Task> tuesdayBox() => Hive.box<Task>('tuesday');
  static Box<Task> wednesdayBox() => Hive.box<Task>('wednesday');
  static Box<Task> thursdayBox() => Hive.box<Task>('thursday');
  static Box<Task> fridayBox() => Hive.box<Task>('friday');
  static Box<Task> saturdayBox() => Hive.box<Task>('saturday');
  static Box<Task> sundayBox() => Hive.box<Task>('sunday');

  // Get right box listenable by day's name.
  ValueListenable<Box<Task>> rightListenableValue(Day day) {
    var values = {
      'Monday': LocalDBService.mondayBox().listenable(),
      'Tuesday': LocalDBService.tuesdayBox().listenable(),
      'Wednesday': LocalDBService.wednesdayBox().listenable(),
      'Thursday': LocalDBService.thursdayBox().listenable(),
      'Friday': LocalDBService.fridayBox().listenable(),
      'Saturday': LocalDBService.fridayBox().listenable(),
      'Sunday': LocalDBService.sundayBox().listenable(),
    };
    return values[day.name]!;
  }

  // Get right hive box by index.
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

  // Get right task key by checkbox id.
  String rightTaskKeyCheckBoxId(int i) {
    var values = {
      0: 'Monday',
      1: 'Tuesday',
      2: 'Wednesday',
      3: 'Thursday',
      4: 'Friday',
      5: 'Saturday',
      6: 'Sunday',
    };

    return values[i]!;
  }
}
