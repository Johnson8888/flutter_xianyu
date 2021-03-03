import 'package:flutter/material.dart';

import 'List/fsHomeGoodGrid.dart';

class FSHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FSHomePageState();
  }
}

class _FSHomePageState extends State<FSHomePage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  List<String> _list = [
    "关注",
    "新鲜",
    "手机",
    "电脑",
    "数码",
    "租房",
    "服装",
    "家具",
  ];

  TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print("Init Home page");

    _tabController = TabController(length: _list.length, vsync: this);
    _tabController.addListener(() {
      var index = _tabController.index;
      var previewIndex = _tabController.previousIndex;
      print('index:$index, preview:$previewIndex');
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NestedScrollView(
      headerSliverBuilder: ((BuildContext context, bool innerIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              pinned: true,
              titleSpacing: 0,
              forceElevated: false,
              automaticallyImplyLeading: false,
              backgroundColor:
                  innerIsScrolled ? Colors.white : Colors.grey[100],
              title: TabBar(
                controller: _tabController,
                indicatorColor: Colors.red,
                indicatorWeight: 3,
                indicatorPadding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                unselectedLabelStyle:
                    TextStyle(color: Colors.red, fontSize: 16),
                labelStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                tabs: _list.map((String name) {
                  return Tab(
                    child: Text(
                      name,
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ];
      }),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: _list.map((String name) {
          return FHHomeGoodGrid(
            categoryType: name,
          );
        }).toList(),
      ),
    );
  }

  Future<void> fetchData() async {
    return null;
  }
}
