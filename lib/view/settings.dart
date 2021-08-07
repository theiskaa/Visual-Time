import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:vtime/core/cubits/preference_cubit.dart';
import 'package:vtime/core/utils/widgets.dart';
import 'package:vtime/view/widgets/components/custom_switchers.dart';

import 'widgets/components/appbars.dart';
import 'widgets/utils.dart';

class Settings extends VTStatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends VTState<Settings> {
  late PreferenceCubit preferenceCubit;

  int themeSegmentedValue = 0, langSegmentedValue = 0;
  bool isAnimationsEnabled = true;
  String selected = 'Nonimooley';

  final langSegments = const <int, Widget>{
    0: Text('English'),
    1: Text('Türkçe'),
    2: Text('Русский'),
    3: Text('ქართული')
  };

  final alarmSounds = [
    'Nonimooley',
    'Crystalie',
    'Favour',
    'Violet',
    'SMS',
    'Points',
    'Iris',
    'Crystal',
    'Harmonics',
    'Marigold'
  ];

  dynamic detectTheme() {
    switch (preferenceCubit.state.themeName) {
      case 'default':
        return themeSegmentedValue = 0;
      case 'dark':
        return themeSegmentedValue = 1;
      case 's/2':
        return themeSegmentedValue = 2;
    }
    return 0;
  }

  dynamic detectLang() {
    switch (preferenceCubit.state.langCode) {
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
    var val = await preferenceCubit.currentAlarmSound;
    selected = val!;
  }

  void detectStateOfAnimations() async {
    var val = await preferenceCubit.isAnimationsEnabled;
    isAnimationsEnabled = val!;
  }

  @override
  void initState() {
    preferenceCubit = BlocProvider.of<PreferenceCubit>(context);

    detectTheme();
    detectLang();
    detectAlarmSound();
    detectStateOfAnimations();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var themeSegments = <int, Widget>{
      0: Text(vt.intl.of(context)!.fmt('prefs.appearance.light')),
      1: Text(vt.intl.of(context)!.fmt('prefs.appearance.dark')),
      2: const Text('S/2')
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
              const SizedBox(height: 30),
              ViewUtils.divider,
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SwitcherTile(
                  title: vt.intl.of(context)!.fmt('prefs.animations'),
                  switcherValue: isAnimationsEnabled,
                  onChanged: (v) {
                    setState(() => isAnimationsEnabled = v);
                    preferenceCubit.changeStateOfAnimations(v);
                  },
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  titleStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AlarmSongSelectorWidget extends VTStatefulWidget {
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
  _AlarmSongSelectorWidgetState createState() =>
      _AlarmSongSelectorWidgetState();
}

class _AlarmSongSelectorWidgetState extends VTState<AlarmSongSelectorWidget> {
  final audioPlayer = AudioPlayer();
  final player = AudioCache(prefix: 'assets/alarms/');

  @override
  void initState() {
    player.fixedPlayer = audioPlayer;
    super.initState();
  }

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
            style: ViewUtils().pomodoroButtonStyle(context),
            onPressed: () => showPicker(context),
            child: Text(
              widget.selected,
              style: TextStyle(color: ViewUtils().pomodoroOrange(context)),
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
              childCount: widget.alarmSounds.length,
              onSelectedItemChanged: (index) {
                player.play('${widget.alarmSounds[index]}.mp3');
                BlocProvider.of<PreferenceCubit>(context).changeAlarmSound(
                  widget.alarmSounds[index],
                );
                widget.updateState.call(widget.alarmSounds[index]);
              },
              itemBuilder: (_, i) => Center(
                child: Text(
                  widget.alarmSounds[i],
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
              final values = {
                0: () {
                  BlocProvider.of<PreferenceCubit>(context)
                      .changeTheme('default');
                },
                1: () {
                  BlocProvider.of<PreferenceCubit>(context).changeTheme('dark');
                },
                2: () {
                  BlocProvider.of<PreferenceCubit>(context).changeTheme('s/2');
                }
              };

              values[i]!.call();
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
