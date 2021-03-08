import 'package:flutter/material.dart';
import 'package:flutter_xianyu/pages/fun/index.dart';
import 'package:flutter_xianyu/pages/main/index.dart';
import 'package:flutter_xianyu/pages/main/main_page.dart';
import './pages/fun/index.dart';
import './pages/message/index.dart';
import './pages/my/index.dart';
import './pages/publish/index.dart';
import 'package:lottie/lottie.dart';

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
      home: AppHome(),
      // home: FSHomePage(),
    );
  }
}

class AppHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppHomeState();
}

class AppHomeState extends State<AppHome> {
  int currentIndex = 0;
  Widget currentView;
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
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final iconImageSpace = 22.0;
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
            activeIcon: Image.asset(
              "images/ic_tabbar_home_sel@3x.png",
              width: iconImageSpace,
              height: iconImageSpace,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "images/ic_tabbar_niceplay_nor@3x.png",
              width: iconImageSpace,
              height: iconImageSpace,
            ),
            title: Text('会玩'),
            activeIcon: Image.asset(
              "images/ic_tabbar_niceplay_sel@3x.png",
              width: iconImageSpace,
              height: iconImageSpace,
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
            activeIcon: Image.asset(
              "images/ic_tabbar_message_sel@3x.png",
              width: iconImageSpace,
              height: iconImageSpace,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "images/ic_tabbar_mine_nor@3x.png",
              width: iconImageSpace,
              height: iconImageSpace,
            ),
            title: Text('我的'),
            activeIcon: Image.asset(
              "images/ic_tabbar_mine_sel@3x.png",
              width: iconImageSpace,
              height: iconImageSpace,
            ),
          ),
        ],
      ),
    );
  }
}
