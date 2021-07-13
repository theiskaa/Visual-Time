import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vtime/core/model/day.dart';
import 'package:vtime/core/model/task.dart';
import 'package:vtime/view/widgets/day_chart.dart';
import 'package:vtime/view/widgets/task_card.dart';

import 'widgets/appbars.dart';
import 'widgets/utils.dart';

class DayView extends StatefulWidget {
  final Day day;
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
  List<Task> tasks = [];

  /// Removes element from [oldIndex], and inserts removed element to [newIndex].
  /// After the local list reordering, it clears old database elements and fills it by new ones.
  void onReorder(int oldIndex, int newIndex, Box<Task> box) {
    if (oldIndex < newIndex) newIndex -= 1;

    var item = tasks.removeAt(oldIndex);
    tasks.insert(newIndex, item);

    setState(() {});

    for (var i = 0; i < tasks.length; i++) {
      box.delete(tasks[i].key);

      if (tasks[i].title != remainingTimeFillerTaskCode) {
        box.add(tasks[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(
        onLeadingTap: () => Navigator.pop(context),
        titleWidget: Text(widget.day.title ?? '404'),
      ),
      body: ValueListenableBuilder<Box<Task>>(
        valueListenable: widget.dayBox!,
        builder: (context, box, _) {
          tasks = box.values.toList().cast<Task>();

          return SingleChildScrollView(
            child: Column(
              children: [
                DayChart(tasks: tasks, tooltipBehaviorEnabled: true),
                const SizedBox(height: 15),
                const Divider(),
                const SizedBox(height: 15),
                ReorderableListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  onReorder: (oldI, newI) => onReorder(oldI, newI, box),
                  children: [
                    for (var i = 0; i < tasks.length; i++)
                      TaskCard(
                        task: tasks[i],
                        dayBox: box,
                        onDismissed: () => box.delete(tasks[i].key),
                        key: UniqueKey(),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
