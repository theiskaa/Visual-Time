import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtime/core/cubits/preference_cubit.dart';
import 'package:vtime/core/model/task.dart';
import 'package:vtime/core/utils/widgets.dart';
import 'package:vtime/view/dashboard.dart';
import 'package:vtime/view/widgets/appbars.dart';
import 'package:vtime/view/widgets/live-task/clock_count.dart';
import 'package:vtime/view/widgets/utils.dart';

const pomodoroOrange = Color(0xffFF6347);

class LiveTaskDashboard extends VTStatefulWidget {
  final Task? task;
  final Function? removeTask;
  LiveTaskDashboard({Key? key, this.task, this.removeTask}) : super(key: key);

  @override
  LiveTaskDashboardState createState() => LiveTaskDashboardState();
}

class LiveTaskDashboardState extends VTState<LiveTaskDashboard> {
  static const oneSecond = Duration(seconds: 1);

  Timer? timer;
  Duration? duration;
  String time = '';
  var watch = Stopwatch();
  final player = AudioCache(prefix: 'assets/alarms/');
  bool removeTaskAfterCompletation = false;

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
    timer!.cancel();
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
    player.play('0.mp3');
    await Future.delayed(const Duration(seconds: 2));
    if (removeTaskAfterCompletation) {
      await widget.removeTask!();
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
      appBar: TransparentAppBar(
        onLeadingTap: () {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
            (route) => false,
          );
        },
      ),
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
          activeColor: pomodoroOrange,
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
          style: ButtonStyle(
            overlayColor:
                MaterialStateProperty.all(pomodoroOrange.withOpacity(.1)),
            fixedSize: MaterialStateProperty.all(const Size(0, 40)),
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shape: MaterialStateProperty.all(
              const RoundedRectangleBorder(
                side: BorderSide(color: pomodoroOrange),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
            ),
          ),
          onPressed: watch.isRunning ? stopTimer : startTimer,
          child: Text(
            watch.isRunning
                ? vt.intl.of(context)!.fmt('act.stop')
                : vt.intl.of(context)!.fmt('act.start'),
            style: const TextStyle(color: pomodoroOrange),
          ),
        ),
      ),
    );
  }
}

class _SelectedTask extends VTStatelessWidget {
  final Task task;
  _SelectedTask({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: BlocProvider.of<PreferenceCubit>(context)
                  .state
                  .theme!
                  .scaffoldBackgroundColor,
              border: Border.all(width: .6, color: pomodoroOrange),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 1,
                  offset: const Offset(0, 10),
                  blurRadius: 15,
                  color: pomodoroOrange.withOpacity(.2),
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
