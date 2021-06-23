import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vtime/core/model/task.dart';
import 'package:vtime/core/services/local_db_service.dart';
import 'package:vtime/view/widgets/utils.dart';

import 'home.dart';
import 'widgets/appbars.dart';

class CreateTaskPage extends StatefulWidget {
  final ValueListenable<Box<Task>> todaysBox;
  const CreateTaskPage({Key? key, required this.todaysBox}) : super(key: key);

  @override
  CreateTaskPageState createState() => CreateTaskPageState();
}

class CreateTaskPageState extends State<CreateTaskPage> {
  final localDbService = LocalDBService();
  final formKey = GlobalKey<FormState>();
  final titleTextController = TextEditingController();
  final desTextController = TextEditingController();

  Duration durationOfTask = Duration.zero;

  bool? monday = false,
      tuesday = false,
      wednesday = false,
      thursday = false,
      friday = false,
      saturday = false,
      sunday = false;

  List<int>? managableDaysIndexes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: TransparentAppBar(
        onLeadingTap: () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
          (route) => false,
        ),
      ),
      bottomNavigationBar: createButton(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 130),
              TextFormField(
                controller: titleTextController,
                maxLines: 2,
                decoration: ViewUtils().nonBorderInputDecoration(
                  hint: 'What are you going to do?',
                ),
                validator: (v) {
                  if (v!.isEmpty) return 'Title can\'t be empty';
                },
              ),
              const SizedBox(width: 15),
              const Divider(),
              const SizedBox(width: 15),
              TextFormField(
                controller: desTextController,
                minLines: 1,
                maxLines: 15,
                decoration: ViewUtils().nonBorderInputDecoration(
                  hint: 'Describe your task...',
                ),
              ),
              const SizedBox(height: 25),
              const Divider(),
              const SizedBox(height: 25),
              GestureDetector(
                onTap: () => showTimePicker(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(CupertinoIcons.clock_fill),
                    const SizedBox(width: 10),
                    Text(durationOfTask.toHumanLang())
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Divider(),
              const SizedBox(height: 25),
              Wrap(children: [for (var i = 0; i < 4; i++) dayChecker(i)]),
              Wrap(children: [for (var i = 4; i < 7; i++) dayChecker(i)]),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showTimePicker() async {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      backgroundColor: Colors.white,
      context: context,
      builder: (builder) {
        return SizedBox(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: SizedBox.expand(
            child: CupertinoTimerPicker(
              mode: CupertinoTimerPickerMode.hm,
              minuteInterval: 1,
              secondInterval: 1,
              initialTimerDuration: durationOfTask,
              onTimerDurationChanged: (newTime) {
                setState(() => durationOfTask = newTime);
              },
            ),
          ),
        );
      },
    );
  }

  Padding createButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: FractionallySizedBox(
        widthFactor: .8,
        child: ElevatedButton(
          onPressed: () => createTask(),
          child: const Text('Create'),
        ),
      ),
    );
  }

  Widget dayChecker(int i) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            ViewUtils().rightDayNameGenerator(i),
            style: const TextStyle(fontSize: 11),
          ),
          Checkbox(
            key: Key('subCheckBox.$i'),
            value: rightDayValueGenerator(i),
            onChanged: (v) {
              setState(() => valueControllerMethod(v, i));
              addIndexToList(val: i);
            },
          ),
        ],
      ),
    );
  }

  // Returns right value by gave checkbox index.
  bool rightDayValueGenerator(int index) {
    var values = {
      0: monday,
      1: tuesday,
      2: wednesday,
      3: thursday,
      4: friday,
      5: saturday,
      6: sunday,
    };
    return values[index]!;
  }

  // Returns right checkbox value changing by gave checkbox index.
  void valueControllerMethod(bool? v, int i) {
    var rightMethodSelector = {
      0: () => monday = v,
      1: () => tuesday = v,
      2: () => wednesday = v,
      3: () => thursday = v,
      4: () => friday = v,
      5: () => saturday = v,
      6: () => sunday = v,
    };

    rightMethodSelector[i]!.call();
  }

  void addIndexToList({dynamic val}) {
    if (managableDaysIndexes!.contains(val)) {
      managableDaysIndexes!.remove(val);
      return;
    }

    managableDaysIndexes!.add(val);
  }

  // Creates tasks for appertitate to selected days.
  void createTask() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (durationOfTask == Duration.zero || durationOfTask.inHours == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Please add duration for your task'),
        ),
      );
      return;
    }

    Task task = Task(
      uniquekey: '',
      title: titleTextController.text,
      description: desTextController.text,
      hours: durationOfTask.inHours,
      minutes: 0, // durationOfTask.inMinutes.remainder(60),
    );

    for (var i in managableDaysIndexes!) {
      List<Task> tasksList =
          localDbService.rightBoxByCheckBoxId(i).values.toList();
      double remainingTime = 24 - calculateTasksTotalTime(tasksList);

      if (task.totalTime > remainingTime) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              'You selected duration which exceeds the remaining time of your selected day',
            ),
          ),
        );
      } else {
        localDbService.rightBoxByCheckBoxId(i).add(task.copyWith(
              uniquekey: localDbService.rightTaskKeyCheckBoxId(i),
            ));

        Navigator.pop(context);
      }
    }
  }
}
