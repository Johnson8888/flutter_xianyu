/*
 * @Author: 弗拉德
 * @Date: 2021-02-02 18:05:57
 * @LastEditTime: 2021-03-03 16:11:01
 * @Support: http://fulade.me
 */
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'dart:math' as math;
import 'dart:async';
import './city_page.dart';
import './attention_page.dart';
import './recommend_page.dart';
import './test_page.dart';
import 'package:flutter_xianyu/home/fsHomePage.dart';

List<Widget> tabList;
TabController _tabController;

class MainPageTabBar extends StatefulWidget {
  MainPageTabBar({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MainPageTabBarState();
  }
}

class _MainPageTabBarState extends State<MainPageTabBar> {
  Color selectColor, unselectedColor;
  TextStyle selectStyle, unselectedStyle;

  @override
  void initState() {
    super.initState();
    selectColor = Colors.black;
    unselectedColor = Color.fromARGB(255, 117, 117, 117);
    selectStyle = TextStyle(fontSize: 18, color: selectColor);
    unselectedStyle = TextStyle(fontSize: 18, color: selectColor);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      alignment: Alignment.center,
      child: Column(
        children: [
          TabBar(
            tabs: tabList,
            isScrollable: true,
            controller: _tabController,
            indicatorColor: selectColor,
            labelColor: selectColor,
            labelStyle: selectStyle,
            unselectedLabelColor: unselectedColor,
            unselectedLabelStyle: unselectedStyle,
            indicatorSize: TabBarIndicatorSize.label,
          ),
          Container(
            height: 120,
            padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
            child: Text("Search Bar"),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max((minHeight ?? kToolbarHeight), minExtent);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class FlutterTabBarView extends StatelessWidget {
  final TabController tabController;

  FlutterTabBarView({Key key, @required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewList = [
      AttentionPage(),
      // XBTestPage(),
      RecommendPage(),
      // FSHomePage(),
      CityPage(),
    ];
    return TabBarView(
      children: viewList,
      controller: tabController,
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 4,
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
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  var tabBar;

  @override
  Future<void> initState() {
    super.initState();
    tabBar = MainPageTabBar();
    tabList = getTabList();
    _tabController = TabController(vsync: this, length: tabList.length);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: _getNestedScrollView(tabBar),
        ),
      ),
    );
  }

  List<Widget> getTabList() {
    return ["关注", "推荐", "北京"]
        .map(
          (item) => Text(
            '$item',
            style: TextStyle(fontSize: 15),
          ),
        )
        .toList();
  }

  Widget _getNestedScrollView(Widget tabBar) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverPersistentHeader(
            floating: true,
            pinned: true,
            delegate: _SliverAppBarDelegate(
              maxHeight: 88.0,
              minHeight: 88.0,
              child: Container(
                color: Colors.white,
                child: tabBar,
              ),
            ),
          ),
        ];
      },
      body: FlutterTabBarView(
        tabController: _tabController,
      ),
    );
  }
}
