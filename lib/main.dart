import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vtime/core/services/local_db_service.dart';
import 'package:vtime/core/utils/inlt.dart';

import 'app.dart';
import 'core/model/task.dart';
import 'core/vt.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());

  await Hive.openBox('preferences');

  await Hive.openBox<Task>('monday');
  await Hive.openBox<Task>('tuesday');
  await Hive.openBox<Task>('wednesday');
  await Hive.openBox<Task>('thursday');
  await Hive.openBox<Task>('friday');
  await Hive.openBox<Task>('saturday');
  await Hive.openBox<Task>('sunday');

  final VT vt = VT();

  vt.intl = Intl();
  vt.localDbService = LocalDBService();

  vt.intl.locale = const Locale('en');
  vt.intl.supportedLocales = languages;

  runApp(App());
}
