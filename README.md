# test_tdd_example_inflearn

https://www.inflearn.com/course/flutter-테스트-기초/dashboard
의 기반으로 TDD 연습 하기

## Dependencies

```yaml
dependencies:
  cupertino_icons: ^1.0.6
  mockito: ^5.4.4
  dio: ^5.5.0+1
  freezed_annotation: ^2.4.3
  json_annotation: ^4.9.0
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  build_runner: ^2.4.11
  custom_lint: ^0.6.4
  freezed: ^2.5.2
  json_serializable: ^6.8.0
```

## 1. 기본 구조

- 테스튼 예상이 필요한 변수 및 로직을 적고, 그 다음에 예측이 필요한 변수, 예측하는 값을 적는게 테스트의 기본이다.

## 2. Mockito를 사용하는 이유

### 외부 라이브러리은 내가 만든게 아니기때문에, 그래서, Mock을 해서 같은 환경을 만들어주는게 가장 중요하다.

## 3. Widget Test

### 1. 기본 Method

1. testWidgets() : 위젯 테스트 시, 시작
2. pumpWidget() : runApp()에 해당
3. pump(Duration?) : 지정된 시간 후에 setState() 효과 - 다시 그리기
4. pumpAndSettle() : 에니메이션이 끝날 때 까지 pump()를 반복
5. find : CommonFinder를 사용하는 top-level 함수  
   => 이걸 사용하면 편리하게 위젯을 찾을 수 있음
6. findsOneWidget : 1개의 위젯을 찾았는지

### 2. 특정 Key를 가지는 위젯을 찾기 - find.byKey

공식 문서 예시

```dart
testWidget('find a widget using a key', (tester)async{
    const testKey = Key('k');

    // build a MaterialApp with TestKey
    await tester.pumpWidget(MaterialApp(key: testKey, home: Container()));

    // find the MaterialApp widget using the testKey
    expect(find.byKey(testKey), findsOneWidget);
});
```

특정 위젯의 인스턴스를 찾을 때 편리

```dart
testWidgets('find a specific instance',(tester) async {
    const childWidget = Padding(padding : EdgeInsets.zero);

    await tester.pumpWidget(Container(child: childWidget));

    expect(find.byWidget(childWidget), findsOneWidget);
});
```

### 3. 스크롤 테스트

1. scrollUntilVisible() : 대상이 보일 때까지 스크롤해서 찾기 때문에 편리함

```dart
void main() {
  testWidgets('finds a deep item in a long list', (tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(
      items: List<String>.generate(10000, (i) => 'Item $i'),
    ));

    final listFinder = find.byType(Scrollable);
    final itemFinder = find.byKey(const ValueKey('item_50_text'));

    // Scroll until the item to be found appears.ㅋ
    await tester.scrollUntilVisible(
      itemFinder,
      500.0,
      scrollable: listFinder,
    );

    // Verify that the item contains the correct text.
    expect(itemFinder, findsOneWidget);
  });
}
```

### 4. 유저 인터렉션 테스트

테스트 환경에서는 유저와의 인터렉션을 시뮬레이팅 해야함
테스트 환경에서는 상태가 변경되어도 자동으로 화면을 다시 그리지 않기 때문에
pump() : **그냥 나타는 것들** 또는 pumpAndSettle() : **에니메이팅이 들어가면서 생겨나는 것들**을 사용하여 다시 그리기를 시뮬레이팅을 해야함
(setState)

#### 1. 기본 테스트

```dart
testWidgets('Add and remove a todo', (tester)async {
  // wait build the widget
  await tester.pumpWidget(const TodoList());
  // Simulate Enter 'hi' into the TextField
  await tester.enterText(find.byType(TextField), 'hi');
});
```

tap() 이후에는 pump() 혹은 pumpAndSettle() 을 실행해야 반영됨

#### 2. 상태가 변하는 테스트

```dart
testWidget('Add and remove a todo', (tester)async {
  // Tap the add button
  await tester.tap(find.byType(FloatingActionButton));
  // Rebuilt the widget after State Changed
  await tester.pump();
  // Expect to find the item on screen
  expect(find.text('hi'), findsOneWidget);
})
```

#### 3. 에니메이션까지 들어가서 상태가 변하는 테스트

```dart
testWidget('Add and remove a todo', (tester)async {
  // Tap the add button
  await tester.drag(find.byType(Dismissible), const Offset(500, 0));
  // Rebuilt the widget after State Changed
  await tester.pumpAndSettle();
  // Expect to find the item on screen
  expect(find.text('hi'), findsOneWidget);
})
```
