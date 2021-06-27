import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:vtime/core/cubits/preference_cubit.dart';

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
  final viewUtils = ViewUtils();

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
      appBar: appBar(context),
      bottomNavigationBar: createButton(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 150),
              Wrap(children: [for (var i = 0; i < 4; i++) dayChecker(i)]),
              Wrap(children: [for (var i = 4; i < 7; i++) dayChecker(i)]),
              const SizedBox(height: 50),
              ViewUtils.divider,
              const SizedBox(height: 50),
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
            ],
          ),
        ),
      ),
    );
  }

  TransparentAppBar appBar(BuildContext context) {
    return TransparentAppBar(
      titleWidget: GestureDetector(
        onTap: () => showTimePicker(),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Icon(CupertinoIcons.clock_fill),
            const SizedBox(width: 10),
            Text(
              durationOfTask.toHumanLang(),
              style: const TextStyle(fontSize: 15),
            )
          ],
        ),
      ),
      onLeadingTap: () {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
          (route) => false,
        );
      },
    );
  }

  Future<void> showTimePicker() async {
    showModalBottomSheet(
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

  Widget createButton() {
    return Transform.translate(
      offset: Offset(0, -1 * MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: FractionallySizedBox(
          widthFactor: .8,
          child: ElevatedButton(
            onPressed: () => createTask(),
            child: Text(
              'Create',
              style: BlocProvider.of<PreferenceCubit>(context)
                  .state
                  .theme!
                  .textTheme
                  .button,
            ),
          ),
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

    if (durationOfTask == Duration.zero) {
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
      minutes: durationOfTask.minute,
    );

    for (var i in managableDaysIndexes!) {
      List<Task> tasksList =
          localDbService.rightBoxByCheckBoxId(i).values.toList();
      Duration remainingTime =
          ViewUtils.fullDay - viewUtils.calculateTotalDuration(tasksList);

      if (task.duration > remainingTime) {
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
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      }
    }
  }
}
