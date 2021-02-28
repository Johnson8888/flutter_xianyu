/*
 * @Author: 弗拉德
 * @Date: 2021-02-28 11:02:08
 * @LastEditTime: 2021-02-28 15:53:25
 * @Support: http://fulade.me
 */
// 城市页面
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CityPage extends StatefulWidget {
  @override
  _CityPageState createState() => _CityPageState();
}

class _CityPageState extends State<CityPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController; //需要定义一个Controller
  List<String> tabs = ["精选", "附近兼职", "二手车", "代步工具", "手机数码", "家具家电", "同城萌宠"];
  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() => _onTabChanged());
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _getRow1List(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _getRow2List(),
              )
            ],
          ),
        ),
        Container(
          height: 120,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Image.asset(
            "images/image_demo.jpg",
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          height: 30,
          child: TabBar(
            isScrollable: true,
            controller: _tabController,
            tabs: tabs
                .map(
                  (e) => Tab(
                    child: Container(
                      child: Text(
                        e,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12.0),
                      ),
                      width: 50,
                    ),
                  ),
                )
                .toList(),
            labelColor: Colors.red,
          ),
        ),
        StaggeredGridView.countBuilder(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          crossAxisCount: 4,
          shrinkWrap: true,
          primary: false,
          itemCount: 28,
          itemBuilder: (BuildContext context, int index) => new Container(
              color: Colors.green,
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text('$index'),
                ),
              )),
          staggeredTileBuilder: (int index) =>
              StaggeredTile.count(2, index.isEven ? 2 : 1),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        )
      ],
    );
  }

  /// tab 点击事件
  void _onTabChanged() {
    print("tapped " + _tabController.index.toString());
  }

  // 获取第一行的菜单数据
  List<Widget> _getRow1List() {
    List data = [
      {
        "iconPath": "images/image_demo.jpg",
        "title": "闲时兼职",
      },
      {
        "iconPath": "images/image_demo.jpg",
        "title": "附近回收",
      },
      {
        "iconPath": "images/image_demo.jpg",
        "title": "到家服务",
      },
      {
        "iconPath": "images/image_demo.jpg",
        "title": "同城跑腿",
      },
      {
        "iconPath": "images/image_demo.jpg",
        "title": "好房出租",
      },
    ];
    List<Widget> list = [];
    data.forEach(
      (element) {
        list.add(Column(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundImage: AssetImage(element["iconPath"]),
            ),
            Text(
              element["title"],
              style: TextStyle(fontSize: 11.0),
            ),
          ],
        ));
      },
    );
    return list;
  }

  // 获取第二行的菜单数据

  List<Widget> _getRow2List() {
    List data = [
      {
        "iconPath": "images/image_demo.jpg",
        "title": "闲时兼职",
      },
      {
        "iconPath": "images/image_demo.jpg",
        "title": "附近回收",
      },
      {
        "iconPath": "images/image_demo.jpg",
        "title": "到家服务",
      },
      {
        "iconPath": "images/image_demo.jpg",
        "title": "同城跑腿",
      },
      {
        "iconPath": "images/image_demo.jpg",
        "title": "好房出租",
      },
    ];
    List<Widget> list = [];
    data.forEach(
      (element) {
        list.add(Column(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundImage: AssetImage(element["iconPath"]),
            ),
            Text(
              element["title"],
              style: TextStyle(fontSize: 11.0),
            ),
          ],
        ));
      },
    );
    return list;
  }
}
