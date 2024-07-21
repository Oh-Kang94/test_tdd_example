import 'package:flutter/material.dart';

class TapAndDragEnterTextScreen extends StatefulWidget {
  const TapAndDragEnterTextScreen({super.key});
  static const String routesName = '/tapAndDragEnterText';

  @override
  State<TapAndDragEnterTextScreen> createState() =>
      _TapAndDragEnterTextScreenState();
}

class _TapAndDragEnterTextScreenState extends State<TapAndDragEnterTextScreen> {
  final List<String> todo = [];
  final TextEditingController ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            todo.add(ctrl.text);
            ctrl.clear();
            setState(() {});
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: ctrl,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: todo.length,
                  itemBuilder: (context, int index) {
                    final todoOne = todo[index];
                    return Dismissible(
                      key: Key("$todo$index"),
                      background: Container(
                        color: Colors.red,
                      ),
                      onDismissed: (direction) {
                        //튜토리얼에는 없지만 이걸 빼 먹으면 에러 남
                        todo.removeAt(index);
                        setState(() {});
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(todoOne),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
