import 'package:flutter/material.dart';
import 'package:test_tdd_example_inflearn/1_counter/counter.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});
  static String get routesName => '/counter'; 

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  final _counter = Counter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '버튼을 누른 횟수',
            ),
            Text(
              '${_counter.value}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => _countUp(),
                  child: const Text("증가"),
                ),
                ElevatedButton(
                  onPressed: () => _countDown(),
                  child: const Text("감소"),
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _clear(),
        tooltip: 'Increment',
        child: const Icon(Icons.refresh),
      ),
    );
  }

  void _countUp() {
    setState(() {
      _counter.countUp();
    });
  }

  void _countDown() {
    setState(() {
      _counter.countDown();
    });
  }

  void _clear() {
    setState(() {
      _counter.clear();
    });
  }
}
