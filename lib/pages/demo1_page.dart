import 'package:flutter/material.dart';

import 'home_page.dart';
import 'assistant_page.dart';
import 'mine_page.dart';

class Demo1Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Demo1Page();
  }
}

class _Demo1Page extends State<Demo1Page> with SingleTickerProviderStateMixin {
  PageController pageController;
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo1'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[new HomePage(), new AssistantPage(), new MinePage()],
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onTap(1),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.assessment,
                color: Colors.transparent,
              ),
              title: Text('发布')),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('我的')),
        ],
        onTap: onTap,
        currentIndex: page,
      ),
    );
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
    pageController.jumpToPage(index);
  }

  void onPageChanged(int page) {
    setState(() {
      this.page = page;
    });
  }
}
