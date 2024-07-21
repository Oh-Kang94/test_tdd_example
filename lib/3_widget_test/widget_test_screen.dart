import 'package:flutter/material.dart';

class WidgetTestScreen extends StatelessWidget {
  const WidgetTestScreen(
      {super.key, required this.title, required this.message});
  static const String routesName = '/widgetTest';
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}
