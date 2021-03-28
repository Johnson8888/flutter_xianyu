/*
 * @Author: 弗拉德
 * @Date: 2021-02-28 11:01:41
 * @LastEditTime: 2021-03-28 15:41:45
 * @Support: http://fulade.me
 */
/// 关注页面
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import './model/attention_item_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:video_player/video_player.dart';
import '../../common/api.dart';
import '../../util/utils.dart';
import './item_details_page.dart';

class AttentionPage extends StatefulWidget {
  @override
  _AttentionPageState createState() => _AttentionPageState();
}

class _AttentionPageState extends State<AttentionPage> {
  /// 记录获取到的数据的数组
  List<CommonGood> dataList = [];

  /// 记录 VideoPlayer 的数组
  Map<String, dynamic> videoPlayerMap = {};
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: Text(
                "常访问的人",
                style: TextStyle(fontSize: 12.0),
              ),
              alignment: Alignment.centerLeft,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _getInterviewList(),
              ),
            ),
          ],
        ),
        FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot snap) {
            /// 如果没有数据 我们就显示loading页面
            if (snap.hasData == false) {
              return CircularProgressIndicator();
            } else {
              /// 如果获取到了数据 我们就初始化一个 ListView来展示获取到的数据
              List<CommonGood> dataSource = snap.data;
              return ListView.builder(
                itemCount: dataSource.length,
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                shrinkWrap: true,
                primary: false,
                itemExtent: 280,
                itemBuilder: (context, index) {
                  CommonGood element = dataSource[index];
                  return InkWell(
                    onTap: () {
                      print(element.title);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ItemDetailsPage(model: element);
                          },
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 200,
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      child: CachedNetworkImage(
                                        width: 30,
                                        height: 30,
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        imageUrl: element.userPhoto,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 100,
                                    height: 36,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 18,
                                          width: 100,
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            element.userName,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          height: 18,
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            Utils.getRandomTimeTag(),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 11.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Text(
                                "¥" +
                                    ((element.infoPrice / 100).toInt())
                                        .toString(),
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: Text(
                            element.infoDesc.replaceAll("\n", ""),
                            maxLines: 2,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 13.0),
                          ),
                        ),
                        _getImageContainerWithPicList(element.infoCoverList,
                            element.video, element.infoId),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }

  //// 获取 数据
  Future<List<CommonGood>> getData() async {
    if (videoPlayerMap.length > 0) {
      videoPlayerMap.clear();
    }

    String jsonString = await rootBundle.loadString("assets/attention1.json");
    final jsonResult = json.decode(jsonString);
    //遍历List，并且转成Anchor对象放到另一个List中
    List<CommonGood> data = List();
    for (Map<String, dynamic> map in jsonResult["respData"]["infoData"]) {
      Map<String, dynamic> commonGood = map["commonGoods"];
      CommonGood item = CommonGood.fromJson(commonGood);
      data.add(item);
      print(item);

      if (item.video != null &&
          item.video.videoUrl != null &&
          item.video.videoUrl.length > 0) {
        String videoUrl =
            "https://video.pearvideo.com/mp4/third/20190730/cont-1584187-10136163-164150-hd.mp4";
        // String videoUrl = "http://vod.anyrtc.cc/364c01b9c8ca4e46bd65e7307887341d/34688ef93da349628d5e4efacf8a5167-9fd7790c8f5862b09c350e4a916b203d.mp4";
        // final videoPlayer = VideoPlayerController.network(item.video.videoUrl)
        final videoPlayer = VideoPlayerController.network(videoUrl)
          ..addListener(() {});
        Future<void> initializeVideoPlayerFuture = videoPlayer.initialize();
        videoPlayer.setLooping(true);
        videoPlayerMap[item.infoId] = {
          "v": videoPlayer,
          "i": initializeVideoPlayerFuture
        };
        print("add infoId " + item.infoId);
      }
    }
    return data;
  }

  /// 获取常访问的列表
  List<Widget> _getInterviewList() {
    List<Map<String, String>> dataList = [
      {"title": "NB之家", "image": "images/avatar_1.jpg"},
      {"title": "王话筒", "image": "images/avatar_2.jpg"},
      {"title": "萨斯剋", "image": "images/avatar_3.jpg"},
      {"title": "超级可爱", "image": "images/avatar_4.jpg"},
      {"title": "王一战", "image": "images/avatar_5.jpg"}
    ];
    List<Widget> list = [];
    for (var i = 0; i < dataList.length; ++i) {
      String name = dataList[i]["title"];
      String imagePath = dataList[i]["image"];
      Widget co = Column(
        children: [
          CircleAvatar(
            radius: 20, // 头像的半径
            backgroundImage: AssetImage(imagePath),
          ),
          Text(name),
        ],
      );
      list.add(co);
    }
    return list;
  }

  /// 获取 list 列表 内的 图片内容尺寸以及大小
  Widget _getImageContainerWithPicList(
      List<PicUrl> infoCoverList, VideoInfo videoInfo, String infoId) {
    /// 当不存在视频信息的时候
    if (videoInfo == null ||
        videoInfo.videoUrl == null ||
        videoInfo.videoUrl.length == 0) {
      var f1Width = MediaQuery.of(context).size.width;
      if (infoCoverList.length > 1) {
        f1Width = MediaQuery.of(context).size.width * 0.5;
      }
      Flexible f1 = Flexible(
        flex: 1,
        child: Container(
          width: f1Width,
          height: 200,
          color: Colors.red,
          child: CachedNetworkImage(
            imageUrl: PIC_URL_PREFIX + infoCoverList.first.picUrl,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      );
      //// 当 等于 数组元素 个数 是1 的时候 直接返回
      if (infoCoverList.length == 1) {
        return Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [f1],
          ),
        );
      }

      /// 当 数组元素 个数 大于 等于 2 的情况
      Flexible f2 = Flexible(
        flex: 1,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          color: Colors.yellow,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CachedNetworkImage(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 200,
                imageUrl: PIC_URL_PREFIX + infoCoverList[1].picUrl,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ],
          ),
        ),
      );

      if (infoCoverList.length > 2) {
        print("length == 3");
        f2 = Flexible(
          flex: 1,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            color: Colors.yellow,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CachedNetworkImage(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 100,
                  imageUrl: PIC_URL_PREFIX + infoCoverList[1].picUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                CachedNetworkImage(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 100,
                  imageUrl: PIC_URL_PREFIX + infoCoverList[2].picUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ],
            ),
          ),
        );
      }
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            f1,
            f2,
          ],
        ),
      );
    } else {
      /// 当存在视频信息的时候  需要播放视频
      Map<String, dynamic> playerDict = videoPlayerMap[infoId];
      // VideoPlayerController playerController = videoPlayerMap[infoId];
      // print("playerController");
      // print(playerController);
      // if (playerController.value.initialized) {
      //   return AspectRatio(
      //     aspectRatio: playerController.value.aspectRatio,
      //     child: VideoPlayer(playerController),
      //   );
      // } else {
      //   return Container();
      // }

      return FutureBuilder(
        future: playerDict["i"],
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            VideoPlayerController controller = playerDict["v"];
            controller.play();
            print("start play");
            return ClipRect(
              child: Transform.scale(
                scale: controller.value.aspectRatio /
                    MediaQuery.of(context).size.aspectRatio *
                    1.01,
                // scale: controller.value.aspectRatio /
                //     (MediaQuery.of(context).size.width / 180) *
                //     1.01,
                child: Container(
                    child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                )),
              ),
            );
            // return ClipRect(
            //   // child: Transform(
            //   child: Transform.scale(
            //     // scale: controller.value.aspectRatio /
            //     //     (MediaQuery.of(context).size.width / 180),
            //     scale: 0.25,
            //     child: AspectRatio(
            //       aspectRatio: controller.value.aspectRatio,
            //       // Use the VideoPlayer widget to display the video.
            //       // child: VideoPlayer(controller),
            //       child: VideoPlayer(controller),
            //     ),
            //   ),
            // );
            // child: Align(
            //   // width: MediaQuery.of(context).size.width,
            //   // height: 180,
            //   alignment: Alignment.center,
            // child: AspectRatio(
            //   aspectRatio: controller.value.aspectRatio,
            //   // Use the VideoPlayer widget to display the video.
            //   // child: VideoPlayer(controller),
            //   child: VideoPlayer(controller),
            // ),
            // ),

            /// 可用的
            // return AspectRatio(
            //   aspectRatio: 16 / 9,
            //   // Use the VideoPlayer widget to display the video.
            //   // child: VideoPlayer(controller),
            //   child: FittedBox(
            //     child: SizedBox(
            //       child: VideoPlayer(controller),
            //       width: MediaQuery.of(context).size.width,
            //       height: 190,
            //     ),
            //     fit: BoxFit.fitWidth,
            //   ),
            // );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: CircularProgressIndicator());
          }
        },
      );
    }
  }

  /// 随机一个时间
  // String _getRandomTimeTag() {
  //   int value = Random().nextInt(7);
  //   if (value == 1) {
  //     return "5分钟前";
  //   }
  //   if (value == 2) {
  //     return "10分钟前";
  //   }
  //   if (value == 3) {
  //     return "30分之前";
  //   }
  //   if (value == 4) {
  //     return "1小时前";
  //   }
  //   if (value == 5) {
  //     return "1天前";
  //   }
  //   int nowSeconds = (DateTime.now().millisecondsSinceEpoch / 1000).toInt();
  //   int timestamp = nowSeconds - 60 * 60 * 24 * 3;
  //   var format = DateFormat('yyyy-MM-dd');
  //   var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  //   return format.format(date);
  // }
}
