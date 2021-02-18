/*
 * @Author: 弗拉德
 * @Date: 2020-12-17 20:32:59
 * @LastEditTime: 2021-02-18 16:01:36
 * @Support: http://fulade.me
 */

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../../header/loading_header.dart';
import '../../header/loading_footer.dart';
import 'account_card.dart';
import 'account_deal.dart';
import 'account_header.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController scrollController = ScrollController();

  double appBarOpacity = 0.0;
  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {});
    return Scaffold(
      body: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              print(notification.metrics.pixels);
              print(notification.context);
              var scrollY = notification.metrics.pixels;
              if (scrollY > 0) {
                var opacity = scrollY / 80;
                setState(() {
                  appBarOpacity = opacity <= 1 ? opacity : 1;
                });
              } else if (scrollY < 0) {
                setState(() {
                  appBarOpacity = 0;
                });
              }
              return false;
            },
            child: EasyRefresh(
              header: LoadingHeader(),
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 2), () {
                  if (mounted) {}
                });
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AccountHeader(),
                    AccountDealCard(),
                    AccountCard(
                      title: "更多",
                    ),
                  ],
                ),
              ),
            ),
          ),

          /*
          Positioned(
            top: 0,
            left: 0,
            width: MediaQuery.of(context).size.width,
            child: AppBar(
              title: Text(
                appBarOpacity >= 0.7 ? "我的" : "",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              centerTitle: true,
              leading: appBarOpacity >= 0.7
                  ? Container(
                      padding: EdgeInsets.all(12),
                      child: ClipOval(
                        child: Image.network(
                          "https://storage.360buyimg.com/i.imageUpload/494dccc6eedad0a1b1a631353834363036343330373230_big.jpg",
                        ),
                      ),
                    )
                  : Container(),
              actions: <Widget>[
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "设置",
                      style: TextStyle(
                        color: appBarOpacity == 1 ? Colors.black : Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed('/settings');
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: appBarOpacity == 1 ? Colors.black : Colors.white,
                    size: 20,
                  ),
                  onPressed: null,
                )
              ],
              backgroundColor: Color.fromRGBO(255, 255, 255, appBarOpacity),
              elevation: 0,
            ),
          ),
          */
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        /// 这个很重要
        type: BottomNavigationBarType.fixed,
        currentIndex: 4,
        onTap: (index) {
          setState(() {});
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('闲鱼'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('会玩'),
            icon: Icon(Icons.book),
          ),
          BottomNavigationBarItem(
            title: Text('我的'),
            icon: Icon(Icons.perm_identity),
          ),
          BottomNavigationBarItem(
            title: Text('消息'),
            icon: Icon(Icons.school),
          ),
          BottomNavigationBarItem(
            title: Text('我的'),
            icon: Icon(Icons.perm_identity),
          ),
        ],
      ),
    );
  }
}
