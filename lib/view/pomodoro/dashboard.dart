import 'package:flutter/material.dart';
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
        titleWidget: Text(vt.intl.of(context)!.fmt('prefs.live_work')),
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
              overlayColor: MaterialStateProperty.all(
                const Color(0xffFF6347).withOpacity(.1),
              ),
              fixedSize: MaterialStateProperty.all(const Size(0, 40)),
              elevation: MaterialStateProperty.all(0),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xffFF6347)),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
            ),
            onPressed: startTimer,
            child: Text(
              timerIsActive
                  ? vt.intl.of(context)!.fmt('act.stop')
                  : vt.intl.of(context)!.fmt('act.start'),
              style: const TextStyle(color: Color(0xffFF6347)),
            ),
          ),
        ),
      ),
    );
  }
}
