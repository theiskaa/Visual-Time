import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtime/core/cubits/preference_cubit.dart';
import 'package:vtime/core/cubits/preference_state.dart';

import 'core/utils/intl.dart';
import 'core/utils/widgets.dart';
import 'view/home.dart';

class App extends VTStatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends VTState<App> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PreferenceCubit>(
      create: (BuildContext context) => PreferenceCubit()
        ..getCurrentTheme()
        ..getCurrentLang(),
      child: BlocBuilder<PreferenceCubit, PreferenceState>(
        builder: (context, state) {
          if (state.theme == null) return Container(color: Colors.white);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Home(),
            theme: state.theme,
            locale: Locale(state.langCode ?? vt.intl.locale.languageCode),
            localizationsDelegates: [
              vt.intl.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: languages.map((language) => Locale(language, '')),
          );
        },
      ),
    );
  }
}
