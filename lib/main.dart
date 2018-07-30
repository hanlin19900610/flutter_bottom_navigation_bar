import 'package:flutter/material.dart';
import 'pages/MainPage.dart';

void main() => runApp(LightLanguageClient());

class LightLanguageClient extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
      home: MainPage(),
    );
  }
}