import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vtime/core/cubits/preference_cubit.dart';
import 'package:vtime/core/cubits/preference_state.dart';

import 'package:vtime/core/model/task.dart';
import 'package:vtime/core/utils/widgets.dart';
import 'package:vtime/view/widgets/utils.dart';

// ignore: must_be_immutable
class DayChart extends VTStatefulWidget {
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

class _DayChartState extends VTState<DayChart> {
  final viewUtils = ViewUtils();

  var darkPalette = <Color>[
    Colors.grey.shade900,
    Colors.red,
    Colors.purple.shade400,
    const Color.fromRGBO(246, 114, 128, 1),
    const Color.fromRGBO(248, 177, 149, 1),
    const Color.fromRGBO(116, 180, 155, 1),
    const Color.fromRGBO(0, 168, 181, 1),
    const Color.fromRGBO(73, 76, 162, 1),
    const Color.fromRGBO(255, 205, 96, 1),
    const Color.fromRGBO(255, 240, 219, 1),
    const Color.fromRGBO(238, 238, 238, 1)
  ];

  var lightPalette = <Color>[
    Colors.grey.shade300,
    Colors.red.shade400,
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
    return BlocBuilder<PreferenceCubit, PreferenceState>(
      builder: (context, state) {
        var total = (ViewUtils.fullDay -
            viewUtils.calculateTotalDuration(widget.tasks));
        widget.tasks.add(Task().remainingTimeFiller(total));

        return SfCircularChart(
          palette: (state.themeName == 'dark') ? darkPalette : lightPalette,
          tooltipBehavior:
              widget.tooltipBehaviorEnabled ? tooltipBehavior() : null,
          series: <PieSeries<Task, String>>[
            PieSeries<Task, String>(
              dataSource: widget.tasks,
              xValueMapper: (Task data, _) => data.totalTime.toString(),
              yValueMapper: (Task data, _) => data.totalTime,
            ),
          ],
        );
      },
    );
  }

  TooltipBehavior tooltipBehavior() {
    return TooltipBehavior(
      enable: true,
      builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
          int seriesIndex) {
        return Container(
          height: 20,
          width: (data.title == remainingTimeFillerTaskCode) ? 150 : 100,
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
    var time = Duration(hours: data.hours!, minutes: data.minutes!)
        .toHumanLang(vt, context);
    if (data.title == 'Remaining Time {#@!@#!@#8&**%@#%}') {
      return '${vt.intl.of(context)!.fmt('remaining')} - $time';
    }
    return time;
  }
}
