/*
 * @Author: 弗拉德
 * @Date: 2021-02-28 11:02:31
 * @LastEditTime: 2021-03-12 11:41:39
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "闲鱼无忧购",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "包真·包退·包邮",
                        style: TextStyle(color: Color(0xffd6bc77)),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 70,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Color(0xfffce2c5),
                                  shape: BoxShape.rectangle, // 默认值也是矩形
                                  borderRadius: BorderRadius.circular(
                                    (10.0),
                                  ),
                                ),
                                child: Text(
                                  "品牌好货",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "¥299",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "¥423",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                        decoration: TextDecoration.lineThrough),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 70,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Color(0xfffce2c5),
                                  shape: BoxShape.rectangle, // 默认值也是矩形
                                  borderRadius: BorderRadius.circular(
                                    (10.0),
                                  ), // 圆角度
                                ),
                                child: Text(
                                  "超值捡漏",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "¥299",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "¥423",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                        decoration: TextDecoration.lineThrough),
                                  )
                                ],
                              ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "省心卖",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "高价回收48小时必卖",
                        style: TextStyle(color: Color(0xffd46e4a)),
                      ),
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
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                            child: CircleAvatar(
                              radius: 10, // 头像的半径
                              backgroundImage:
                                  AssetImage('images/image_demo.jpg'),
                            ),
                          ),
                          Text(
                            "赚了¥3501",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
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
                      style: TextStyle(color: Colors.red, fontSize: 14),
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
