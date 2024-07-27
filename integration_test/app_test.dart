import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:test_tdd_example_inflearn/5_handle_scrolling/handle_scrolling_screen.dart';
import 'package:test_tdd_example_inflearn/main.dart';

void main() {
  final IntegrationTestWidgetsFlutterBinding binding =
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end', () {
    testWidgets('FAB 탭하면 카운터가 초기화되어야 함', (tester) async {
      // 앱을 시작합니다.
      await tester.pumpWidget(const MyApp());
      await tester.pump();

      // RootScreen의 "counter screen" 버튼을 찾고 탭합니다.
      await tester.tap(find.byKey(const Key('ClickCounterScreen')));
      await tester.pumpAndSettle(); // 모든 애니메이션이 완료될 때까지 기다림

      // CounterScreen의 '0' 텍스트가 화면에 있는지 확인합니다.
      expect(find.text('0'), findsOneWidget);

      // '증가' 버튼을 찾아 클릭합니다.
      await tester.tap(find.text('증가'));
      await tester.pump(); // 상태 변경 후 렌더링을 기다립니다.

      // 카운터 값이 '1'로 증가했는지 확인합니다.
      expect(find.text('1'), findsOneWidget);

      // FloatingActionButton을 찾아 탭합니다.
      await tester.tap(find.byTooltip('refresh'));
      await tester.pump(); // 상태 변경 후 렌더링을 기다림

      // 카운터가 0에서 1로 증가했는지 확인합니다.
      expect(find.text('0'), findsOneWidget);
    });
  });

  group('Performance Test', () {
    testWidgets(
      'Scroll Performance Test',
      (widgetTester) async {
        // 앱을 시작합니다.
        await widgetTester.pumpWidget(const MyApp());
        await widgetTester.pump();

        // RootScreen의 "Handle Scroll Test" 버튼을 찾고 탭합니다.
        await widgetTester.tap(find.byKey(const Key('Handle Scroll Test')));
        await widgetTester.pumpAndSettle(); // 모든 애니메이션이 완료될 때까지 기다림

        final listFinder = find.byType(Scrollable);
        final itemFinder = find.byKey(const ValueKey('item_50_text'));

        await widgetTester.scrollUntilVisible(
          itemFinder,
          500.0,
          scrollable: listFinder,
        );

        expect(itemFinder, findsOneWidget);
      },
    );
  });

  testWidgets('Scroll Performance Test 2', (widgetTester) async {
    // HandleScrollingScreen을 MaterialApp으로 감싸서 렌더링합니다.
    await widgetTester.pumpWidget(MaterialApp(
      home: HandleScrollingScreen(
        items: List.generate(10000, (index) => 'item : $index'),
      ),
    ));

    // 스크롤 가능한 위젯과 특정 항목을 찾습니다.
    final listFinder = find.byType(Scrollable);
    final itemFinder = find.text('item : 50');

    // Add Performance Record
    await binding.traceAction(
      () async {
        // 스크롤하여 item_50_text를 화면에 보이게 합니다.
        await widgetTester.scrollUntilVisible(
          itemFinder,
          500.0,
          scrollable: listFinder,
        );
      },
      reportKey: 'scrolling_timeline', // 여러 개 테스트 대비로 지정하는 것이 좋음
    );

    // item_50_text가 화면에 보이는지 확인합니다.
    expect(itemFinder, findsOneWidget);
  });
}
