import 'package:flutter/material.dart';
import 'package:flutter_xianyu/pages/fun/index.dart';
import 'package:flutter_xianyu/pages/main/index.dart';
import 'package:flutter_xianyu/pages/main/main_page.dart';
import './pages/fun/index.dart';
import './pages/message/index.dart';
import './pages/my/index.dart';
import './pages/publish/index.dart';
import 'package:lottie/lottie.dart';
import './common/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        highlightColor: Color.fromRGBO(0, 0, 0, 0),
        splashColor: Color.fromRGBO(0, 0, 0, 0),

        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: StickyPage(),
      home: AppHome(),
      // home: GifIndicatorExample1(),
    );
  }
}

class AppHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppHomeState();
}

class AppHomeState extends State<AppHome> with SingleTickerProviderStateMixin {
  /// 当前选中的index
  int currentIndex = 0;
  // Widget currentView;
  var publishOverlayEntry = null;

  /// 第一个菜单
  Widget fishTabbarActiveIcon = null;
  //// icon的大小
  final iconImageSpace = 22.0;

  AnimationController _animationController;
  Map<int, Widget> pageMap = {
    0: MainPage(),
    1: FunPage(),
    2: PublishPage(),
    3: MessagePage(),
    4: MyHomePage()
  };
  @override
  initState() {
    super.initState();
    _animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageMap[this.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        onTap: (index) {
          this.setState(() {
            if (index != 2) {
              this.currentIndex = index;
              _animationController.forward(from: 0.0);
            } else {
              showWeixinButtonView();
            }
          });
        },
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              "images/ic_tabbar_home-top_nor@3x.png",
              width: iconImageSpace,
              height: iconImageSpace,
            ),
            title: Text('闲鱼'),
            activeIcon: Lottie.asset(
              "assets/lot_tab_home.json",
              width: iconImageSpace,
              height: iconImageSpace,
              controller: _animationController,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "images/ic_tabbar_niceplay_nor@3x.png",
              width: iconImageSpace,
              height: iconImageSpace,
            ),
            title: Text('会玩'),
            activeIcon: Lottie.asset(
              "assets/lot_tab_niceplay.json",
              width: iconImageSpace,
              height: iconImageSpace,
              controller: _animationController,
            ),
          ),
          BottomNavigationBarItem(
            title: Text(''),
            icon: SizedBox(
              width: 30,
              height: 30,
              child: Stack(
                overflow: Overflow.visible,
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    top: 3.0,
                    child: Container(
                      child: Image.asset(
                        "images/ic_tabbar_release@3x.png",
                        width: 35,
                        height: 35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          BottomNavigationBarItem(
            // ic_tabbar_message_nor@3x.png
            icon: Image.asset(
              "images/ic_tabbar_message_nor@3x.png",
              width: iconImageSpace,
              height: iconImageSpace,
            ),
            title: Text('消息'),
            activeIcon: Lottie.asset(
              "assets/lot_tab_message.json",
              width: iconImageSpace,
              height: iconImageSpace,
              controller: _animationController,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "images/ic_tabbar_mine_nor@3x.png",
              width: iconImageSpace,
              height: iconImageSpace,
            ),
            title: Text('我的'),
            activeIcon: Lottie.asset(
              "assets/lot_tab_me.json",
              width: iconImageSpace,
              height: iconImageSpace,
              controller: _animationController,
            ),
          ),
        ],
      ),
    );
  }

  void showWeixinButtonView() {
    publishOverlayEntry = OverlayEntry(builder: (context) {
      return Scaffold(
        body: InkWell(
          onTap: () {
            this.publishOverlayEntry.remove();
          },
          child: Container(
            decoration: new BoxDecoration(
              color: Color(0xff333333),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  height: 120,
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _getMenuList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
    Overlay.of(context).insert(publishOverlayEntry);
  }

  /// 创建菜单按钮
  List<Widget> _getMenuList() {
    final paddingLeft = 20.0;
    final textPaddingLeft = 10.0;
    var data = [
      {
        "image": "images/img_7.png",
        "title": "发会玩贴子",
        "subTitle": "分享你的趣事",
      },
      {
        "image": "images/img_7.png",
        "title": "淘宝转卖",
        "subTitle": "淘宝宝贝一键转卖",
      },
      {
        "image": "images/img_7.png",
        "title": "省心卖",
        "subTitle": "平台帮卖免沟通 48小时必卖",
      },
      {
        "image": "images/img_7.png",
        "title": "发闲置",
        "subTitle": "30s发布宝贝",
      },
    ];

    List<Widget> list = [];
    data.forEach(
      (element) {
        list.add(
          InkWell(
            onTap: () {
              this.publishOverlayEntry.remove();
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(paddingLeft, 0, 0, 0),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Image.asset(
                    //"images/img_7.png",
                    element["image"],
                    width: 60,
                    height: 60,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(textPaddingLeft, 0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          element["title"],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          element["subTitle"],
                          style: TextStyle(
                            color: mPublishTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    list.add(
      Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: FlatButton(
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ), // 也可控件一边圆角大小
            ),
            child: Container(
              margin: EdgeInsets.all(10),
              child: Image.asset(
                "images/ic_publish_close@3x.png",
              ),
            ),
          ),
          onPressed: () {
            this.publishOverlayEntry.remove();
          },
        ),
      ),
    );
    return list;
  }
}
