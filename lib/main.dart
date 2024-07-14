import 'package:flutter/material.dart';
import 'package:test_tdd_example_inflearn/2_album/album_screen.dart';
import 'package:test_tdd_example_inflearn/1_counter/counter_screen.dart';
import 'package:test_tdd_example_inflearn/root_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      // 기본 라우트
      initialRoute: RootScreen.routesName,
      // 라우트 정의
      routes: {
        RootScreen.routesName: (context) => const RootScreen(),
        CounterScreen.routesName: (context) => const CounterScreen(),
        AlbumScreen.routesName: (context) => const AlbumScreen(),
      },
    );
  }
}
