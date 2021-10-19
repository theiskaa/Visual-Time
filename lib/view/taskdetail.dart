import 'package:flutter/material.dart';
import 'package:vtime/core/model/task.dart';
import 'package:vtime/view/widgets/task_card.dart';

class TaskDetailSS extends StatefulWidget {
  final Task task;
  const TaskDetailSS({Key? key, required this.task}) : super(key: key);

  @override
  _TaskDetailSSState createState() => _TaskDetailSSState();
}

class _TaskDetailSSState extends State<TaskDetailSS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.title!),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TaskDetailCard(
              widget: widget,
              text1: "Description",
              text2: widget.task.description!,
            ),
            SizedBox(
              height: 40,
            ),
            TaskDetailCard(
              widget: widget,
              text1: "Hours",
              text2: widget.task.hours.toString(),
            ),
            SizedBox(
              height: 40,
            ),
              TaskDetailCard(
              widget: widget,
              text1: "Minutes",
              text2: widget.task.minutes.toString(),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskDetailCard extends StatelessWidget {
  final String text1;
  final String text2;
  const TaskDetailCard({
    Key? key,
    required this.widget,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  final TaskDetailSS widget;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text1,
          style: TextStyle(fontSize: 20),
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text2,
          style: TextStyle(fontSize: 18),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Colors.white,
        ),
      ),
    );
  }
}
