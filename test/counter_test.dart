import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_tdd_example_inflearn/1_counter/counter.dart';
import 'package:mockito/annotations.dart';
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
        when(mockAlbumRepository.fetchAlbum()).thenThrow(Exception('Failed to load Album'));

      expect(() async => await mockAlbumRepository.fetchAlbum(), throwsException);
      },
    );
  });
}
