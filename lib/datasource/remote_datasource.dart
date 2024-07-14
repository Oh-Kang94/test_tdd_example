import 'package:dio/dio.dart';

class RemoteDatasource {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
    ),
  );
}
