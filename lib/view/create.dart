import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vtime/core/model/task.dart';
import 'package:vtime/core/services/local_db_service.dart';
import 'package:vtime/view/widgets/utils.dart';

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
      appBar: const TransparentAppBar(),
      bottomNavigationBar: createButton(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 130),
              Wrap(children: [for (var i = 0; i < 4; i++) dayChecker(i)]),
              Wrap(children: [for (var i = 4; i < 7; i++) dayChecker(i)]),
              const SizedBox(height: 50),
              const Divider(),
              const SizedBox(height: 50),
              TextFormField(
                controller: titleTextController,
                maxLines: 2,
                decoration: ViewUtils().nonBorderInputDecoration(
                    hint: 'What are you going to do?'),
                validator: (v) {
                  if (v!.isEmpty) return 'Title can\'t be empty';
                },
              ),
              const SizedBox(width: 15),
              const Divider(),
              const SizedBox(width: 15),
              TextFormField(
                controller: desTextController,
                maxLines: 15,
                decoration: ViewUtils().nonBorderInputDecoration(
                  hint:
                      'You can write why you need to do this task here. So by doing that, you can easily remember it later',
                ),
              ),
            ],
          ),
        ),
      ),
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

    Task task = Task(
      uniquekey: '',
      title: titleTextController.text,
      description: desTextController.text,
      startTime: '12:00',
      endTime: '19:00',
    );

    for (var i in managableDaysIndexes!) {
      localDbService.rightBoxByCheckBoxId(i).add(task.copyWith(
            uniquekey: localDbService.rightTaskKeyCheckBoxId(i),
          ));
    }
  }
}
