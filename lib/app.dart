import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vtime/core/cubits/preference_cubit.dart';
import 'package:vtime/core/cubits/preference_state.dart';
import 'package:vtime/core/services/local_db_service.dart';
import 'package:vtime/view/set_up.dart';

import 'core/utils/intl.dart';
import 'core/utils/widgets.dart';
import 'view/dashboard.dart';

class App extends VTStatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends VTState<App> {
  final _dbService = LocalDBService();

  Widget? home;

  @override
  void initState() {
    super.initState();
    home = _dbService.isPreferencesSetted() ? Dashboard() : AppSetup();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PreferenceCubit>(
      create: (BuildContext context) => PreferenceCubit()..initApp(),
      child: BlocBuilder<PreferenceCubit, PreferenceState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: home,
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
