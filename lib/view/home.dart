import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vtime/core/model/day.dart';
import 'package:vtime/core/model/task.dart';
import 'package:vtime/core/services/local_db_service.dart';
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

  var todaysBox = LocalDBService.wednesdayBox().listenable();

  List<Day> weekDays = <Day>[
    const Day(name: 'Monday'),
    const Day(name: 'Tuesday'),
    const Day(name: 'Wednesday'),
    const Day(name: 'Thursday'),
    const Day(name: 'Friday'),
    const Day(name: 'Saturday'),
    const Day(name: 'Sunday'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(
        disableLeading: true,
        titleWidget: GestureDetector(
          onTap: () => openNewDay(2, context, weeks: weekDays),
          child: Text(
            weekDays[2].name ?? 'Today',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 25,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 15),
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
            WeekView(weeks: weekDays),
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

void openNewDay(int i, BuildContext context, {List? weeks}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DayView(
        day: weeks?[i],
        dayBox: LocalDBService().rightListenableValue(weeks?[i]),
      ),
    ),
  );
}
