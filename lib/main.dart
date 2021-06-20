import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/model/task.dart';
import 'view/home.dart';
import 'view/widgets/themes.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());

  await Hive.openBox<Task>('monday');
  await Hive.openBox<Task>('tuesday');
  await Hive.openBox<Task>('wednesday');
  await Hive.openBox<Task>('thursday');
  await Hive.openBox<Task>('friday');
  await Hive.openBox<Task>('saturday');
  await Hive.openBox<Task>('sunday');

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes().defaultTheme,
      home: const Home(),
    );
  }
}
