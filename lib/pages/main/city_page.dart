/*
 * @Author: 弗拉德
 * @Date: 2021-02-28 11:02:08
 * @LastEditTime: 2021-03-17 22:35:29
 * @Support: http://fulade.me
 */
// 城市页面
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

import './model/attention_item_model.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import '../../common/api.dart';

enum LoadingState {
  nona,
  loading,
  noMore,
}

class CityPage extends StatefulWidget {
  @override
  _CityPageState createState() => _CityPageState();
}

class _CityPageState extends State<CityPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController; //需要定义一个Controller
  List<Map<String, dynamic>> tabs = [
    {"width": 15, "title": "精选"},
    {"width": 50, "title": "附近兼职"},
    {"width": 40, "title": "二手车"},
    {"width": 40, "title": "代步工具"},
    {"width": 40, "title": "手机数码"},
    {"width": 40, "title": "家具家电"},
    {"width": 40, "title": "同城萌宠"}
  ];
  int page = 0;
  LoadingState loadingState = LoadingState.nona;
  bool isPerformingRequest = false;
  List<CommonGood> dataList = [];
  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() => _onTabChanged());
    fetchMoreData();
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
            "images/city_banner.jpg",
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
                  (element) => Tab(
                    child: Container(
                      child: Text(
                        element["title"],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10.0),
                      ),
                      width: element["width"].toDouble(),
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

  Widget _buildItemWithModel(CommonGood model) {
    return Column(
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  child: CachedNetworkImage(
                    // height: 190,
                    width: MediaQuery.of(context).size.width * 0.5 - 15,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    imageUrl: PIC_URL_PREFIX + model.infoCoverList.first.picUrl,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Text(
                  model.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Text(
                      "¥" + ((model.infoPrice / 100).toInt()).toString(),
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Text(
                      "8人想要",
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Color(0xffaaaaaa),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.5),
                          child: Container(
                            child: CachedNetworkImage(
                              width: 25,
                              height: 25,
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              imageUrl: model.userPhoto,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          width: 60,
                          child: Text(
                            model.userName,
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Color(0xffaaaaaa),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                      width: 85,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color(0xfffbababa),
                          width: 1.0,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            "images/ic_zhima_tag@2x.png",
                            width: 10,
                            height: 10,
                          ),
                          Text(
                            "芝麻信用极好",
                            style: TextStyle(
                                fontSize: 10.0, color: Color(0xff31cdca)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget buildLoadingWidget() {
    Widget tipWidget;

    if (loadingState == LoadingState.loading) {
      tipWidget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(),
          ),
          SizedBox(
            width: 20,
          ),
          Text("加载数据中...")
        ],
      );
    }

    if (loadingState == LoadingState.noMore) {
      tipWidget = Text("暂时没有更多数据...");
    }

    return SliverToBoxAdapter(
        child: Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: 30),
        child: tipWidget,
      ),
    ));
  }

  Widget noMoreData() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 18, bottom: 30),
          child: Text(
            "no more data",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Future<void> fetchMoreData() async {
    if (loadingState != LoadingState.loading) {
      setState(() {
        loadingState = LoadingState.loading;
      });

      // if (videoPlayerMap.length > 0) {
      //   videoPlayerMap.clear();
      // }

      String filePath = "assets/attention$page.json";
      print(filePath);
      String jsonString =
          await rootBundle.loadString("assets/attention$page.json");
      final jsonResult = json.decode(jsonString);
      //遍历List，并且转成Anchor对象放到另一个List中
      List<CommonGood> data = List();
      for (Map<String, dynamic> map in jsonResult["respData"]["infoData"]) {
        Map<String, dynamic> commonGood = map["commonGoods"];
        CommonGood item = CommonGood.fromJson(commonGood);
        data.add(item);
        /*
        if (item.video != null &&
            item.video.videoUrl != null &&
            item.video.videoUrl.length > 0) {
          final videoPlayer = VideoPlayerController.network(item.video.videoUrl)
            ..addListener(() {});
          Future<void> initializeVideoPlayerFuture = videoPlayer.initialize();
          videoPlayer.setLooping(true);
          videoPlayerMap[item.infoId] = {
            "v": videoPlayer,
            "i": initializeVideoPlayerFuture
          };
          print("add infoId " + item.infoId);
        }
        */
      }

      Future.delayed(Duration(seconds: 2), () {
        // print("goods " + goods.toString());
        setState(() {
          dataList.addAll(data);
          print(dataList);
          loadingState = LoadingState.nona;
          page++;
        });
      });
    }
  }
}
