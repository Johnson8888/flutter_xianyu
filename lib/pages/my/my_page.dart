/*
 * @Author: 弗拉德
 * @Date: 2020-12-17 20:32:59
 * @LastEditTime: 2021-02-16 22:24:45
 * @Support: http://fulade.me
 */

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../../header/loading_header.dart';
import '../../header/loading_footer.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController scrollController = ScrollController();
  final moreData = [
    {"image": "images/ic_setting.png", "title": "信息发布规范"},
    {"image": "images/ic_setting.png", "title": "会玩制作中心"},
    {"image": "images/ic_setting.png", "title": "我的贴子"},
    {"image": "images/ic_setting.png", "title": "我租到的"},
    {"image": "images/ic_setting.png", "title": "我的拍卖"},
    {"image": "images/ic_setting.png", "title": "我的租房"},
    {"image": "images/ic_setting.png", "title": "我的兼职"},
    {"image": "images/ic_setting.png", "title": "我的红包"},
    {"image": "images/ic_setting.png", "title": "安全中心"},
    {"image": "images/ic_setting.png", "title": "客服中心"},
    {"image": "images/ic_setting.png", "title": "认证招商"},
    {"image": "images/ic_setting.png", "title": "实人通行证"},
    {"image": "images/ic_setting.png", "title": "闲鱼公约"},
    {"image": "images/ic_setting.png", "title": "物流权益"},
    {"image": "images/ic_setting.png", "title": "参与的免费送"},
    {"image": "images/ic_setting.png", "title": "助卖宝卡"},
    {"image": "images/ic_setting.png", "title": "天天赚钱"},
    {"image": "images/ic_setting.png", "title": "闲鱼Family"},
    {"image": "images/ic_setting.png", "title": "鱼力行动"},
  ];
  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {});
    return Scaffold(
      /*appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      */
      body: EasyRefresh.custom(
        header: LoadingHeader(),
        footer: LoadingFooter(
          color: Color.fromRGBO(220, 220, 220, 1),
        ),
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2), () {
            if (mounted) {
              setState(() {});
            }
          });
        },
        onLoad: () async {
          await Future.delayed(Duration(seconds: 2), () {
            if (mounted) {
              setState(() {});
            }
          });
        },
        slivers: <Widget>[
          SliverAppBar(
            actions: [
              IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Image.asset("images/ic_navibar_setting.png"),
                onPressed: () {
                  print('pressed settting button');
                },
              ),
            ],
            centerTitle: true,
            title: const Text(
              '新德里的兰花',
              style: TextStyle(color: Colors.black),
            ),
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.white,
            expandedHeight: 120,
          ),
          SliverFixedExtentList(
            itemExtent: 50,
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[10 * (index % 9)],
                child: new Text('list item $index'),
              );
            }, childCount: 10),
          ),
          SliverPadding(
            padding: EdgeInsets.all(8),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.5),
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                /*return Container(
                  alignment: Alignment.center,
                  color: Colors.cyan[100 * (index % 9)],
                  child: new Text('grid item $index'),
                );
                */
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      moreData[index]["image"],
                      height: 30,
                      width: 30,
                    ),
                    Text(
                      moreData[index]["title"],
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                );
              }, childCount: 19),
            ),
          ),
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
