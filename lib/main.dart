import 'package:flutter/material.dart';
import 'package:flutter_bottom_navigation_bar/pages/demo2_page.dart';
import 'pages/demo1_page.dart';
import 'pages/demo1_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
      home: DemoPage(),
    );
  }
}

class DemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return Demo1Page();
                }));
              },
              child: Text('DEMO1'),
            ),
            RaisedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return Demo2Page();
                }));
              },
              child: Text('DEMO2'),
            ),
          ],
        ),
      ),
    );
  }
}
