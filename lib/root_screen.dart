import 'package:flutter/material.dart';
import 'package:test_tdd_example_inflearn/2_album/album_screen.dart';
import 'package:test_tdd_example_inflearn/1_counter/counter_screen.dart';
import 'package:test_tdd_example_inflearn/3_widget_test/widget_test_screen.dart';
import 'package:test_tdd_example_inflearn/4_find_widget/find_widget_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});
  static String get routesName => '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                CounterScreen.routesName,
              ),
              child: const Text("counter screen"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                AlbumScreen.routesName,
              ),
              child: const Text("album screen"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                AlbumScreen.routesName,
              ),
              child: const Text("album screen"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                WidgetTestScreen.routesName,
              ),
              child: const Text("widget test screen"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                FindWidgetScreen.routesName,
              ),
              child: const Text("find widget test screen"),
            ),
          ],
        ),
      ),
    );
  }
}
