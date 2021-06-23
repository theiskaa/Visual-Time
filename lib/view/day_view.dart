import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vtime/core/model/day.dart';
import 'package:vtime/core/model/task.dart';
import 'package:vtime/view/widgets/day_chart.dart';
import 'package:vtime/view/widgets/task_card.dart';

import 'widgets/appbars.dart';

class DayView extends StatefulWidget {
  final Day? day;
  final ValueListenable<Box<Task>>? dayBox;

  const DayView({
    Key? key,
    required this.day,
    required this.dayBox,
  }) : super(key: key);

  @override
  _DayViewState createState() => _DayViewState();
}

class _DayViewState extends State<DayView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(
        onLeadingTap: () => Navigator.pop(context),
        titleWidget: Text(
          widget.day?.name ?? '',
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: ValueListenableBuilder<Box<Task>>(
        valueListenable: widget.dayBox!,
        builder: (context, box, _) {
          final tasks = box.values.toList().cast<Task>();

          return SingleChildScrollView(
            child: Column(
              children: [
                DayChart(tasks: tasks, tooltipBehaviorEnabled: true),
                Column(
                  children: tasks
                      .map(
                        (task) => TaskCard(
                          task: task,
                          onDismissed: () => box.delete(task.key),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
