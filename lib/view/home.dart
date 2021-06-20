import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vtime/core/model/day.dart';
import 'package:vtime/core/model/task.dart';
import 'package:vtime/core/services/local_db_service.dart';
import 'package:vtime/view/create.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vtime/view/day_view.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            ValueListenableBuilder<Box<Task>>(
              valueListenable: todaysBox,
              builder: (context, box, _) {
                final tasks = box.values.toList().cast<Task>();
                return ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: tasks
                      .map(
                        (e) => Card(
                          child: ListTile(
                            title: Text(e.title!),
                            subtitle: Text(e.description!),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                box.delete(e.key);
                              },
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: weekDays
                  .map(
                    (e) => GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DayView(
                            day: e,
                            dayBox: localDbService.rightListenableValue(e),
                          ),
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(30),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        ),
                        child: Center(child: Text(e.name!)),
                      ),
                    ),
                  )
                  .toList(),
            )
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
