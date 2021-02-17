/*
 * @Author: 弗拉德
 * @Date: 2020-12-17 20:32:59
 * @LastEditTime: 2021-02-17 21:39:10
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
    {
      "image":
          "https://gw.alicdn.com/bao/uploaded/TB1ZXYnPmzqK1RjSZFLXXcn2XXa-96-96.png",
      "title": "信息发布规范"
    },
    {
      "image":
          "https://gw.alicdn.com/bao/uploaded/TB1QHzqPlLoK1RjSZFuXXXn0XXa-96-96.png",
      "title": "会玩制作中心"
    },
    {
      "image": "http://gw.alicdn.com/mt/TB1DSUQg4D1gK0jSZFKXXcJrVXa-96-96.png",
      "title": "我的贴子"
    },
    {
      "image":
          "https://gw.alicdn.com/bao/uploaded/TB1ZXYnPmzqK1RjSZFLXXcn2XXa-96-96.png",
      "title": "我租到的"
    },
    {
      "image":
          "https://gw.alicdn.com/tfs/TB1IbofANnaK1RjSZFtXXbC2VXa-144-144.png",
      "title": "我的拍卖"
    },
    {
      "image":
          "https://gw.alicdn.com/bao/uploaded/TB1iorjPgTqK1RjSZPhXXXfOFXa-96-96.png",
      "title": "我的租房"
    },
    {
      "image":
          "https://gw.alicdn.com/bao/uploaded/TB1ZXYnPmzqK1RjSZFLXXcn2XXa-96-96.png",
      "title": "我的兼职"
    },
    {
      "image":
          "https://gw.alicdn.com/bao/uploaded/TB1t_DsPXYqK1RjSZLeXXbXppXa-96-96.png",
      "title": "我的红包"
    },
    {
      "image": "http://gw.alicdn.com/mt/TB1FgvjPmrqK1RjSZK9XXXyypXa-96-96.png",
      "title": "安全中心"
    },
    {
      "image":
          "https://gw.alicdn.com/bao/uploaded/TB1QHzqPlLoK1RjSZFuXXXn0XXa-96-96.png",
      "title": "客服中心"
    },
    {
      "image": "http://gw.alicdn.com/mt/TB1ELKidNn1gK0jSZKPXXXvUXXa-96-96.png",
      "title": "认证招商"
    },
    {
      "image":
          "https://gw.alicdn.com/bao/uploaded/TB1rKTkPjDpK1RjSZFrXXa78VXa-96-96.png",
      "title": "实人通行证"
    },
    {
      "image": "http://gw.alicdn.com/mt/TB16mbFh_Zmx1VjSZFGXXax2XXa-96-96.png",
      "title": "闲鱼公约"
    },
    {
      "image": "http://gw.alicdn.com/mt/TB1DSUQg4D1gK0jSZFKXXcJrVXa-96-96.png",
      "title": "物流权益"
    },
    {
      "image":
          "https://gw.alicdn.com/tfs/TB1uuSocUz1gK0jSZLeXXb9kVXa-96-96.png",
      "title": "参与的免费送"
    },
    {
      "image": "http://gw.alicdn.com/mt/TB13_lIdLb2gK0jSZK9XXaEgFXa-96-96.png",
      "title": "助卖宝卡"
    },
    {
      "image": "http://gw.alicdn.com/mt/TB17USrdkL0gK0jSZFtXXXQCXXa-96-96.png",
      "title": "天天赚钱"
    },
    {
      "image": "http://gw.alicdn.com/mt/TB1MzzIbQP2gK0jSZPxXXacQpXa-96-96.png",
      "title": "闲鱼Family"
    },
    {
      "image":
          "https://gw.alicdn.com/bao/uploaded/TB1rKTkPjDpK1RjSZFrXXa78VXa-96-96.png",
      "title": "鱼力行动"
    },
  ];
  get dataList => _getExtentData();
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
          enableInfiniteLoad: false,
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
            floating: false,
            elevation: 0,
            backgroundColor: Colors.white,
            expandedHeight: 120,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 50.0, minHeight: 50.0),
                child: Center(child: Text('Child 1')),
              ),
              SizedBox(
                height: 200.0,
                child: Container(
                    color: Colors.green, child: Center(child: Text("Page 1"))),
              ),
            ]),
          ),
          SliverFixedExtentList(
            itemExtent: 60,
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[10 * (index % 9)],
                child: new Text('list item $index'),
              );
            }, childCount: 10),
          ),
          SliverFixedExtentList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "更多",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }, childCount: 1),
              itemExtent: 30),
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
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

  /// 获取列表list
  List<Map<String, dynamic>> _getExtentData() {
    return [
      {"itemExtent": 60, "widget": Row()},
      {
        "itemExtent": 60,
        "widget": Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("17"),
                Text("收藏"),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("17"),
                Text("收藏"),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("17"),
                Text("收藏"),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("17"),
                Text("收藏"),
              ],
            ),
          ],
        )
      },
      {
        "itemExtent": 60,
        "widget": Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text("我的交易"),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Text("在闲鱼赚了3095元"),
              ),
            )
          ],
        )
      },
      {
        "itemExtent": 60,
        "widget": Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text("我的交易"),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Text("在闲鱼赚了3095元"),
              ),
            )
          ],
        )
      },
      {
        "itemExtent": 60,
        "widget": Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text("我的交易"),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Text("在闲鱼赚了3095元"),
              ),
            )
          ],
        )
      },
      {
        "itemExtent": 60,
        "widget": Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text("我的交易"),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Text("在闲鱼赚了3095元"),
              ),
            )
          ],
        )
      },
    ];
  }
}
