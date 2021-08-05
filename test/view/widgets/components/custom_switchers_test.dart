import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:vtime/view/widgets/components/custom_switchers.dart';

void main() {
  late SwitcherTile switcherTile;
  late Widget mainWidget;

  bool switcherValue = false;

  setUpAll(() {
    switcherTile = SwitcherTile(
      title: 'Test switcher',
      switcherValue: switcherValue,
      onChanged: (v) => switcherValue = v,
    );
    mainWidget = MaterialApp(home: Scaffold(body: switcherTile));
  });

  group('[Custom Switchers]', () {
    testWidgets('test "SwitcherTile"', (WidgetTester tester) async {
      await tester.pumpWidget(mainWidget);

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(SwitcherTile), findsOneWidget);

      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(Align), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.byType(SwitcherTile), findsOneWidget);
      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.byType(CupertinoSwitch), findsOneWidget);

      expect(switcherValue, false);

      await tester.tap(find.byType(CupertinoSwitch));
      await tester.pumpAndSettle();

      expect(switcherValue, true);
    });
  });
}
