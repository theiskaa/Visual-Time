import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtime/core/cubits/preference_cubit.dart';
import 'package:vtime/core/cubits/preference_state.dart';

import 'view/home.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PreferenceCubit>(
      create: (BuildContext context) => PreferenceCubit()..getCurrentTheme(),
      child: BlocBuilder<PreferenceCubit, PreferenceState>(
        builder: (context, state) {
          if (state.theme == null) return Container(color: Colors.white);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.theme,
            home: const Home(),
          );
        },
      ),
    );
  }
}
