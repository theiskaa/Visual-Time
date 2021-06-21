import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vtime/core/model/day.dart';
import 'package:vtime/core/model/task.dart';
import 'package:vtime/view/widgets/utils.dart';

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
      appBar: AppBar(title: Text(widget.day?.name ?? '')),
      body: ValueListenableBuilder<Box<Task>>(
        valueListenable: widget.dayBox!,
        builder: (context, box, _) {
          final tasks = box.values.toList().cast<Task>();
          return ListView(
            children: tasks
                .map(
                  (e) => Card(
                    child: ListTile(
                      title: Text(e.title!),
                      subtitle: Text(
                        e.description! +
                            ' ' +
                            Duration(hours: e.hours!, minutes: e.minutes!)
                                .toHumanLang(),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          box.delete(e.key);
                        },
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
