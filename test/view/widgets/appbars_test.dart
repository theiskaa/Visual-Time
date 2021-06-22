import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vtime/view/widgets/appbars.dart';

void main() {
  late TransparentAppBar transparentAppBar;
  late Widget mainWidget;

  setUpAll(() {
    transparentAppBar = TransparentAppBar(
      onLeadingTap: () {},
    );
    mainWidget = MaterialApp(home: Scaffold(appBar: transparentAppBar));
  });

  group('[AppBars]', () {
    testWidgets('test "TransparentAppBar"', (WidgetTester tester) async {
      await tester.pumpWidget(mainWidget);

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_back_ios));
      await tester.pumpAndSettle();
    });
  });
}
