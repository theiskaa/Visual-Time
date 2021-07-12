import 'package:flutter/material.dart';
import 'package:vtime/core/model/task.dart';
import 'package:vtime/core/vt.dart';

import 'themes.dart';

class ViewUtils {


  // A shortcut style method to show full functional alert dialog.
  alert(
    BuildContext context,
    VT vt, {
    required String title,
    required Function onAct,
  }) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(title),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(vt.intl.of(context)!.fmt('act.no')),
          ),
          TextButton(
            style: simpleButtonStyle(Colors.red),
            onPressed: () => onAct(),
            child: Text(
              vt.intl.of(context)!.fmt('act.yes'),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  String generateSubtitle(BuildContext context, Task task, VT vt) {
    var time = Duration(hours: task.hours!, minutes: task.minutes!)
        .toHumanLang(vt, context);
    if (task.description!.isNotEmpty) {
      return '${task.description!}  |  $time';
    }
    return time;
  }

  // Generates right name by index.
  String rightDayNameGenerator(int index, VT vt, context) {
    var values = {
      0: vt.intl.of(context)?.fmt('monday'),
      1: vt.intl.of(context)?.fmt('tuesday'),
      2: vt.intl.of(context)?.fmt('wednesday'),
      3: vt.intl.of(context)?.fmt('thursday'),
      4: vt.intl.of(context)?.fmt('friday'),
      5: vt.intl.of(context)?.fmt('saturday'),
      6: vt.intl.of(context)?.fmt('sunday'),
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

  static const divider = Divider(
    height: 5,
    thickness: 1,
    indent: 50,
    endIndent: 50,
  );
}

extension DurationToHumanLangEXT on Duration {
  String toHumanLang(VT vt, context) {
    var inMinutes = this.inMinutes.remainder(60).toString();
    var inHours = this.inHours.toString();

    String hour = vt.intl.of(context)!.fmt(this.inHours > 1 ? 'hours' : 'hour');
    String minute = vt.intl
        .of(context)!
        .fmt(int.parse(inMinutes) > 1 ? 'minutes' : 'minute');

    if (this == Duration.zero) {
      return vt.intl.of(context)!.fmt('task.duration.hint');
    }
    if (inMinutes != '0' && inHours != '0') {
      return '$inHours $hour ${vt.intl.of(context)!.fmt('and')} $inMinutes $minute';
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

  String get toHMS {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(inSeconds.remainder(60));
    if (inHours > 0) {
      return '${twoDigits(inHours)}:$twoDigitMinutes:$twoDigitSeconds';
    }
    return '$twoDigitMinutes:$twoDigitSeconds';
  }
}
