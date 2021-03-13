/*
 * @Author: 弗拉德
 * @Date: 2021-02-28 11:02:31
 * @LastEditTime: 2021-03-13 16:07:15
 * @Support: http://fulade.me
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

import './model/attention_item_model.dart';
import 'dart:convert';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import '../../common/api.dart';

enum LoadingState {
  nona,
  loading,
  noMore,
}

class RecommendItemPage extends StatefulWidget {
  RecommendItemPage({Key key, this.categoryType}) : super(key: key);

  final String categoryType;

  @override
  State<StatefulWidget> createState() {
    return _RecommendItemPageState();
  }
}

class _RecommendItemPageState extends State<RecommendItemPage>
    with AutomaticKeepAliveClientMixin {
  int page = 0;
  LoadingState loadingState = LoadingState.nona;
  bool isPerformingRequest = false;
  List dataList = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    fetchMoreData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildStaggeredGrid();
  }

  Widget buildStaggeredGrid() {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) {
          return NotificationListener<ScrollEndNotification>(
            onNotification: (ScrollEndNotification scroll) {
              if (scroll.metrics.pixels == scroll.metrics.maxScrollExtent) {
                print("scroll to end");
                fetchMoreData();
              }
              return false;
            },
            child: Container(
              color: Colors.grey[100],
              child: CustomScrollView(
                key: PageStorageKey(widget.categoryType),
                slivers: <Widget>[
                  // 顶部偏移量
                  SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                  ),
                  // 商品列表
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                    sliver: SliverStaggeredGrid.countBuilder(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      itemCount: dataList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          color: Colors.blue,
                          child: _buildItemWithModel(dataList[index]),
                        );
                      },
                      staggeredTileBuilder: (int index) {
                        return StaggeredTile.fit(2);
                      },
                    ),
                  ),
                  // 刷新控件
                  buildLoadingWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /*
  Widget buildGrid() {
    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      crossAxisCount: 4,
      shrinkWrap: true,
      primary: false,
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) => new Container(
          color: Colors.green,
          child: Center(
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: _buildItemWithModel(dataList[index]),
            ),
          )),
      staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
  */
  Widget _buildItemWithModel(CommonGood model) {
    return Column(
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: CachedNetworkImage(
                  height: 190,
                  width: MediaQuery.of(context).size.width * 0.5 - 15,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  imageUrl: PIC_URL_PREFIX + model.infoCoverList.first.picUrl,
                ),
              ),
              Text(
                model.title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "¥" + ((model.infoPrice / 100).toInt()).toString(),
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "8人想要",
                    style: TextStyle(fontSize: 11.0),
                  ),
                ],
              ),
              Row(
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
                        width: 60,
                        child: Text(
                          model.userName,
                          style: TextStyle(fontSize: 11.0),
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
              )
            ],
          ),
        )
      ],
    );
  }

  Widget buildProgressIndicator() {
    if (page < 3) {
      fetchMoreData();
      return Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Opacity(
            opacity: isPerformingRequest ? 1 : 0,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      return noMoreData();
    }
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
