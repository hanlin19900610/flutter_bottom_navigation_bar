import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'AssistantPage.dart';
import 'MinePage.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPage();
  }
}

class _MainPage extends State<MainPage> with SingleTickerProviderStateMixin {
  PageController pageController;
  int page = 0;

  //添加图片地址,需要动态更换图片
  String bigImg = 'images/home_green.png';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.red
      ),
        home: Scaffold(
            body: new PageView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[HomePage(), AssistantPage(), MinePage()],
              controller: pageController,
              onPageChanged: onPageChanged,
            ),
            //重构bottomNavigationBar
            bottomNavigationBar: Container(
              height: 100.0,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: BottomNavigationBar(
                      items: [
                        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
                        BottomNavigationBarItem(icon: Icon(Icons.assessment), title: Text('')),
                        BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('我的')),
                      ],
                      onTap: onTap,
                      currentIndex: page,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      child: new Image.asset(bigImg,width: 80.0,height: 80.0,),
                      onTap:onBigImgTap,
                    ),
                  )
                ],
              ),
            )
        ));
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: this.page);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onTap(int index) {
    if (index != 1) {
      setState(() {
        this.bigImg = 'images/home_green.png';
      });
    }
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  //添加图片的点击事件
  void onBigImgTap() {
    setState(() {
      this.page = 1;
      this.bigImg = 'images/icon_home.png';
      onTap(1);
    });
  }



  void onPageChanged(int page) {
    setState(() {
      this.page = page;
    });
  }
}