import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtime/core/cubits/preference_cubit.dart';
import 'package:vtime/core/utils/widgets.dart';
import 'package:vtime/view/home.dart';

class AppSetup extends VTStatefulWidget {
  AppSetup({Key? key}) : super(key: key);

  @override
  _AppSetupState createState() => _AppSetupState();
}

class _AppSetupState extends VTState<AppSetup> {
  final langSegments = const <int, Widget>{
    0: Text('English'),
    1: Text('Türkçe'),
    2: Text('Русский'),
    3: Text('ქართული')
  };

  int themeSegmentedValue = 0;
  int langSegmentedValue = 0;

  @override
  Widget build(BuildContext context) {
    var themeSegments = <int, Widget>{
      0: Text(vt.intl.of(context)!.fmt('prefs.appearance.light')),
      1: Text(vt.intl.of(context)!.fmt('prefs.appearance.dark'))
    };

    return Scaffold(
      appBar: AppBar(title: Text(vt.intl.of(context)!.fmt('app.setup'))),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.done), onPressed: completeSetup),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 130),
              themeSelecting(themeSegments),
              const SizedBox(height: 100),
              langSelecting(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Column themeSelecting(themeSegments) {
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
              changeTheme(i);
              setState(() => themeSegmentedValue = i);
            },
          ),
        ),
      ],
    );
  }

  Column langSelecting() {
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
              changeLanguage(i);
              setState(() => langSegmentedValue = i);
            },
          ),
        ),
      ],
    );
  }

  void completeSetup() {
    changeTheme(themeSegmentedValue);
    changeLanguage(langSegmentedValue);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Home()),
      (route) => false,
    );
  }

  void changeLanguage(int i) {
    var args = {
      0: () => BlocProvider.of<PreferenceCubit>(context).changeLang('en'),
      1: () => BlocProvider.of<PreferenceCubit>(context).changeLang('tr'),
      2: () => BlocProvider.of<PreferenceCubit>(context).changeLang('ru'),
      3: () => BlocProvider.of<PreferenceCubit>(context).changeLang('ka'),
    };
    args[i]!.call();
  }

  void changeTheme(int i) {
    if (i == 0) {
      BlocProvider.of<PreferenceCubit>(context).changeTheme('default');
    } else {
      BlocProvider.of<PreferenceCubit>(context).changeTheme('dark');
    }
  }
}
