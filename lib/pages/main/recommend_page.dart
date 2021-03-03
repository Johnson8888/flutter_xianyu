/*
 * @Author: 弗拉德
 * @Date: 2021-02-28 11:02:31
 * @LastEditTime: 2021-03-03 16:28:37
 * @Support: http://fulade.me
 */
// 推荐页面
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import './recommend_item_page.dart';

class RecommendPage extends StatefulWidget {
  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  /// TabController
  TabController tabController;
  List<String> menuList = [
    "关注",
    "新鲜",
    "手机",
    "电脑",
    "数码",
    "租房",
    "服装",
    "家具",
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    tabController = TabController(length: menuList.length, vsync: this);
    tabController.addListener(() {
      var index = tabController.index;
      var previewIndex = tabController.previousIndex;
      print('index:$index, preview:$previewIndex');
    });
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerIsScrolled) {
        return <Widget>[
          SliverToBoxAdapter(
            child: Row(
              children: [
                Flexible(
                  child: Column(
                    children: [
                      Text("闲鱼无忧购"),
                      Text("包真·包退·包邮"),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text("品牌好货"),
                              Text("299"),
                            ],
                          ),
                          Column(
                            children: [
                              Text("品牌好货"),
                              Text("299"),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  flex: 2,
                ),
                Flexible(
                  child: Column(
                    children: [
                      Text("省心卖"),
                      Text("高价回收48小时必卖"),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text("免费上门"),
                              Text("免沟通"),
                            ],
                          ),
                          Image.asset(
                            "images/image_demo.jpg",
                            width: 30,
                            height: 30,
                          ),
                        ],
                      ),
                      Text("赚了100")
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: FlatButton(
                onPressed: () {
                  var list = itemPositionsListener.itemPositions.value
                      .where((element) {
                    return element.itemLeadingEdge >= 0 &&
                        element.itemTrailingEdge <= 1;
                  });
                  itemScrollController.scrollTo(
                      index: 0,
                      duration: Duration(seconds: 1),
                      curve: Curves.easeInOutCubic);
                },
                child: Text("热门活动"),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 30,
              child: ScrollablePositionedList.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 500,
                itemBuilder: (context, index) => Text('Item $index'),
                itemScrollController: itemScrollController,
                itemPositionsListener: itemPositionsListener,
              ),
            ),
          ),
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
                controller: tabController,
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
                tabs: menuList.map((String name) {
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
      },
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: menuList.map((String name) {
          return RecommendItemPage(
            categoryType: name,
          );
        }).toList(),
      ),
    );
  }
}
