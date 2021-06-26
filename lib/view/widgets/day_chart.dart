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
  final viewUtils = ViewUtils();

  @override
  Widget build(BuildContext context) {
    var total =
        (ViewUtils.fullDay - viewUtils.calculateTotalDuration(widget.tasks));
    widget.tasks.add(Task().remainingTimeFiller(total));

    return SfCircularChart(
      tooltipBehavior: widget.tooltipBehaviorEnabled ? tooltipBehavior() : null,
      series: <PieSeries<Task, String>>[
        PieSeries<Task, String>(
          dataSource: widget.tasks,
          xValueMapper: (Task data, _) => data.totalTime.toString(),
          yValueMapper: (Task data, _) => data.totalTime,
        ),
      ],
    );
  }

  TooltipBehavior tooltipBehavior() {
    return TooltipBehavior(
      enable: true,
      builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
          int seriesIndex) {
        return Container(
          height: 20,
          width: data.title == 'Remaining Time {#@!@#!@#8&**%@#%}' ? 140 : 100,
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

  String generateTooltipText(Task data) {
    var time =
        Duration(hours: data.hours!, minutes: data.minutes!).toHumanLang();
    if (data.title == 'Remaining Time {#@!@#!@#8&**%@#%}') {
      return 'Remaining $time';
    }
    return time;
  }
}
