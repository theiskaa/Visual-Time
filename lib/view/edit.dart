import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:vtime/core/model/task.dart';
import 'package:vtime/core/services/local_db_service.dart';
import 'package:vtime/core/utils/widgets.dart';

import 'dashboard.dart';
import 'widgets/appbars.dart';
import 'widgets/buttons.dart';
import 'widgets/utils.dart';

class EditPage extends VTStatefulWidget {
  final Task task;
  final Box<Task> dayBox;

  EditPage({
    Key? key,
    required this.task,
    required this.dayBox,
  }) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends VTState<EditPage> {
  final localDbService = LocalDBService();
  final viewUtils = ViewUtils();

  final formKey = GlobalKey<FormState>();
  final titleTextController = TextEditingController();
  final desTextController = TextEditingController();

  Duration durationOfTask = Duration.zero;

  @override
  void initState() {
    durationOfTask = widget.task.duration;
    titleTextController.text = widget.task.title!;
    desTextController.text = widget.task.description!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      bottomNavigationBar: SaveButton(
        title: vt.intl.of(context)!.fmt('act.save'),
        onTap: saveTask,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 15),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleTextController,
                maxLines: 2,
                decoration: ViewUtils().nonBorderInputDecoration(
                  hint: vt.intl.of(context)!.fmt('task.title.hint'),
                ),
                validator: (v) {
                  if (v!.isEmpty) {
                    return vt.intl
                        .of(context)!
                        .fmt('error.title_field_validation');
                  }
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
                  hint: vt.intl.of(context)!.fmt('task.desc.hint'),
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
              durationOfTask.toHumanLang(vt, context),
              style: const TextStyle(fontSize: 15),
            )
          ],
        ),
      ),
      onLeadingTap: () {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
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

  saveTask() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (durationOfTask == Duration.zero) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(vt.intl.of(context)!.fmt('error.not_found_duration')),
        ),
      );
      return;
    }

    Task editedTask = widget.task.copyWith(
      title: titleTextController.text,
      description: desTextController.text,
      hours: durationOfTask.inHours,
      minutes: durationOfTask.minute,
    );

    await widget.dayBox.put(widget.task.key, editedTask);
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Dashboard()),
    );
  }
}
