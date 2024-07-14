import 'package:dio/dio.dart';
import 'package:test_tdd_example_inflearn/model/album.dart';
import 'package:test_tdd_example_inflearn/datasource/remote_datasource.dart';

class AlbumRepository {
  final RemoteDatasource _remoteDatasource;

  AlbumRepository({required RemoteDatasource remoteDatasource})
      : _remoteDatasource = remoteDatasource;

  Future<Album> fetchAlbum() async {
    try {
      final Response response = await _remoteDatasource.dio.get('/albums/1');
      return Album.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load Album');
    }
  }
}
