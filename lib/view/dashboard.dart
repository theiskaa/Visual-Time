import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtime/core/cubits/preference_cubit.dart';
import 'package:vtime/core/model/day.dart';
import 'package:vtime/core/model/task.dart';
import 'package:vtime/core/services/local_db_service.dart';
import 'package:vtime/core/utils/utils.dart';
import 'package:vtime/core/utils/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'day_view.dart';
import 'create.dart';
import 'settings.dart';
import 'widgets/mini_day_card.dart';
import 'widgets/components/appbars.dart';
import 'widgets/day_chart.dart';
import 'widgets/utils.dart';

class Dashboard extends VTStatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends VTState<Dashboard> {
  final titleTextController = TextEditingController();
  final localDbService = LocalDBService();

  late Day today = weekDays(vt, context)[0];
  ValueListenable<Box<Task>>? todaysBox;

  // Just contains cases appertitate to week days.
  // And listens now(WeekDay) and generates right function calling.
  void _refreshContent() {
    var cases = {
      DateTime.monday: () {
        today = weekDays(vt, context)[0];
        todaysBox = localDbService.rightListenableValue(
          weekDays(vt, context)[0],
        );
      },
      DateTime.tuesday: () {
        today = weekDays(vt, context)[1];
        todaysBox = localDbService.rightListenableValue(
          weekDays(vt, context)[1],
        );
      },
      DateTime.wednesday: () {
        today = weekDays(vt, context)[2];
        todaysBox = localDbService.rightListenableValue(
          weekDays(vt, context)[2],
        );
      },
      DateTime.thursday: () {
        today = weekDays(vt, context)[3];
        todaysBox = localDbService.rightListenableValue(
          weekDays(vt, context)[3],
        );
      },
      DateTime.friday: () {
        today = weekDays(vt, context)[4];
        todaysBox = localDbService.rightListenableValue(
          weekDays(vt, context)[4],
        );
      },
      DateTime.saturday: () {
        today = weekDays(vt, context)[5];
        todaysBox = localDbService.rightListenableValue(
          weekDays(vt, context)[5],
        );
      },
      DateTime.sunday: () {
        today = weekDays(vt, context)[6];
        todaysBox = localDbService.rightListenableValue(
          weekDays(vt, context)[6],
        );
      },
    };

    return cases[DateTime.now().weekday]!.call();
  }

  @override
  Widget build(BuildContext context) {
    _refreshContent();
    return Scaffold(
      appBar: TransparentAppBar(
        disableLeading: true,
        action: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: SettingsPopUpMenu(todaysBox: todaysBox!),
        ),
        titleWidget: GestureDetector(
          onTap: () => openNewDay(0, context, day: today, todaysBox: todaysBox),
          child: Text(
            vt.intl.of(context)!.fmt('today'),
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder<Box<Task>>(
              valueListenable: todaysBox!,
              builder: (context, box, _) {
                final tasks = box.values.toList().cast<Task>();
                return DayChart(
                  tasks: tasks,
                  isTooltipBehaviorEnabled: true,
                );
              },
            ),
            const SizedBox(height: 30),
            ViewUtils.divider,
            const SizedBox(height: 50),
            WeekView(weeks: weekDays(vt, context)),
          ],
        ),
      ),
    );
  }
}

// Method which navigates to DayView with given parameters.
void openNewDay(
  int i,
  BuildContext context, {
  List? weeks,
  Day? day,
  dynamic todaysBox,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DayView(
        day: weeks?[i] ?? day,
        dayBox: (weeks != null)
            ? LocalDBService().rightListenableValue(weeks[i])
            : todaysBox,
      ),
    ),
  );
}

// A widget which has mini day charts of all week.
class WeekView extends VTStatelessWidget {
  final List<Day>? weeks;
  WeekView({Key? key, this.weeks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isAnimationsEnabled =
        context.read<PreferenceCubit>().state.isAnimationsEnabled!;
    return Center(
      child: Column(
        children: [
          Wrap(
            children: [
              for (var i = 0; i < 4; i++)
                MiniDayChart(
                  isAnimationsEnabled: isAnimationsEnabled,
                  title: ViewUtils().rightDayNameGenerator(i, vt, context),
                  onTap: () => openNewDay(i, context, weeks: weeks),
                  todaysBox: LocalDBService().rightListenableValue(weeks![i]),
                ),
            ],
          ),
          Wrap(
            children: [
              for (var i = 4; i < 7; i++)
                MiniDayChart(
                  isAnimationsEnabled: isAnimationsEnabled,
                  todaysBox: LocalDBService().rightListenableValue(weeks![i]),
                  title: ViewUtils().rightDayNameGenerator(i, vt, context),
                  onTap: () => openNewDay(i, context, weeks: weeks),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsPopUpMenu extends VTStatelessWidget {
  final ValueListenable<Box<Task>> todaysBox;
  SettingsPopUpMenu({Key? key, required this.todaysBox}) : super(key: key);

  final localDbService = LocalDBService();
  final viewUtils = ViewUtils();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: const Icon(Icons.more_horiz),
      onSelected: (val) => onPopUpItemSelected(context, val),
      itemBuilder: (_) => [
        PopupMenuItem(
          value: 0,
          child: Column(
            children: [
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.settings),
                  const SizedBox(width: 10),
                  Text(vt.intl.of(context)!.fmt('prefs.settings')),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(),
            ],
          ),
        ),
        PopupMenuItem(
          value: 1,
          child: Row(
            children: [
              const Icon(CupertinoIcons.clear_circled_solid, color: Colors.red),
              const SizedBox(width: 10),
              Text(vt.intl.of(context)!.fmt('act.clearWeek')),
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              const Icon(CupertinoIcons.add_circled_solid),
              const SizedBox(width: 10),
              Text(vt.intl.of(context)!.fmt('act.addTask')),
            ],
          ),
        ),
      ],
    );
  }

  void onPopUpItemSelected(BuildContext context, dynamic seleted) {
    var methods = {
      0: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Settings()),
          ),
      1: () => viewUtils.alert(
            context,
            vt,
            title: vt.intl.of(context)!.fmt('clear.week.title'),
            onAct: () {
              localDbService.clearWeek();
              Navigator.pop(context);
            },
          ),
      2: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateTaskPage(todaysBox: todaysBox),
            ),
          ),
    };

    methods[seleted]!.call();
  }
}
