import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtime/core/cubits/preference_cubit.dart';
import 'package:vtime/core/utils/widgets.dart';
import 'package:vtime/view/dashboard.dart';
import 'package:vtime/view/widgets/appbars.dart';
import 'package:vtime/view/widgets/pomodoro/clock_count.dart';

class PomodoroDashboard extends VTStatefulWidget {
  PomodoroDashboard({Key? key}) : super(key: key);

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
        titleWidget: const Text('Pomodoro'),
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
            children: [
              const SizedBox(height: 30),
              ClockCount(disabled: !timerIsActive),
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
              backgroundColor: MaterialStateProperty.all(
                const Color(0xffFF6347),
              ),
            ),
            onPressed: startTimer,
            child: Text(
              timerIsActive
                  ? vt.intl.of(context)!.fmt('act.stop')
                  : vt.intl.of(context)!.fmt('act.start'),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
