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
        theme: ThemeData(primaryColor: Colors.red),
        home: Scaffold(
            body: Stack(
          children: <Widget>[
            Scaffold(
              body: PageView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  new HomePage(),
                  new AssistantPage(),
                  new MinePage()
                ],
                controller: pageController,
                onPageChanged: onPageChanged,
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), title: Text('首页')),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.assessment), title: Text('发布')),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person), title: Text('我的')),
                ],
                onTap: onTap,
                currentIndex: page,
              ),
            ),
            Align(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: FloatingActionButton(
                  child: new Image.asset(bigImg),
                  onPressed: onBigImgTap,
                ),
              ),
              alignment: Alignment.bottomCenter,
            ),
          ],
        )));
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
    }else{
      setState(() {
        this.bigImg = 'images/icon_home.png';
      });
    }

    pageController.jumpToPage(index);
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
