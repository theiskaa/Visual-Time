import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:vtime/core/model/day.dart';
import 'package:vtime/core/model/task.dart';
import 'package:vtime/core/services/local_db_service.dart';
import 'package:vtime/core/utils/widgets.dart';

import 'create.dart';
import 'widgets/day_chart.dart';
import 'widgets/task_card.dart';
import 'widgets/components/appbars.dart';
import 'widgets/utils.dart';

class DayView extends VTStatefulWidget {
  final Day day;
  final ValueListenable<Box<Task>>? dayBox;

  DayView({
    Key? key,
    required this.day,
    required this.dayBox,
  }) : super(key: key);

  @override
  _DayViewState createState() => _DayViewState();
}

class _DayViewState extends VTState<DayView> {
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

      if (tasks[i].title != remainingTimeFillerTaskCode) box.add(tasks[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(
        onLeadingTap: () => Navigator.pop(context),
        titleWidget: Text(widget.day.title ?? '404'),
        action: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: SettingsPopUpMenu(todaysBox: widget.dayBox!, day: widget.day),
        ),
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

class SettingsPopUpMenu extends VTStatelessWidget {
  final Day? day;
  final ValueListenable<Box<Task>> todaysBox;

  SettingsPopUpMenu({
    Key? key,
    required this.todaysBox,
    this.day,
  }) : super(key: key);

  final localDbService = LocalDBService();
  final viewUtils = ViewUtils();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: const Icon(Icons.more_horiz),
      onSelected: (val) => onPopUpItemSelected(context, val),
      itemBuilder: (_) => [
        PopupMenuItem(
          value: 0,
          child: Row(
            children: [
              const Icon(CupertinoIcons.clear_circled_solid, color: Colors.red),
              const SizedBox(width: 10),
              Text(vt.intl.of(context)!.fmt('act.clearDay')),
            ],
          ),
        ),
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              const Icon(CupertinoIcons.add_circled_solid),
              const SizedBox(width: 10),
              Text(vt.intl.of(context)!.fmt('act.addTask')),
            ],
          ),
        ),
      ],
    );
  }

  void onPopUpItemSelected(BuildContext context, dynamic seleted) {
    var methods = {
      0: () => viewUtils.alert(
            context,
            vt,
            title: vt.intl.of(context)!.fmt('clear.day.title'),
            onAct: () {
              localDbService.clearDay(day!.dayIndex!);
              Navigator.pop(context);
            },
          ),
      1: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateTaskPage(
                todaysBox: todaysBox,
                selectedDay: day,
              ),
            ),
          ),
    };

    methods[seleted]!.call();
  }
}
