import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vtime/core/cubits/preference_cubit.dart';
import 'package:vtime/core/cubits/preference_state.dart';

import 'package:vtime/core/model/task.dart';
import 'package:vtime/core/utils/widgets.dart';
import 'package:vtime/view/widgets/utils.dart';

import 'components/themes.dart';

// ignore: must_be_immutable
class DayChart extends VTStatefulWidget {
  List<Task> tasks;
  final bool isTooltipBehaviorEnabled;

  DayChart({
    Key? key,
    required this.tasks,
    this.isTooltipBehaviorEnabled = false,
  }) : super(key: key);

  @override
  _DayChartState createState() => _DayChartState();
}

class _DayChartState extends VTState<DayChart> {
  final viewUtils = ViewUtils();

  dynamic currentPalette(String? themeName) {
    var palettes = {
      's/2': DayChartColorPalettes.s2Palette,
      'dark': DayChartColorPalettes().darkPalette,
      'default': DayChartColorPalettes().lightPalette
    };

    return palettes[themeName];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferenceCubit, PreferenceState>(
      builder: (context, state) {
        var total = (ViewUtils.fullDay -
            viewUtils.calculateTotalDuration(widget.tasks));
        widget.tasks.add(Task().remainingTimeFiller(total));

        return SfCircularChart(
          palette: currentPalette(state.themeName),
          tooltipBehavior:
              widget.isTooltipBehaviorEnabled ? tooltipBehavior() : null,
          series: <PieSeries<Task, String>>[
            PieSeries<Task, String>(
              dataSource: widget.tasks,
              xValueMapper: (Task data, _) => data.totalTime.toString(),
              yValueMapper: (Task data, _) => data.totalTime,
              animationDuration: state.isAnimationsEnabled! ? 1500 : 0,
            ),
          ],
        );
      },
    );
  }

  TooltipBehavior tooltipBehavior() {
    return TooltipBehavior(
      color: Colors.black,
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
              style: const TextStyle(color: Colors.white, fontSize: 8.5),
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
