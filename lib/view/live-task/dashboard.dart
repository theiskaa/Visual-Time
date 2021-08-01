import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vtime/core/cubits/preference_cubit.dart';
import 'package:vtime/core/model/task.dart';
import 'package:vtime/core/utils/widgets.dart';
import 'package:vtime/view/dashboard.dart';
import 'package:vtime/view/widgets/appbars.dart';
import 'package:vtime/view/widgets/live-task/clock_count.dart';
import 'package:vtime/view/widgets/themes.dart';
import 'package:vtime/view/widgets/utils.dart';

class LiveTaskDashboard extends VTStatefulWidget {
  final Task? task;
  final Box<Task>? dayBox;
  LiveTaskDashboard({Key? key, this.task, this.dayBox}) : super(key: key);

  @override
  LiveTaskDashboardState createState() => LiveTaskDashboardState();
}

class LiveTaskDashboardState extends VTState<LiveTaskDashboard> {
  final viewUtils = ViewUtils();

  static const oneSecond = Duration(seconds: 1);
  Timer? timer;
  Duration? duration;
  String time = '';
  Stopwatch watch = Stopwatch();

  bool removeTaskAfterCompletation = false;
  AudioCache player = AudioCache(prefix: 'assets/alarms/');

  @override
  void initState() {
    super.initState();
    duration = Duration(
      hours: widget.task!.hours!,
      minutes: widget.task!.minutes!,
    );
    time = duration!.toHMS;
  }

  @override
  void dispose() {
    if (timer != null) timer!.cancel();
    super.dispose();
  }

  void startTimer() {
    watch.start();
    timer = Timer.periodic(oneSecond, (_) {
      setState(() {
        duration = duration! - oneSecond;
        time = duration!.toHMS;
      });
      if (time == '00:00') onTaskEnd();
    });
  }

  void stopTimer() {
    watch.stop();
    timer!.cancel();
    setState(() {
      duration = Duration(
        hours: widget.task!.hours!,
        minutes: widget.task!.minutes!,
      );
      time = duration!.toHMS;
    });
  }

  void onTaskEnd() async {
    stopTimer();
    setState(() => time = 'dn');

    // Get's setted alarm sound and plays it
    var val = await BlocProvider.of<PreferenceCubit>(context).getAlarmSound();
    player.play('$val.mp3');

    if (removeTaskAfterCompletation) {
      await Future.delayed(const Duration(seconds: 2));
      widget.dayBox!.delete(widget.task!.key);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: startButton(),
      appBar: TransparentAppBar(onLeadingTap: navigateBack),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              ClockCount(time: time, disabled: !watch.isRunning),
              const SizedBox(height: 40),
              ViewUtils.divider,
              const SizedBox(height: 20),
              removeAfterSelectorWidget(),
              const SizedBox(height: 40),
              _SelectedTask(task: widget.task ?? Task()),
            ],
          ),
        ),
      ),
    );
  }

  Row removeAfterSelectorWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            vt.intl.of(context)!.fmt('live_work.removeTaskAfterCompleting'),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 10),
        CupertinoSwitch(
          activeColor: ViewUtils.pomodoroOrange,
          value: removeTaskAfterCompletation,
          onChanged: (val) {
            setState(() => removeTaskAfterCompletation = val);
          },
        ),
      ],
    );
  }

  Widget startButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: FractionallySizedBox(
        widthFactor: .8,
        child: ElevatedButton(
          style: ViewUtils().pomodoroButtonStyle,
          onPressed: watch.isRunning ? stopTimer : startTimer,
          child: Text(
            watch.isRunning
                ? vt.intl.of(context)!.fmt('act.stop')
                : vt.intl.of(context)!.fmt('act.start'),
            style: const TextStyle(color: ViewUtils.pomodoroOrange),
          ),
        ),
      ),
    );
  }

  void navigateBack() {
    if (watch.isRunning) {
      viewUtils.alert(
        context,
        vt,
        title: vt.intl.of(context)!.fmt('live_work.runtimeLogoutRequestError'),
        onAct: navigateToDashboard,
        buttons: [
          TextButton(
            style: simpleButtonStyle(ViewUtils.pomodoroOrange),
            onPressed: leaveItHalf,
            child: Text(
              vt.intl.of(context)!.fmt('live_work.leaveItHalf'),
              style: const TextStyle(color: ViewUtils.pomodoroOrange),
            ),
          ),
        ],
      );
      return;
    }

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    navigateToDashboard();
  }

  void navigateToDashboard() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Dashboard()),
      (route) => false,
    );
  }

  // Changes selected task's duration by current duration.
  // And saves modified task to database.
  void leaveItHalf() {
    Task currentTask = widget.task!.copyWith(
      hours: duration!.inHours,
      minutes: duration!.inMinutes,
    );
    if (duration!.inMinutes < 2) {
      widget.dayBox!.delete(widget.task!.key);
    } else {
      widget.dayBox!.put(widget.task!.key, currentTask);
    }
    navigateToDashboard();
  }
}

class _SelectedTask extends VTStatelessWidget {
  final Task task;
  _SelectedTask({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var padding = task.title!.length.toDouble() / 7;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              vt.intl.of(context)!.fmt('live_work.selected_task') + ':',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width - 20,
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              color: context
                  .read<PreferenceCubit>()
                  .state
                  .theme!
                  .scaffoldBackgroundColor,
              border: Border.all(width: .6, color: ViewUtils.pomodoroOrange),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 1,
                  offset: const Offset(0, 10),
                  blurRadius: 15,
                  color: ViewUtils.pomodoroOrange.withOpacity(.2),
                )
              ],
            ),
            child: ListTile(
              title: Text(task.title!),
              subtitle: Text(ViewUtils().generateSubtitle(context, task, vt)),
            ),
          )
        ],
      ),
    );
  }
}
