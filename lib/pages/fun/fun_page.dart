/*
 * @Author: 弗拉德
 * @Date: 2021-02-02 18:05:57
 * @LastEditTime: 2021-03-22 20:35:08
 * @Support: http://fulade.me
 */
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import './fun_item_page.dart';
import 'dart:math' as math;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';
import 'fun_item_model.dart';

var titleList = [
  '推荐',
  '潮玩',
  '三坑',
  '旅行',
  '手作',
  '运动',
  '萌宠',
  '数码',
  '植物',
  '复古',
  '美食'
];
List<Widget> tabList;
TabController _tabController;

class FunPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FunPageState();
  }
}

class _FunPageState extends State<FunPage> with SingleTickerProviderStateMixin {
  var tabBar;

  @override
  Future<void> initState() {
    super.initState();
    tabBar = HomePageTabBar();
    tabList = getTabList();
    _tabController = TabController(vsync: this, length: tabList.length);
  }

  List<Widget> getTabList() {
    return titleList
        .map(
          (item) => Text(
            '$item',
            style: TextStyle(fontSize: 15),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: DefaultTabController(
          length: titleList.length,
          child: _getNestedScrollView(tabBar),
        ),
      ),
    );
  }
}

Widget _getNestedScrollView(Widget tabBar) {
  return NestedScrollView(
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        SliverToBoxAdapter(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Container(
                  width: 30,
                  height: 30,
                  child: Image.asset("images/fishpond_search@2x.png"),
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "会玩",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Container(
                  width: 70,
                  height: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFFababab),
                      width: 1.0,
                    ), // 边色与边宽度
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "发帖子",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
        SliverPersistentHeader(
          floating: true,
          pinned: true,
          delegate: _SliverAppBarDelegate(
            maxHeight: 49.0,
            minHeight: 49.0,
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

class HomePageTabBar extends StatefulWidget {
  HomePageTabBar({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageTabBarState();
  }
}

class _HomePageTabBarState extends State<HomePageTabBar> {
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
    /*
    Tab小部件列表
   List<Widget>  @required this.tabs,
    组件选中以及动画的状态
  TabController this.controller,
    Tab是否可滑动(false->整个tab会把宽度填满，true-> tab包裹)
 bool  this.isScrollable = false,
    选项卡下方的导航条的颜色
  Color this.indicatorColor,
    选项卡下方的导航条的线条粗细
  double this.indicatorWeight = 2.0,
 EdgeInsetsGeometry  this.indicatorPadding = EdgeInsets.zero,
  Decoration this.indicator,
  TabBarIndicatorSize this.indicatorSize,导航条的长度，（tab：默认等分；label：跟标签长度一致）
 Color  this.labelColor,所选标签标签的颜色
 TextStyle  this.labelStyle,所选标签标签的文本样式
 EdgeInsetsGeometry  this.labelPadding,,所选标签标签的内边距
Color   this.unselectedLabelColor,未选定标签标签的颜色
 TextStyle  this.unselectedLabelStyle,未选中标签标签的文字样式
  void Function(T value) this.onTap,按下时的响应事件
  */
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: TabBar(
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
    );
  }
}

class FlutterTabBarView extends StatelessWidget {
  final TabController tabController;

  FlutterTabBarView({Key key, @required this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewList = [
      FunItemPage(),
      FunItemPage(),
      FunItemPage(),
      FunItemPage(),
      FunItemPage(),
      FunItemPage(),
      FunItemPage(),
      FunItemPage(),
      FunItemPage(),
      FunItemPage(),
      FunItemPage(),
    ];
    return TabBarView(
      children: viewList,
      controller: tabController,
    );
  }
}

class SearchTextFieldWidget extends StatelessWidget {
  final ValueChanged<String> onSubmitted;
  final VoidCallback onTab;
  final String hintText;
  final EdgeInsetsGeometry margin;

  SearchTextFieldWidget(
      {Key key, this.hintText, this.onSubmitted, this.onTab, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin == null ? EdgeInsets.all(0.0) : margin,
      width: MediaQuery.of(context).size.width,
      alignment: AlignmentDirectional.center,
      height: 37.0,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 237, 236, 237),
          borderRadius: BorderRadius.circular(24.0)),
      child: TextField(
        onSubmitted: onSubmitted,
        onTap: onTab,
        cursorColor: Color.fromARGB(255, 0, 189, 96),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 8.0),
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
                fontSize: 17, color: Color.fromARGB(255, 192, 191, 191)),
            prefixIcon: Icon(
              Icons.search,
              size: 25,
              color: Color.fromARGB(255, 128, 128, 128),
            )),
        style: TextStyle(fontSize: 17),
      ),
    );
  }

  getContainer(BuildContext context, ValueChanged<String> onSubmitted) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: AlignmentDirectional.center,
      height: 40.0,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 237, 236, 237),
          borderRadius: BorderRadius.circular(24.0)),
      child: TextField(
        onSubmitted: onSubmitted,
        cursorColor: Color.fromARGB(255, 0, 189, 96),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 20),
            prefixIcon: Icon(
              Icons.search,
              size: 29,
              color: Color.fromARGB(255, 128, 128, 128),
            )),
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
