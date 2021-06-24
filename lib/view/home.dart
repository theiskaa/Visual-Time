import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vtime/core/model/day.dart';
import 'package:vtime/core/model/task.dart';
import 'package:vtime/core/services/local_db_service.dart';
import 'package:vtime/core/utils/utils.dart';
import 'package:vtime/view/create.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vtime/view/day_view.dart';
import 'package:vtime/view/widgets/mini_day_card.dart';

import 'widgets/appbars.dart';
import 'widgets/day_chart.dart';
import 'widgets/utils.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final titleTextController = TextEditingController();
  final localDbService = LocalDBService();

  late Day today = weekDays[0];
  late ValueListenable<Box<Task>> todaysBox;

  @override
  void initState() {
    super.initState();
    _refreshContent();
  }

  // Just contains cases appertitate to week days.
  // And listens now(WeekDay) and makes right fun. calling.
  void _refreshContent() {
    var cases = {
      DateTime.monday: () {
        today = weekDays[0];
        todaysBox = localDbService.rightListenableValue(weekDays[0]);
      },
      DateTime.tuesday: () {
        today = weekDays[1];
        todaysBox = localDbService.rightListenableValue(weekDays[1]);
      },
      DateTime.wednesday: () {
        today = weekDays[2];
        todaysBox = localDbService.rightListenableValue(weekDays[2]);
      },
      DateTime.thursday: () {
        today = weekDays[3];
        todaysBox = localDbService.rightListenableValue(weekDays[3]);
      },
      DateTime.friday: () {
        today = weekDays[4];
        todaysBox = localDbService.rightListenableValue(weekDays[4]);
      },
      DateTime.saturday: () {
        today = weekDays[5];
        todaysBox = localDbService.rightListenableValue(weekDays[5]);
      },
      DateTime.sunday: () {
        today = weekDays[6];
        todaysBox = localDbService.rightListenableValue(weekDays[6]);
      },
    };

    return cases[DateTime.now().weekday]!.call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(
        disableLeading: true,
        titleWidget: GestureDetector(
          onTap: () => openNewDay(0, context, day: today, todaysBox: todaysBox),
          child: Text(
            today.name ?? 'Today',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 25,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder<Box<Task>>(
              valueListenable: todaysBox,
              builder: (context, box, _) {
                final tasks = box.values.toList().cast<Task>();
                return DayChart(tasks: tasks, tooltipBehaviorEnabled: true);
              },
            ),
            const SizedBox(height: 50),
            ViewUtils().divider,
            const SizedBox(height: 50),
            const WeekView(weeks: weekDays),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateTaskPage(todaysBox: todaysBox),
          ),
        ),
      ),
    );
  }
}

class WeekView extends StatelessWidget {
  final List<Day>? weeks;
  const WeekView({Key? key, this.weeks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Wrap(
            children: [
              for (var i = 0; i < 4; i++)
                MiniDayChart(
                  title: ViewUtils().rightDayNameGenerator(i),
                  onTap: () => openNewDay(i, context, weeks: weeks),
                  todaysBox: LocalDBService().rightListenableValue(weeks![i]),
                ),
            ],
          ),
          Wrap(
            children: [
              for (var i = 4; i < 7; i++)
                MiniDayChart(
                  todaysBox: LocalDBService().rightListenableValue(weeks![i]),
                  title: ViewUtils().rightDayNameGenerator(i),
                  onTap: () => openNewDay(i, context, weeks: weeks),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

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
