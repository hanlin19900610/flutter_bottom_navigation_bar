import 'package:flutter/material.dart';

class MinePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MinePageState();
  }
}

class _MinePageState extends State<MinePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Text('个人中心')
        ),
    );
  }
}