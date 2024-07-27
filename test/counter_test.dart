import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_tdd_example_inflearn/1_counter/counter.dart';
import 'package:mockito/annotations.dart';
import 'package:test_tdd_example_inflearn/3_widget_test/widget_test_screen.dart';
import 'package:test_tdd_example_inflearn/5_handle_scrolling/handle_scrolling_screen.dart';
import 'package:test_tdd_example_inflearn/7_tap_and_drag_enter_text/tap_and_drag_enter_text_screen.dart';
import 'package:test_tdd_example_inflearn/datasource/remote_datasource.dart';
import 'package:test_tdd_example_inflearn/model/album.dart';
import 'package:test_tdd_example_inflearn/repository/album_repository.dart';

import 'counter_test.mocks.dart';

@GenerateMocks([RemoteDatasource, Dio, AlbumRepository])
void main() {
  // Group :
  group(
    'Counter',
    () {
      test(
        'It must starts 0',
        () {
          // 첫 param은 추측하고 싶은 변수, 두번째 param은 기대하는 값
          expect(
            Counter().value,
            0,
          );
        },
      );
      test(
        'Add +1',
        () {
          final counter = Counter();
          counter.countUp();
          expect(counter.value, 1);
        },
      );
      // 1씩 감소
      test(
        'Sub 1',
        () {
          final counter = Counter();
          counter.countDown();
          expect(counter.value, -1);
        },
      );
      // 0으로 Reset
      test('reset 0', () {
        final counter = Counter();
        counter.clear();
        expect(counter.value, 0);
      });
    },
  );

  group('AlbumRepository', () {
    late AlbumRepository albumRepository;
    late MockRemoteDatasource mockRemoteDatasource;
    late MockDio mockDio;

    setUp(() {
      mockRemoteDatasource = MockRemoteDatasource();
      mockDio = MockDio();
      when(mockRemoteDatasource.dio).thenReturn(mockDio);
      albumRepository = AlbumRepository(remoteDatasource: mockRemoteDatasource);
    });

    test('fetchAlbum returns Album when the call completes successfully',
        () async {
      final albumJson = {
        'userId': 1,
        'id': 1,
        'title': 'quidem molestiae enim',
      };

      when(mockDio.get('/albums/1')).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/albums/1'),
          data: albumJson,
          statusCode: 200,
        ),
      );

      final album = await albumRepository.fetchAlbum();

      expect(album.userId, 1);
      expect(album.id, 1);
      expect(album.title, 'quidem molestiae enim');
    });

    test('fetchAlbum throws an exception when the call fails', () async {
      when(mockDio.get('/albums/1')).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/albums/1'),
      ));

      expect(albumRepository.fetchAlbum(), throwsException);
    });
  });

  group('Mock AlbumRepository', () {
    late MockAlbumRepository mockAlbumRepository;

    setUp(() {
      mockAlbumRepository = MockAlbumRepository();
    });

    test('fetchAlbum returns Album when the call completes successfully',
        () async {
      final expectResult =
          Album(userId: 1, id: 1, title: 'quidem molestiae enim');

      when(mockAlbumRepository.fetchAlbum()).thenAnswer(
        (_) async => expectResult,
      );

      expect(await mockAlbumRepository.fetchAlbum(), isA<Album>());
      expect(await mockAlbumRepository.fetchAlbum(), expectResult);
    });
    test(
      'Error 404',
      () async {
        when(mockAlbumRepository.fetchAlbum())
            .thenThrow(Exception('Failed to load Album'));

        expect(() async => await mockAlbumRepository.fetchAlbum(),
            throwsException);
      },
    );
  });

  group(
    'testWidget',
    () {
      testWidgets(
        'title, message가 잘 표시 되어야한다.',
        (tester) async {
          //  title : t , message : M
          await tester.pumpWidget(
            const MaterialApp(
              home: WidgetTestScreen(title: 'T', message: 'm'),
            ),
          );
          // T 글자가 있는 객체
          final titleFinder = find.text('T');
          // M 글자가 있는 객체
          final msgFinder = find.text('m');

          // 각각 1개씩 있는지 검사
          expect(titleFinder, findsOneWidget);
          expect(msgFinder, findsOneWidget);
        },
      );
      testWidgets(
        'Counter increments smoke test',
        (WidgetTester tester) async {
          const testKey = Key('K');
          await tester.pumpWidget(
            const MaterialApp(
              home: Scaffold(
                key: testKey,
                body: Text('H'),
              ),
            ),
          );
          expect(find.byKey(testKey), findsOneWidget);
        },
      );
    },
  );

  group('list test', () {
    testWidgets('list test', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: HandleScrollingScreen(
            items: List.generate(10000, (i) => "Item $i"),
          ),
        ),
      );
      // Scroll 가능한 위젯을 찾는다.
      final listFinder = find.byType(Scrollable);
      // 50번째 아이템을 찾는 객체 생성
      final itemFinder = find.byKey(const ValueKey("item_50_text"));

      await tester.scrollUntilVisible(itemFinder, 100, scrollable: listFinder);
      expect(itemFinder, findsOneWidget);
    });
  });

  group('UserInteraction Test', () {
    // setUp(() async {
    //   await tester.pumpWidget(const MaterialApp(
    //     home: TapAndDragEnterTextScreen(),
    //   ));
    // });
    testWidgets(
      'Text입력, drag',
      (tester) async {
        await tester.pumpWidget(const MaterialApp(
          home: TapAndDragEnterTextScreen(),
        ));
        // HI 입력
        await tester.enterText(find.byType(TextField), 'Hi');
        // 더하기 입력
        await tester.tap(find.byType(FloatingActionButton));
        // 상태 변경을 해야한다.
        await tester.pump();
        expect(find.text('Hi'), findsOneWidget);
      },
    );

    testWidgets('Dismissible Test', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: TapAndDragEnterTextScreen(),
      ));
      // HI 입력
      await tester.enterText(find.byType(TextField), 'Hi');
      // 더하기 입력
      await tester.tap(find.byType(FloatingActionButton));
      // 상태 변경을 해야한다.
      await tester.pump();
      // drag를 한다.
      await tester.drag(find.byType(Dismissible), const Offset(500, 0));

      // 상태 변경을 해야한다. 단, Animation이 발생되므로, pump가 아닌 pumpAndSettle을 사용해야한다.
      await tester.pumpAndSettle();

      expect(find.text('Hi'), findsNothing);
    });
  });
}
