import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vtime/core/model/day.dart';
import 'package:vtime/core/services/local_db_service.dart';
import 'package:vtime/view/create.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vtime/view/day_view.dart';
import 'package:vtime/view/widgets/mini_day_card.dart';

import 'widgets/appbars.dart';
import 'widgets/utils.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final titleTextController = TextEditingController();
  final localDbService = LocalDBService();

  var todaysBox = LocalDBService.sundayBox().listenable();

  List<Day> weekDays = <Day>[
    const Day(name: 'monday'),
    const Day(name: 'tuesday'),
    const Day(name: 'wednesday'),
    const Day(name: 'thursday'),
    const Day(name: 'friday'),
    const Day(name: 'saturday'),
    const Day(name: 'sunday'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TransparentAppBar(disableLeading: true),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                  onTap: () => openNewDay(i, context),
                ),
            ],
          ),
          Wrap(
            children: [
              for (var i = 4; i < 7; i++)
                MiniDayChart(
                  title: ViewUtils().rightDayNameGenerator(i),
                  onTap: () => openNewDay(i, context),
                )
            ],
          ),
        ],
      ),
    );
  }

  void openNewDay(int i, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DayView(
          day: weeks![i],
          dayBox: LocalDBService().rightListenableValue(weeks![i]),
        ),
      ),
    );
  }
}
