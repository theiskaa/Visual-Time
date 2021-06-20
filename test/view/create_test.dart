// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:hive/hive.dart';
// import 'package:vtime/core/model/task.dart';
// import 'package:vtime/core/services/local_db_service.dart';
// import 'package:vtime/view/create.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:vtime/view/widgets/appbars.dart';

void main() {
  // late CreateTaskPage createTaskPage;
  // late Widget mainWidget;

  // late ValueListenable<Box<Task>> todaysBox;

  // setUpAll(() async {
  //   await Hive.initFlutter();
  //   await Hive.openBox<Task>('sunday');
  //   todaysBox = LocalDBService.sundayBox().listenable();

  //   createTaskPage = CreateTaskPage(todaysBox: todaysBox);
  //   mainWidget = MaterialApp(home: createTaskPage);
  // });

  // group('[CreateTaskPage]', () {
  //   testWidgets('should contain inital sates and widgets',
  //       (WidgetTester tester) async {
  //     await tester.pumpWidget(mainWidget);

  //     expect(find.byType(Scaffold), findsOneWidget);
  //     expect(find.byType(TransparentAppBar), findsOneWidget);
  //     expect(find.byType(Padding), findsOneWidget);
  //     expect(find.byType(FractionallySizedBox), findsOneWidget);
  //     expect(find.byType(ElevatedButton), findsOneWidget);

  //     await tester.tap(find.byIcon(Icons.arrow_back_ios));
  //     await tester.pumpAndSettle();
  //   });
  // });
}
