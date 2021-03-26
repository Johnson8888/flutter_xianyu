/*
 * @Author: 弗拉德
 * @Date: 2021-02-28 11:02:31
 * @LastEditTime: 2021-03-26 16:31:11
 * @Support: http://fulade.me
 */
// 推荐页面
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import './recommend_item_page.dart';
import 'dart:math';

class RecommendPage extends StatefulWidget {
  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  ///  赚了多少钱的key
  GlobalKey makeMoneyKey = GlobalKey();

  /// 赚了多少钱的 ScrollController
  ScrollController makeMoneyController;

  /// 赚了多少钱的 index
  int makeMoneyIndex = 0;

  /// 计时器

  Timer _timer;

  /// 计时器计数

  int _countdownTime = 0;

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
    _startCountdownTimer();

    WidgetsBinding widgetsBinding = WidgetsBinding.instance;
    widgetsBinding.addPostFrameCallback((callback) {
      Timer.periodic(new Duration(seconds: 5), (timer) {
        // makeMoneyIndex += makeMoneyKey.currentContext.size.height.toInt();
        makeMoneyController.animateTo((makeMoneyIndex).toDouble(),
            duration: new Duration(seconds: 2), curve: Curves.easeOutSine);
        //滚动到底部从头开始
        if ((makeMoneyIndex - makeMoneyKey.currentContext.size.height.toInt())
                .toDouble() >
            makeMoneyController.position.maxScrollExtent) {
          makeMoneyController
              .jumpTo(makeMoneyController.position.minScrollExtent);
          makeMoneyIndex = 0;
        }
      });
    });
    makeMoneyController = new ScrollController(initialScrollOffset: 0);
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
    makeMoneyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerIsScrolled) {
        return <Widget>[
          SliverToBoxAdapter(
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 175,
              margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
              padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
              decoration: BoxDecoration(
                color: Color(0xfffafafa),
                shape: BoxShape.rectangle, // 默认值也是矩形
                borderRadius: BorderRadius.circular(
                  (10.0),
                ),
              ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Container(
                                  child:
                                      Image.asset("images/image_trousers.png"),
                                  width: 30,
                                  height: 60,
                                ),
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
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "¥299",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(2, 0, 0, 0),
                                        child: Text(
                                          "¥423",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: Color(0xffbababa),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  child: Image.asset("images/image_phone1.png"),
                                  width: 30,
                                  height: 60,
                                ),
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
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "¥299",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(2, 0, 0, 0),
                                        child: Text(
                                          "¥423",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: Color(0xffbababa),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
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
                    flex: 2,
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
                          style: TextStyle(
                            color: Color(0xffd46e4a),
                          ),
                        ),
                        Container(
                          height: 60,
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 15),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "✓ 免费上门",
                                    style: TextStyle(
                                      color: Color(0xffbababa),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "✓ 免沟通",
                                    style: TextStyle(
                                      color: Color(0xffbababa),
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: Image.asset(
                                  "images/image_phone2.png",
                                  width: 50,
                                  height: 50,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 90,
                          height: 21,
                          child: ListView.builder(
                            key: makeMoneyKey,
                            //禁止手动滑动
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 150,
                            //item固定高度
                            itemExtent: 21,
                            scrollDirection: Axis.vertical,
                            controller: makeMoneyController,
                            itemBuilder: (context, index) {
                              return Container(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                      child: CircleAvatar(
                                        radius: 10, // 头像的半径
                                        backgroundImage:
                                            AssetImage('images/image_demo.jpg'),
                                      ),
                                    ),
                                    Text(
                                      "赚了¥" + Random().nextInt(1000).toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffbababa),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        /*
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
                                color: Color(0xffbababa),
                              ),
                            ),
                          ],
                        ),
                        */
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  "热门活动",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Color(0xffababab),
                  ),
                ),
                width: 100,
              ),
              /*child: FlatButton(
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
              */
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 70,
              child: ScrollablePositionedList.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 500,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Color(0xfffafafa),
                      // color: Colors.red,
                      borderRadius: BorderRadius.circular(
                        (5.0),
                      ),
                    ),
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    width: 220,
                    height: 60,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 55,
                          height: 55,
                          margin: EdgeInsets.fromLTRB(10, 5, 5, 5),
                          child: Image.asset(
                            "images/image_switch.jpeg",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 140,
                                child: Text(
                                  "Switch抢不停 健身环大冒险10元抽",
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "去抽奖 >",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Color(0xffbababa),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
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
              backgroundColor: Colors.white,
              title: TabBar(
                controller: tabController,
                indicatorColor: Colors.white,
                indicatorWeight: 1,
                indicatorPadding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                labelColor: Colors.black,
                unselectedLabelColor: Color(0xffbababa),
                unselectedLabelStyle: TextStyle(
                  fontSize: 16,
                ),
                labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                tabs: menuList.map((String name) {
                  return Text(
                    name,
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

  ///
  void _startCountdownTimer() {
    return;
    const oneSec = const Duration(seconds: 2);
    var callback = (timer) {
      _countdownTime = _countdownTime + 1;
      final list = itemPositionsListener.itemPositions.value.where((element) {
        return element.itemLeadingEdge >= 0 && element.itemTrailingEdge <= 1;
      });
      // var toIndex = list.first.index;
      // if (list.length > 1) {
      //   toIndex = list[1].index;
      // }
      itemScrollController.scrollTo(
        index: _countdownTime,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
      // print("_startCountdownTimer = " + _startCountdownTimer.toString());
    };
    _timer = Timer.periodic(oneSec, callback);
  }
}
