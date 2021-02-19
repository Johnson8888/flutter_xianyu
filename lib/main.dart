import 'package:flutter/material.dart';
import 'package:flutter_xianyu/pages/fun/index.dart';
import 'package:flutter_xianyu/pages/main/main_page.dart';
import './pages/fun/index.dart';
import './pages/message/index.dart';
import './pages/my/index.dart';
import './pages/publish/index.dart';

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
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AppHome(),
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
    return Scaffold(
        body: pageMap[this.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          onTap: (event) {
            this.setState(() {
              this.currentIndex = event;
            });
          },
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('闲鱼'),
              activeIcon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.apps),
              title: Text('会玩'),
              activeIcon: Icon(Icons.view_quilt),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.near_me),
              title: Text(''),
              activeIcon: Icon(Icons.navigation),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text('消息'),
              activeIcon: Icon(Icons.shopping_cart),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('我的'),
              activeIcon: Icon(Icons.face),
            ),
          ],
        ));
  }
}
