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
  List<Color> colorPalette = <Color>[
    Colors.grey.shade900,
    const Color.fromRGBO(192, 108, 132, 1),
    const Color.fromRGBO(246, 114, 128, 1),
    const Color.fromRGBO(248, 177, 149, 1),
    const Color.fromRGBO(116, 180, 155, 1),
    const Color.fromRGBO(0, 168, 181, 1),
    const Color.fromRGBO(73, 76, 162, 1),
    const Color.fromRGBO(255, 205, 96, 1),
    const Color.fromRGBO(255, 240, 219, 1),
    const Color.fromRGBO(238, 238, 238, 1)
  ];

  @override
  Widget build(BuildContext context) {
    int? remainingHours = 23;
    int? remainingMinutes = 59;

    for (var i = 0; i < widget.tasks.length; i++) {
      int currentHours = 23;
      int currentMinutes = 59;

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
      palette: colorPalette,
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
