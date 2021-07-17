import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:vtime/core/model/task.dart';
import 'package:vtime/core/utils/widgets.dart';
import 'package:vtime/view/edit.dart';
import 'package:vtime/view/live-task/dashboard.dart';

import 'utils.dart';

class TaskCard extends VTStatelessWidget {
  final Task task;
  final Function onDismissed;
  final Box<Task> dayBox;

  TaskCard({
    Key? key,
    required this.task,
    required this.onDismissed,
    required this.dayBox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: key,
      actionPane: const SlidableDrawerActionPane(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
          title: Text(task.title!),
          subtitle: Text(ViewUtils().generateSubtitle(context, task, vt)),
        ),
      ),
      actions: [
        IconSlideAction(
          caption: vt.intl.of(context)!.fmt('act.start'),
          color: const Color(0xffFF6347),
          icon: CupertinoIcons.time_solid,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  LiveTaskDashboard(task: task, dayBox: dayBox),
            ),
          ),
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: vt.intl.of(context)!.fmt('act.edit'),
          color: const Color(0xff00ff00),
          icon: Icons.edit,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditPage(task: task, dayBox: dayBox),
            ),
          ),
        ),
        IconSlideAction(
          caption: vt.intl.of(context)!.fmt('act.delete'),
          color: const Color(0xffff0000),
          icon: Icons.delete,
          onTap: () => onDismissed(),
        ),
      ],
    );
  }
}
