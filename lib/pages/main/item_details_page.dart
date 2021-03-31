/*
 * @Author: 弗拉德
 * @Date: 2021-03-28 14:01:25
 * @LastEditTime: 2021-03-31 17:16:33
 * @Support: http://fulade.me
 */
import 'package:flutter/material.dart';
import './model/attention_item_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../common/utils.dart';
import '../../common/api.dart';
import 'dart:math';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:video_player/video_player.dart';

class ItemDetailsPage extends StatefulWidget {
  final CommonGood model;

  /// 初始化方法
  const ItemDetailsPage({Key key, this.model}) : super(key: key);

  @override
  _ItemDetailsPageState createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  /// 颜色
  String hpCon = '';
  //定义透明度
  double appBarAlpha = 1.0;

  _onScroll(offset) {
    /*
    double alpha = offset / 100;
    print(offset);
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 80),
              child: NotificationListener(
                onNotification: (ScrollNotification notification) {
                  if (notification is ScrollUpdateNotification &&
                      notification.depth == 0) {
                    _onScroll(notification.metrics.pixels);
                  }
                },
                child: ListView(
                  children: <Widget>[
                    /// 用戶信息 Container
                    _showVideoWidget(),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 64, 0, 0),
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                    imageUrl: widget.model.userPhoto,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(widget.model.userName),
                                    Text(widget.model.specialUserDesc.desc),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Color(0xfffbababa),
                                width: 1.0,
                              ),
                            ),
                            width: 60,
                            child: Text("已关注"),
                          ),
                        ],
                      ),
                    ),

                    /// 价格 信息
                    Container(
                      width: 100,
                      child: Row(
                        children: [
                          Text(
                            "¥" +
                                ((widget.model.infoPrice / 100).toInt())
                                    .toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          Text(
                            "¥" +
                                ((widget.model.infoPrice / 100 - 50).toInt())
                                    .toString(),
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffbababa),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Text(
                              "包邮",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// 描述
                    Container(
                      height: 120,
                      child: Text("手机号手机号就是结婚三大件贺卡收到和风纪扣撒谎看见啥尽快好几十块的后即可收到" +
                          widget.model.infoDesc),
                    ),

                    /// 要显示的图片
                    Container(
                      child: Column(
                        children: _getImageList(),
                      ),
                    ),

                    /// 担保交易
                    Container(
                      height: 20,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 100,
                            child: Row(
                              children: [
                                Image.asset(
                                  "images/detail_alipay@2x.png",
                                  width: 10,
                                  height: 10,
                                ),
                                Text("担保交易")
                              ],
                            ),
                          ),
                          Container(
                            width: 180,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  //width: 40,
                                  child: Text("60人想要 ·"),
                                ),
                                Container(
                                  // width: 40,
                                  child: Text("浏览1083"),
                                ),
                                Container(
                                  width: 40,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "images/detail_alipay@2x.png",
                                        width: 10,
                                        height: 10,
                                      ),
                                      Text("举报"),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //// 用户信息展示
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 80,
                            child: Column(
                              children: [
                                Text(
                                  widget.model.userName,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "来咸鱼985天，卖出过3410件宝贝。90后射手座女生，IT/互联网/通信行业销售。江西财经大学毕业。",
                                  style: TextStyle(),
                                  maxLines: 2,
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Text("实人认证已通过"),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("芝麻信用已授权"),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          CachedNetworkImage(
                            width: 40,
                            height: 40,
                            errorWidget: (context, url, error) {
                              return Icon(Icons.error);
                            },
                            imageUrl: widget.model.userPhoto,
                          ),
                        ],
                      ),
                    ),

                    /// 留言信息
                    Container(
                      child: Column(
                        children: [
                          Text(
                            "全部留言 · 1",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                "images/image_demo.jpg",
                                width: 30,
                                height: 30,
                              ),
                              Container(
                                child: Text(
                                  "看对眼就留言,问问更多细节~",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          ),

                          /// 留言信息展示
                          ListView.builder(
                            itemCount: 10,
                            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                            shrinkWrap: true,
                            primary: false,
                            itemExtent: 80,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 100,
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "images/image_demo.jpg",
                                              width: 25,
                                              height: 25,
                                            ),
                                            Text("弗拉德"),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          print("tapped like button");
                                        },
                                        child: Image.asset(
                                          "images/ic_detail_like_nor@3x.png",
                                          width: 25,
                                          height: 25,
                                        ),
                                      )
                                    ],
                                  ),
                                  Text("用了多久?"),
                                  Text("5天前"),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    /// 更多信息展示
                    StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      primary: false,
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            child: _buildItemWithModel(widget.model));
                      },
                      staggeredTileBuilder: (int index) {
                        return StaggeredTile.fit(2);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          //这里是搜索框
          //这里可以自定义组件,使用自己的头,我的是项目的
          Opacity(
            opacity: appBarAlpha, //滑动offset改变透明度
            child: Container(
              decoration: BoxDecoration(
                color: Colors.yellow,
              ),
              height: 64,
              child: AppBar(
                title: Text("Title"),
                centerTitle: true,
              ),
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: MediaQuery.of(context).size.height - 80,
            child: Container(
              color: Colors.green,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 180,
                    height: 60,
                    color: Colors.yellow,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              "images/ic_detail_like_nor@3x.png",
                              width: 35,
                              height: 35,
                            ),
                            Text("超赞"),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              "images/ic_detail_like_nor@3x.png",
                              width: 35,
                              height: 35,
                            ),
                            Text("留言"),
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              "images/ic_detail_like_nor@3x.png",
                              width: 35,
                              height: 35,
                            ),
                            Text("收藏"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 20, 0),
                    width: 80,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red,
                    ),
                    child: Text(
                      "我想要",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
    // );
  }

  List<Widget> _getImageList() {
    List<Widget> list = [];
    widget.model.infoCoverList.forEach(
      (element) {
        print(PIC_URL_PREFIX + element.picUrl);
        list.add(
          CachedNetworkImage(
            errorWidget: (context, url, error) {
              return Icon(Icons.error);
            },
            imageUrl: PIC_URL_PREFIX + element.picUrl,
          ),
        );
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
                      Random().nextInt(1000).toString() + "人想要",
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

  Widget _showVideoWidget() {
    if (widget.model.video.videoUrl == null) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 1,
      );
    }
    // final width = int.parse(widget.model.video.width);
    // final height = int.parse(widget.model.video.height);
    // final windowsWidth = MediaQuery.of(context).size.width;
    // final newHeight = windowsWidth / width * height;

    final videoPlayer =
        VideoPlayerController.network(widget.model.video.videoUrl)
          ..addListener(() {});
    Future<void> initializeVideoPlayerFuture = videoPlayer.initialize();
    videoPlayer.setLooping(true);

    Widget videoWidget = FutureBuilder(
      future: initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          videoPlayer.setVolume(0);
          videoPlayer.play();
          print("start play vv");
          return Container(
            child: AspectRatio(
              aspectRatio: videoPlayer.value.aspectRatio,
              child: VideoPlayer(videoPlayer),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
    print("videoWidget");
    print(videoWidget);
    return videoWidget;
  }
}
