import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:test_tdd_example_inflearn/main.dart';

void main() {
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
}
