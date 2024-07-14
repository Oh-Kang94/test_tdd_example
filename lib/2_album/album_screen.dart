import 'package:flutter/material.dart';
import 'package:test_tdd_example_inflearn/datasource/remote_datasource.dart';
import 'package:test_tdd_example_inflearn/model/album.dart';
import 'package:test_tdd_example_inflearn/repository/album_repository.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});
  static String get routesName => '/album';

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  late Future<Album> futureAlbum;
  final AlbumRepository _repository = AlbumRepository(remoteDatasource: RemoteDatasource());

  @override
  void initState() {
    super.initState();
    futureAlbum = _repository.fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Album>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.title);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
