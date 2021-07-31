import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vtime/core/cubits/preference_cubit.dart';
import 'package:vtime/core/utils/widgets.dart';

import 'widgets/appbars.dart';
import 'widgets/utils.dart';

class Settings extends VTStatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends VTState<Settings> {
  int themeSegmentedValue = 0;
  int langSegmentedValue = 0;
  String selected = 'Nonimooley';

  final langSegments = const <int, Widget>{
    0: Text('English'),
    1: Text('Türkçe'),
    2: Text('Русский'),
    3: Text('ქართული')
  };

  final alarmSounds = [
    'Nonimooley',
    'Other 1',
    'Other 2',
    'Other 3',
    'Other 4'
  ];

  dynamic detectTheme() {
    switch (BlocProvider.of<PreferenceCubit>(context).state.themeName) {
      case 'default':
        return themeSegmentedValue = 0;
      case 'dark':
        return themeSegmentedValue = 1;
    }
    return 0;
  }

  dynamic detectLang() {
    switch (BlocProvider.of<PreferenceCubit>(context).state.langCode) {
      case 'en':
        return langSegmentedValue = 0;
      case 'tr':
        return langSegmentedValue = 1;
      case 'ru':
        return langSegmentedValue = 2;
      case 'ka':
        return langSegmentedValue = 3;
    }
    return 0;
  }

  void detectAlarmSound() async {
    var val = await BlocProvider.of<PreferenceCubit>(context).getAlarmSound();

    selected = val!;
  }

  @override
  void initState() {
    detectTheme();
    detectLang();
    detectAlarmSound();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var themeSegments = <int, Widget>{
      0: Text(vt.intl.of(context)!.fmt('prefs.appearance.light')),
      1: Text(vt.intl.of(context)!.fmt('prefs.appearance.dark'))
    };
    return Scaffold(
      appBar: TransparentAppBar(
        titleWidget: Text(vt.intl.of(context)!.fmt('prefs.settings')),
        onLeadingTap: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              ThemeSelectorWidget(
                themeSegmentedValue: themeSegmentedValue,
                themeSegments: themeSegments,
                updateState: (i) => setState(() => themeSegmentedValue = i),
              ),
              const SizedBox(height: 50),
              LangSelectorWidget(
                langSegmentedValue: langSegmentedValue,
                langSegments: langSegments,
                updateState: (i) => setState(() => langSegmentedValue = i),
              ),
              const SizedBox(height: 50),
              AlarmSongSelectorWidget(
                updateState: (val) => setState(() => selected = val),
                selected: selected,
                alarmSounds: alarmSounds,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AlarmSongSelectorWidget extends VTStatelessWidget {
  final Function(dynamic) updateState;
  final String selected;
  final List<String> alarmSounds;

  AlarmSongSelectorWidget({
    Key? key,
    required this.updateState,
    required this.selected,
    required this.alarmSounds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            vt.intl.of(context)!.fmt('prefs.alarmSound'),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 15),
        FractionallySizedBox(
          widthFactor: .95,
          child: ElevatedButton(
            style: ViewUtils().pomodoroButtonStyle,
            onPressed: () => showPicker(context),
            child: Text(
              selected,
              style: const TextStyle(color: ViewUtils.pomodoroOrange),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> showPicker(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return SizedBox(
          height: MediaQuery.of(context).copyWith().size.height / 3,
          child: SizedBox.expand(
            child: CupertinoPicker.builder(
              itemExtent: 40,
              childCount: alarmSounds.length,
              onSelectedItemChanged: (index) {
                BlocProvider.of<PreferenceCubit>(context).changeAlarmSound(
                  alarmSounds[index],
                );
                updateState.call(alarmSounds[index]);
              },
              itemBuilder: (_, i) => Center(
                child: Text(
                  alarmSounds[i],
                  style: context
                      .read<PreferenceCubit>()
                      .state
                      .theme!
                      .primaryTextTheme
                      .headline6,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ThemeSelectorWidget extends VTStatelessWidget {
  final Function(int) updateState;
  final Map<int, Widget> themeSegments;
  final int themeSegmentedValue;

  ThemeSelectorWidget({
    Key? key,
    required this.updateState,
    required this.themeSegments,
    required this.themeSegmentedValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            vt.intl.of(context)!.fmt('prefs.appearance'),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: 300,
          child: CupertinoSlidingSegmentedControl(
            padding: const EdgeInsets.all(0),
            groupValue: themeSegmentedValue,
            children: themeSegments,
            onValueChanged: (dynamic i) {
              if (i == 0) {
                BlocProvider.of<PreferenceCubit>(context)
                    .changeTheme('default');
              } else {
                BlocProvider.of<PreferenceCubit>(context).changeTheme('dark');
              }
              updateState.call(i);
            },
          ),
        ),
      ],
    );
  }
}

class LangSelectorWidget extends VTStatelessWidget {
  final Function(int) updateState;
  final Map<int, Widget> langSegments;
  final int langSegmentedValue;

  LangSelectorWidget({
    Key? key,
    required this.updateState,
    required this.langSegments,
    required this.langSegmentedValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            vt.intl.of(context)!.fmt('prefs.lang'),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: 500,
          child: CupertinoSlidingSegmentedControl(
            padding: const EdgeInsets.all(0),
            groupValue: langSegmentedValue,
            children: langSegments,
            onValueChanged: (dynamic i) {
              changeLanguage(i, context);
              updateState.call(i);
            },
          ),
        ),
      ],
    );
  }

  void changeLanguage(int i, BuildContext context) {
    var args = {
      0: () => BlocProvider.of<PreferenceCubit>(context).changeLang('en'),
      1: () => BlocProvider.of<PreferenceCubit>(context).changeLang('tr'),
      2: () => BlocProvider.of<PreferenceCubit>(context).changeLang('ru'),
      3: () => BlocProvider.of<PreferenceCubit>(context).changeLang('ka'),
    };
    args[i]!.call();
  }
}
