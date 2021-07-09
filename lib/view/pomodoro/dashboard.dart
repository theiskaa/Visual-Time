import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtime/core/cubits/preference_cubit.dart';
import 'package:vtime/core/model/task.dart';
import 'package:vtime/core/utils/widgets.dart';
import 'package:vtime/view/dashboard.dart';
import 'package:vtime/view/widgets/appbars.dart';
import 'package:vtime/view/widgets/pomodoro/clock_count.dart';
import 'package:vtime/view/widgets/utils.dart';

const pomodoroOrange = Color(0xffFF6347);

class PomodoroDashboard extends VTStatefulWidget {
  final Task? task;
  PomodoroDashboard({Key? key, this.task}) : super(key: key);

  @override
  PomodoroDashboardState createState() => PomodoroDashboardState();
}

class PomodoroDashboardState extends VTState<PomodoroDashboard> {
  bool timerIsActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: startButton(),
      appBar: TransparentAppBar(
        titleWidget: Text(
          (widget.task != null)
              ? widget.task!.title!
              : vt.intl.of(context)!.fmt('prefs.live_work'),
        ),
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
              ClockCount(
                disabled: !timerIsActive,
                time: '${widget.task!.totalTime}',
              ),
              const SizedBox(height: 40),
              ViewUtils.divider,
              const SizedBox(height: 40),
              _SelectedTask(task: widget.task ?? Task()),
            ],
          ),
        ),
      ),
    );
  }

  void startTimer() {
    setState(() => timerIsActive = !timerIsActive);
  }

  Widget startButton() {
    return Transform.translate(
      offset: Offset(0, -1 * MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
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
            onPressed: startTimer,
            child: Text(
              timerIsActive
                  ? vt.intl.of(context)!.fmt('act.stop')
                  : vt.intl.of(context)!.fmt('act.start'),
              style: const TextStyle(color: pomodoroOrange),
            ),
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
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Selected Task:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width - 20,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              border: Border.all(width: .3),
              borderRadius: BorderRadius.circular(20),
              color: BlocProvider.of<PreferenceCubit>(context)
                  .state
                  .theme!
                  .scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: pomodoroOrange.withOpacity(.2),
                  blurRadius: 10,
                  offset: const Offset(0, 10),
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
