import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vtime/core/model/day.dart';
import 'package:vtime/core/model/task.dart';
import 'package:vtime/view/widgets/day_chart.dart';
import 'package:vtime/view/widgets/utils.dart';

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
                DayChart(
                  tasks: tasks,
                  tooltipBehaviorEnabled: true,
                ),
                Column(
                  children: tasks
                      .map(
                        (e) => Dismissible(
                          secondaryBackground: Container(color: Colors.red),
                          background: Container(color: Colors.red),
                          key: UniqueKey(),
                          onDismissed: (_) => box.delete(e.key),
                          child: ListTile(
                            title: Text(e.title!),
                            subtitle: Text(
                              e.description! +
                                  ' | ' +
                                  Duration(hours: e.hours!, minutes: e.minutes!)
                                      .toHumanLang(),
                            ),
                          ),
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
