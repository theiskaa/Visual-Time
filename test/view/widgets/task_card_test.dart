import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vtime/core/model/task.dart';

import 'package:vtime/view/widgets/task_card.dart';

void main() {
  late TaskCard taskCard;
  late Widget mainWidget;

  var task = Task(
    title: 'Test title',
    description: 'Test des',
    uniquekey: '',
    hours: 1,
    minutes: 10,
  );

  setUpAll(() {
    taskCard = TaskCard(task: task, onDismissed: () {});
    mainWidget = MaterialApp(home: Scaffold(body: taskCard));
  });

  group('[TaskCard]', () {
    testWidgets('test initial widgets', (WidgetTester tester) async {
      await tester.pumpWidget(mainWidget);

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(TaskCard), findsOneWidget);
      expect(find.byType(Dismissible), findsOneWidget);
      expect(find.byType(ListTile), findsOneWidget);
      expect(find.text(task.title!), findsOneWidget);

      await tester.drag(find.byType(Dismissible), const Offset(500, 0));
      await tester.pumpAndSettle();
    });
  });
}
