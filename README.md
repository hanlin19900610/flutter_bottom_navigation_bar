## 仿闲鱼底部导航栏带有中间凸起图标

##### 刚接触Flutter,需要实现一个类似闲鱼APP的底部导航栏的实现

> 源码链接: [https://github.com/hanlin19900610/flutter_bottom_navigation_bar](https://github.com/hanlin19900610/flutter_bottom_navigation_bar)

##### 要实现的效果如图:
![image](https://github.com/hanlin19900610/flutter_bottom_navigation_bar/blob/master/screen/demo1.png)
![image](https://github.com/hanlin19900610/flutter_bottom_navigation_bar/blob/master/screen/demo2.png)

#### 好的,下面开始上代码了:

##### 一. 在main.dart文件中,定义APP的入口信息

```
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
```

##### 二. 我们需要定义三个页面,功能类似Android的Fragment,分别为home_page.dart, assistant_page.dart,mine_page.dart, 这三个页面的代码很简单:

```
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text('首页')),
    );
  }
}
```

> 这个三个页面的代码都一样就没有都贴出来

#### 三. 实现底部导航凸起有两种方式
##### 1. 底部导航采用BottomNavigationBar来实现
![image](https://github.com/hanlin19900610/flutter_bottom_navigation_bar/blob/master/screen/demo1.png)

中间按钮使用"floatingActionButton" 悬浮按钮,
通过"floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,",
来设置悬浮按钮的显示位置

```

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
```
##### 2. 底部导航用BottomAppBar来实现
![image](https://github.com/hanlin19900610/flutter_bottom_navigation_bar/blob/master/screen/demo2.png)

中间按钮采用"FloatingActionButton"悬浮按钮来实现,
使用"floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,",来控制按钮显示的位置,
BottomAppBar通过设置属性"shape: CircularNotchedRectangle(),",来和悬浮按钮实现完美的契合,出现一个弧度的凹槽

```

class Demo2Page extends StatefulWidget {
  @override
  _Demo2PageState createState() => _Demo2PageState();
}

class _Demo2PageState extends State<Demo2Page> {
  PageController pageController;
  int page = 0;

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
        onPressed: () => onTap(1),
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
    pageController.jumpToPage(index);
  }

  void onPageChanged(int page) {
    setState(() {
      this.page = page;
    });
  }
}
```
 两种效果已实现, 详细代码参见"demo1_page.dart","demo2_page.dart".
 
