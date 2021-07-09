import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:vtime/core/model/task.dart';
import 'package:vtime/core/utils/widgets.dart';
import 'package:vtime/view/live-task/dashboard.dart';
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
    return Slidable(
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
          caption: vt.intl.of(context)!.fmt('prefs.live_work'),
          color: const Color(0xffFF6347),
          icon: CupertinoIcons.time_solid,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LiveTaskDashboard(task: task),
              ),
            );
          },
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => onDismissed(),
        ),
      ],
    );
  }
}
