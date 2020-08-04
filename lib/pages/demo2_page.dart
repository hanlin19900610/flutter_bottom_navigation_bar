import 'package:flutter/material.dart';

import 'assistant_page.dart';
import 'home_page.dart';
import 'mine_page.dart';

class Demo2Page extends StatefulWidget {
  @override
  _Demo2PageState createState() => _Demo2PageState();
}

class _Demo2PageState extends State<Demo2Page> {
  PageController pageController;
  int page = 0;

  //添加图片地址,需要动态更换图片
  //添加图片地址,需要动态更换图片
  String bigImg = 'images/home_green.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo2'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[HomePage(), AssistantPage(), MinePage()],
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onBigImgTap,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.deepOrange,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    onTap(0);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.home, color: getColor(0)),
                      Text("首页", style: TextStyle(color: getColor(0)))
                    ],
                  )),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Icons.home,
                    color: Colors.transparent,
                  ),
                  Text("发布", style: TextStyle(color: Color(0xFFEEEEEE)))
                ],
              ),
              GestureDetector(
                  onTap: () {
                    onTap(2);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.person, color: getColor(2)),
                      Text("我的", style: TextStyle(color: getColor(2)))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Color getColor(int value) {
    return this.page == value
        ? Theme.of(context).primaryColor
        : Color(0XFFBBBBBB);
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
    } else {
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
//      this.bigImg = 'images/icon_home.png';
      onTap(1);
    });
  }

  void onPageChanged(int page) {
    setState(() {
      this.page = page;
    });
  }
}
