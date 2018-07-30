import 'package:flutter/material.dart';

class AssistantPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AssistantPageState();
  }
}

class _AssistantPageState extends State<AssistantPage>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('这是助手页面'),
        ),
      ),
    );
  }
}