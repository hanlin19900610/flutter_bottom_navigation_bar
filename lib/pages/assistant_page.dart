import 'package:flutter/material.dart';

class AssistantPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AssistantPageState();
  }
}

class _AssistantPageState extends State<AssistantPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('发布页'),
      ),
    );
  }
}
