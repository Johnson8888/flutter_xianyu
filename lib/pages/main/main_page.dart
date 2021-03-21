/*
 * @Author: 弗拉德
 * @Date: 2021-02-02 18:05:57
 * @LastEditTime: 2021-03-18 20:31:57
 * @Support: http://fulade.me
 */
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'dart:math' as math;
import 'dart:async';
import './city_page.dart';
import './attention_page.dart';
import './recommend_page.dart';
import './test_page.dart';

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

  ///  searchBar的key
  GlobalKey searchBarKey = GlobalKey();

  /// searchBar的 ScrollController
  ScrollController searchController;

  /// searchBar的 index
  int serachIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding widgetsBinding = WidgetsBinding.instance;

    widgetsBinding.addPostFrameCallback((callback) {
      Timer.periodic(new Duration(seconds: 3), (timer) {
        serachIndex += searchBarKey.currentContext.size.height.toInt();
        searchController.animateTo((serachIndex).toDouble(),
            duration: new Duration(seconds: 2), curve: Curves.easeOutSine);
        //滚动到底部从头开始
        if ((serachIndex - searchBarKey.currentContext.size.height.toInt())
                .toDouble() >
            searchController.position.maxScrollExtent) {
          searchController.jumpTo(searchController.position.minScrollExtent);
          serachIndex = 0;
        }
      });
    });
    searchController = new ScrollController(initialScrollOffset: 0);
  }

  @override
  void dispose() {
    _tabController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
      alignment: Alignment.center,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                // margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Image.asset(
                  "images/HomeSignIn@3x.png",
                  width: 35,
                  height: 35,
                ),
              ),
              TabBar(
                tabs: tabList,
                isScrollable: true,
                controller: _tabController,
                indicatorColor: selectColor,
                labelColor: Colors.black,
                labelStyle: TextStyle(fontSize: 18, color: selectColor),
                unselectedLabelColor: Color.fromARGB(255, 117, 117, 117),
                unselectedLabelStyle:
                    TextStyle(fontSize: 18, color: selectColor),
                indicatorSize: TabBarIndicatorSize.tab,
                // indicator: ShapeDecoration(
                //   shape: Border.all(
                //       color: Color(0xFF00FFFF), style: BorderStyle.solid, width: 2),
                // ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: InkWell(
                  onTap: () async {
                    String cameraScanResult = await scanner.scan();
                    print("scan result = " + cameraScanResult);
                  },
                  child: Image.asset(
                    "images/home_bar_scan@3x.png",
                    width: 25,
                    height: 25,
                  ),
                ),
              )
            ],
          ),
          Container(
            // margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            color: Colors.red,
            height: 45,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 60,
                  height: 45,
                  color: Colors.blue,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Color(0xfff4d95a),
                        width: 2.0,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 180,
                              height: 21,
                              child: ListView.builder(
                                key: searchBarKey,
                                //禁止手动滑动
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 150,
                                //item固定高度
                                itemExtent: 21,
                                scrollDirection: Axis.vertical,
                                controller: searchController,
                                itemBuilder: (context, index) {
                                  return Container(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(10, 0, 0, 0),
                                          child: Image.asset(
                                            "images/ic_home_search@3x.png",
                                            width: 25,
                                            height: 25,
                                          ),
                                        ),
                                        Text(
                                          "11苹果手机壳",
                                          style: TextStyle(
                                            color: Color(0xffababab),
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xfff4d95a),
                          ),
                          alignment: Alignment.center,
                          width: 60,
                          height: 42,
                          child: Text("搜索"),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 40,
                  height: 45,
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          "ALL",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "分类",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
      //TestPage(),
      RecommendPage(),
      AttentionPage(),
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
        ),
      ),
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
