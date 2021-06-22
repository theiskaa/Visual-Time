import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vtime/core/model/task.dart';
import 'package:vtime/view/widgets/day_chart.dart';

void main() {
  late DayChart dayChart;
  late Widget mainWidget;

  List<Task> tasks = List<Task>.generate(
    3,
    (i) => Task(
      title: 'title $i',
      description: 'des $i',
      hours: i,
      minutes: i * 10,
    ),
  );

  group('[DayChart]', () {
    setUpAll(() {
      dayChart = DayChart(tasks: tasks);
      mainWidget = MaterialApp(home: Scaffold(body: dayChart));
    });
    testWidgets('test as default', (WidgetTester tester) async {
      await tester.pumpWidget(mainWidget);

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(DayChart), findsOneWidget);
      expect(find.byType(SfCircularChart), findsOneWidget);
    });

    setUpAll(() {
      dayChart = DayChart(tasks: tasks, tooltipBehaviorEnabled: true);
      mainWidget = MaterialApp(home: Scaffold(body: dayChart));
    });

    testWidgets(
      'test while [tooltipBehaviorEnabled] is true',
      (WidgetTester tester) async {
        await tester.pumpWidget(mainWidget);

        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(DayChart), findsOneWidget);
        expect(find.byType(SfCircularChart), findsOneWidget);
      },
    );
  });
}
