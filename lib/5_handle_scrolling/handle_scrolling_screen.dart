import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HandleScrollingScreen extends StatelessWidget {
  const HandleScrollingScreen({super.key, required this.items});
  final List<String> items;
  static const String routesName = '/handleScrolling';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        key: const Key("long_list"),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(items[index]),
              key: Key("item_${index}_text"),
            ),
          );
        },
      ),
    );
  }
}
