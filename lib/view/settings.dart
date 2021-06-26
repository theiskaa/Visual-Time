import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtime/core/cubits/preference_cubit.dart';
class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool _themeSwitchValue = false;

  void detectTheme() {
    switch (BlocProvider.of<PreferenceCubit>(context).state.themeName) {
      case 'default':
        _themeSwitchValue = false;
        break;
      case 'dark':
        _themeSwitchValue = true;
        break;
    }
  }

  @override
  void initState() {
    detectTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            ListTile(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: .5,
                  color: BlocProvider.of<PreferenceCubit>(context)
                      .state
                      .theme!
                      .accentColor,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              title: const Text('Dark Theme'),
              trailing: CupertinoSwitch(
                activeColor: const Color(0xFFC72159),
                value: _themeSwitchValue,
                onChanged: (val) async {
                  setState(() => _themeSwitchValue = val);
                  if (val == false) {
                    BlocProvider.of<PreferenceCubit>(context)
                        .changeTheme('default');
                  } else {
                    BlocProvider.of<PreferenceCubit>(context)
                        .changeTheme('dark');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
