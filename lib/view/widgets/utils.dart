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

  Widget get divider {
    return const Divider(
      height: 5,
      thickness: 1,
      indent: 50,
      endIndent: 50,
    );
  }
}

extension DurationToHumanLangEXT on Duration {
  String toHumanLang() {
    var inMinutes = this.inMinutes.remainder(60).toString();
    var inHours = this.inHours.toString();

    if (this == Duration.zero) {
      return 'How long the todo will take?';
    }
    if (inMinutes != '0' && inHours != '0') {
      return '$inHours hours and $inMinutes minutes';
    }
    if (inHours != '0' && inMinutes == '0') {
      return '$inHours hours';
    }
    if (inMinutes != '0' && inHours == '0') {
      return '$inMinutes minutes';
    }

    return '';
  }
}

double calculateTasksTotalTime(List<Task>? tasks) {
  var filledAmount = 0.0;

  for (var i = 0; i < tasks!.length; i++) {
    filledAmount = filledAmount + tasks[i].totalTime;
  }

  return filledAmount;
}

/// Custom divider.
Widget get divider {
  return const Divider(
    height: 5,
    thickness: 1,
    indent: 50,
    endIndent: 50,
  );
}
