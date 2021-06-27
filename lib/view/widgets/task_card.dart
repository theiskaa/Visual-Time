import 'package:flutter/material.dart';
import 'package:vtime/core/model/task.dart';
import 'package:vtime/core/utils/widgets.dart';
import 'package:vtime/view/widgets/utils.dart';

class TaskCard extends VTStatelessWidget {
  final Task task;
  final Function onDismissed;

  TaskCard({
    Key? key,
    required this.task,
    required this.onDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        padding: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red,
        ),
        child: const Align(
          child: Icon(Icons.delete, color: Colors.white),
          alignment: Alignment.centerRight,
        ),
      ),
      onDismissed: (_) => onDismissed(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          title: Text(task.title!),
          subtitle: Text(generateSubtitle(context)),
        ),
      ),
    );
  }

  String generateSubtitle(BuildContext context) {
    var time = Duration(hours: task.hours!, minutes: task.minutes!)
        .toHumanLang(vt, context);
    if (task.description!.isNotEmpty) {
      return '${task.description!}  |  $time';
    }
    return time;
  }
}
