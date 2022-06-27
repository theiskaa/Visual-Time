//
// This source code is distributed under the terms of Bad Code License.
// You are forbidden from distributing software containing this code to
// end users, because it is bad.
//

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vtime/core/model/task.dart';

import 'day_chart.dart';

class MiniDayChart extends StatelessWidget {
  final String title;
  final Function? onTap;
  final ValueListenable<Box<Task>> todaysBox;

  const MiniDayChart({
    Key? key,
    required this.title,
    required this.onTap,
    required this.todaysBox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap!(),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            GestureDetector(
              onTap: () => onTap!(),
              child: ValueListenableBuilder<Box<Task>>(
                valueListenable: todaysBox,
                builder: (context, box, _) {
                  final tasks = box.values.toList().cast<Task>();
                  return SizedBox(
                    height: 65,
                    width: 65,
                    child: DayChart(tasks: tasks),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
