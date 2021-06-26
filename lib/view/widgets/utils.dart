import 'package:flutter/material.dart';
import 'package:vtime/core/model/task.dart';

class ViewUtils {
  // Generates right name by index.
  String rightDayNameGenerator(int index) {
    var values = {
      0: 'Monday',
      1: 'Tuesday',
      2: 'Wednesday',
      3: 'Thursday',
      4: 'Friday',
      5: 'Saturday',
      6: 'Sunday',
    };
    return values[index]!;
  }

  InputDecoration? nonBorderInputDecoration({
    String? hint,
  }) {
    return InputDecoration(
      hintText: hint,
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
    );
  }


static const Duration fullDay = Duration(hours: 24);

Duration calculateTotalDuration(List<Task>? tasks) {
  Duration filledAmount = Duration.zero;

  for (var i = 0; i < tasks!.length; i++) {
    filledAmount = filledAmount +
        Duration(hours: tasks[i].hours!, minutes: tasks[i].minutes!);
  }

  return filledAmount;
}

static const  divider = Divider(
    height: 5,
    thickness: 1,
    indent: 50,
    endIndent: 50,
  );
}

extension DurationToHumanLangEXT on Duration {
  String toHumanLang() {
    var inMinutes = this.inMinutes.remainder(60).toString();
    var inHours = this.inHours.toString();

    String hour = this.inHours > 1 ? 'hours' : 'hour';
    String minute = int.parse(inMinutes) > 1 ? 'minutes' : 'minute';

    if (this == Duration.zero) {
      return 'How long the todo will take?';
    }
    if (inMinutes != '0' && inHours != '0') {
      return '$inHours $hour and $inMinutes $minute';
    }
    if (inHours != '0' && inMinutes == '0') {
      return '$inHours $hour';
    }
    if (inMinutes != '0' && inHours == '0') {
      return '$inMinutes $minute';
    }

    return '';
  }

  int get minute => inMinutes.remainder(60);
}

