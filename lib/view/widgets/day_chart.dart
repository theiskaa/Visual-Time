import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vtime/core/model/task.dart';
import 'package:vtime/view/widgets/utils.dart';

// ignore: must_be_immutable
class DayChart extends StatefulWidget {
  List<Task> tasks;
  final bool tooltipBehaviorEnabled;

  DayChart({
    Key? key,
    required this.tasks,
    this.tooltipBehaviorEnabled = false,
  }) : super(key: key);

  @override
  _DayChartState createState() => _DayChartState();
}

class _DayChartState extends State<DayChart> {
  @override
  Widget build(BuildContext context) {
    int? remainingHours = 24;
    int? remainingMinutes = 24;

    for (var i = 0; i < widget.tasks.length; i++) {
      int currentHours = 24;
      int currentMinutes = 60;

      currentHours = (currentHours - widget.tasks[i].hours!);
      currentMinutes = (currentMinutes - widget.tasks[i].minutes!);

      remainingHours = currentHours;
      remainingMinutes = currentMinutes;
    }

    widget.tasks.add(
      Task(
        title: 'Remaining Time {#@!@#!@#8&**%@#%}',
        description: '',
        uniquekey: '',
        hours: remainingHours,
        minutes: remainingMinutes,
      ),
    );

    return SfCircularChart(
      tooltipBehavior: widget.tooltipBehaviorEnabled
          ? tooltipBehavior(remainingHours)
          : null,
      series: <PieSeries<Task, String>>[
        PieSeries<Task, String>(
          dataSource: widget.tasks,
          xValueMapper: (Task data, _) => getTotal(data).toString(),
          yValueMapper: (Task data, _) => getTotal(data),
        ),
      ],
    );
  }

  TooltipBehavior tooltipBehavior(int? remainingHours) {
    return TooltipBehavior(
      enable: true,
      builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
          int seriesIndex) {
        return Container(
          height: 20,
          width: data.hours == remainingHours ? 135 : 100,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              generateTooltipText(data),
              style: const TextStyle(color: Colors.white, fontSize: 8),
            ),
          ),
        );
      },
    );
  }

  double getTotal(Task task) {
    double rightMinute = double.parse('0.${task.minutes}');
    double total = task.hours! + rightMinute;
    return total;
  }

  String generateTooltipText(Task data) {
    var time =
        Duration(hours: data.hours!, minutes: data.minutes!).toHumanLang();
    if (data.title == 'Remaining Time {#@!@#!@#8&**%@#%}') {
      return 'Remaining $time';
    }
    return time;
  }
}
