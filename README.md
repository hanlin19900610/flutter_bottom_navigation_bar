## 仿闲鱼底部导航栏带有中间凸起图标

##### 刚接触Flutter,需要实现一个类似闲鱼APP的底部导航栏的实现

> 源码链接: [https://github.com/hanlin19900610/flutter_bottom_navigation_bar](https://github.com/hanlin19900610/flutter_bottom_navigation_bar)

##### 要实现的效果如图:
![image](http://i1.bvimg.com/655692/124fc0b555aefe0a.png)

#### 好的,下面开始上代码了:

##### 一. 在main.dart文件中,定义APP的入口信息

```
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
```

##### 二. 我们需要定义三个页面,功能类似Android的Fragment,分别为HomePage.dart, AssistantPage.dart,MinePage.dart, 这三个页面的代码很简单:

```
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('这是首页'),
        ),
      ),
    );
  }
}
```

> 这个三个页面的代码都一样就没有都贴出来

##### 三.现在我们就需要去创建我们的主页了,"MainPage.dart"文件

###### 第一步,我们先去实现一个最简单的底部导航栏

```
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: new PageView(
        children: <Widget>[HomePage(), AssistantPage(), MinePage()],
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
          BottomNavigationBarItem(icon: Icon(Icons.assessment), title: Text('助手')),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('我的')),
        ],
        onTap: onTap,
        currentIndex: page,
      ),
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
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this.page = page;
    });
  }
}
```
###### 在MainPage.dart中我们用到了几个控件:
###### 1. PageView : 此控件类似Android的ViewPager,把之前创建的3个页面一次添加进去,之后需要给PageView设置一个控制器-PageController,给PageView设置一个onPageChanged页面切换监听方法,此方法的功能类似与Android中ViewPager中的OnPageChangeListener里的监听方法

###### 2. BottomNavigationBar :此控件主要用于配置底部导航栏,详细用法请参见[官方文档](https://docs.flutter.io/flutter/material/BottomNavigationBar-class.html),在此控件的使用中,我们需要设置三个属性,
1.  items: 添加底部导航栏的每个Item
2.  onTap: 为底部导航栏设置点击事件
3.  currentIndex: 为底部导航设置当前选中项

###### 3. BottomNavigationBarItem: 此控件是底部导航栏的Item

##### 至此,我们实现了最基本的底部导航栏的实现,效果图如下:
![image](http://i2.bvimg.com/655692/bdd1d193b659c5c0.gif)

#### 四.我们要实现仿闲鱼的底部导航栏,需要重构一下底部导航栏,
##### 重构方案:
###### 1.把中间的文字去掉
###### 2.在BottomNavigationBar控件的中上的位置放入一个图片
###### 3.重构底部导航的事件方法
###### 4.禁止PageView的滑动事件

##### 现在开始重构:
###### 1.要在BottomNavigationBar上面覆盖一个图片,我们需要用到一个布局Widget---Stack,类似于Framelayout

```
class _MainPage extends State<MainPage> with SingleTickerProviderStateMixin {
  PageController pageController;
  int page = 0;
  //添加图片地址,需要动态更换图片
  String bigImg = 'images/home_green.png';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: new PageView(
        children: <Widget>[HomePage(), AssistantPage(), MinePage()],
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      //重构bottomNavigationBar
      bottomNavigationBar: Stack(
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

//修改bottomNavigationBar的点击事件
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
```

重构完成之后,效果图如下,我们发现这并不是我们想要的,底部导航栏我们是实现了,但是PageView被遮盖了


![image](http://i4.bvimg.com/655692/869d6a394e6ad36c.gif)

##### PageView被遮盖的解决办法,我们给Stack添加一个可以指定高度的父级--Container,修改的代码如下:

```
bottomNavigationBar: Container(
            height: 100.0,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: BottomNavigationBar(
                    items: [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.home), title: Text('首页')),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.accessibility_new), title: Text('')),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.person), title: Text('我的')),
                    ],
                    onTap: onTap,
                    currentIndex: page,
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: InkWell(
                        child: new Image.asset(
                          bigImg,
                          width: 80.0,
                          height: 80.0,
                        ),
                        onTap: onBigImgTap,
                      ),
                    )),
              ],
            ),
          )
```

###### 然后我们需要禁止PageView的滑动,我们只需要在给PageView设置一个属性就好了

```
physics: NeverScrollableScrollPhysics(),
```

##### 在运行Flutter项目的时候出现了一个问题,运行时会出现一段时间的白屏,解决办法:

> 解决方案很简单，Android原生的白屏问题可以通过为 Launcher Activity 设置 windowBackground 解决，而 Flutter 也是基于此办法，同时优化了 Flutter 初始化阶段的白屏问题（覆盖一个launchView），只用两步设置便能解决 Flutter 中白屏问题。
>
> 在项目的 android/app/src/main/res/mipmap-xhdpi/ 目录下添加闪屏图片；
>
> 打开 android/app/src/main/res/drawable/launch_background.xml 文件，这个文件就是闪屏的背景文件，具体如何设置可以查阅 Android Drawable，我在 demo 中的设置如下：


```
<?xml version="1.0" encoding="utf-8"?>
<layer-list xmlns:android="http://schemas.android.com/apk/res/android">
  <item android:drawable="@android:color/background_dark" />
 
  <!-- You can insert your own image assets here -->
  <item
    android:bottom="84dp">
    <bitmap
      android:src="@mipmap/launch_image" />
  </item>
</layer-list>
```



#### 如此一来,我们就完成了,文章开始提出的需求了.

> 刚开始接触Flutter,代码写的有些混乱,可能有些问题考虑不是很深入,有不足之处,还请各位大佬指出

> 源码链接: [https://github.com/hanlin19900610/flutter_bottom_navigation_bar](https://github.com/hanlin19900610/flutter_bottom_navigation_bar)


#### 推荐阅读

##### 1. Flutter中文网   [https://flutterchina.club/](https://flutterchina.club/)
##### 2. 阿韦大神的Github   [https://github.com/AweiLoveAndroid/Flutter-learning](https://github.com/AweiLoveAndroid/Flutter-learning)
##### 3. Flutter学习笔记 - 底部导航栏  [https://blog.csdn.net/u011045726/article/details/79583423](https://blog.csdn.net/u011045726/article/details/79583423)





