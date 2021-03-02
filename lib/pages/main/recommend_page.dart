/*
 * @Author: 弗拉德
 * @Date: 2021-02-28 11:02:31
 * @LastEditTime: 2021-03-02 08:59:11
 * @Support: http://fulade.me
 */
// 推荐页面

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class _StickyHeaderList extends StatelessWidget {
  const _StickyHeaderList({
    Key key,
    this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: Text("header"),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) => ListTile(
            leading: CircleAvatar(
              child: Text('$index'),
            ),
            title: Text('List tile #$i'),
          ),
          childCount: 6,
        ),
      ),
    );
  }
}

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.blue,
      alignment: Alignment.center,
      child: Text(
        '我是一个SliverPersistentHeader',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  double get maxExtent => 250.0;
  @override
  double get minExtent => 240.0;
  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) =>
      false; // 如果内容需要更新，设置为true
}

class RecommendPage extends StatefulWidget {
  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: FlatButton(
              onPressed: () {
                var list =
                    itemPositionsListener.itemPositions.value.where((element) {
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
        SliverPersistentHeader(
          pinned: true,
          delegate: MySliverPersistentHeaderDelegate(),
        ),
        SliverToBoxAdapter(
          child: StaggeredGridView.countBuilder(
            shrinkWrap: true,
            primary: false,
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
          ),
        ),
      ],
    );
    /*
    return ListView(
      children: [
        Row(
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
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: FlatButton(
            onPressed: () {
              var list =
                  itemPositionsListener.itemPositions.value.where((element) {
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
        Container(
          height: 100,
          child: ScrollablePositionedList.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 500,
            itemBuilder: (context, index) => Text('Item $index'),
            itemScrollController: itemScrollController,
            itemPositionsListener: itemPositionsListener,
          ),
        ),
        StaggeredGridView.countBuilder(
          shrinkWrap: true,
          primary: false,
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
        ),
      ],
    );
      */
  }
}
