/*
 * @Author: 弗拉德
 * @Date: 2021-02-02 18:06:16
 * @LastEditTime: 2021-03-26 16:33:42
 * @Support: http://fulade.me
 */

import 'dart:math';

import 'package:flutter/material.dart';
import '../../header/refresh_header.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'message_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../util/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  //// 刷新用的 controller
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  //// 当前加载的页数
  var currentPage = 0;

  /// 数据源数组
  List<MessageModel> dataList = [];

  /// future 对象
  Future<List<MessageModel>> futureMessage;

  void initState() {
    super.initState();
    futureMessage = _getMessageData();
  }

  void _onRefresh() {
    Future.delayed(Duration(milliseconds: 1000), () {
      _refreshController.refreshCompleted();
    });
    futureMessage = _getMessageData();
  }

  void _onLoading() async {
    if (mounted) {
      futureMessage = _loadMoreData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "消息",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: Image.asset("images/ic_navibar_setting.png"),
            onPressed: () {
              print('pressed settting button');
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: futureMessage,
        builder: (BuildContext context, AsyncSnapshot snap) {
          /// 如果没有数据 我们就显示loading页面
          if (snap.hasData == false) {
            return CircularProgressIndicator();
          } else {
            /// 如果获取到了数据 我们就初始化一个 ListView来展示获取到的数据
            dataList.addAll(snap.data);
            print(snap.data);

            return SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: LottieHeader(),
              footer: ClassicFooter(),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: dataList.length,
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                // itemExtent: 80,
                itemBuilder: (context, index) {
                  MessageModel model = dataList[index];
                  if (index == 2) {
                    return Divider(
                      thickness: 10,
                      height: 10,
                      // color: Color.fromRGBO(220, 220, 220, 1),
                      color: Color(0xffF9FAFC),
                    );
                  }
                  return Container(
                    color: Colors.white,
                    height: 80,
                    child: Row(
                      children: [
                        ClipOval(
                          child: Container(
                            width: 55,
                            height: 55,
                            child: model.isTagMessage == false
                                ? CachedNetworkImage(imageUrl: model.portrait)
                                : Image.asset(model.portrait),
                          ),
                        ),
                        Container(
                          width: 20,
                          height: 80,
                        ),
                        Container(
                          child: Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text(
                                    model.nickName,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Text(
                                    model.text,
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                                Text(
                                  Utils.getRandomTimeTag(),
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 9.0,
                                  ),
                                ),
                              ],
                            ),
                            flex: 2,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Center(
                            child: model.isTagMessage == false
                                ? CachedNetworkImage(
                                    imageUrl: model.imageUrl,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
      /*
      body: EasyRefresh.custom(
        header: LoadingHeader(),
        footer: LoadingFooter(
          color: Color.fromRGBO(220, 220, 220, 1),
        ),
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2), () {
            if (mounted) {
              setState(() {});
            }
          });
        },
        onLoad: () async {
          await Future.delayed(Duration(seconds: 2), () {
            if (mounted) {
              setState(() {});
            }
          });
        },
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == 2) {
                  return Divider(
                    thickness: 10,
                    height: 10,
                    color: Color.fromRGBO(220, 220, 220, 1),
                  );
                }
                return Container(
                  color: Colors.white,
                  height: 80,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 5, 15, 5),
                        child: CircleAvatar(
                          radius: 25, // 头像的半径
                          backgroundImage:
                              AssetImage('images/ic_notificate.png'),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Text(
                                "whls1234",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: Text(
                                "点击查看评论内容",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                            Text(
                              "5天前",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 9.0,
                              ),
                            ),
                          ],
                        ),
                        flex: 2,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 15, 10),
                        child: Image.asset("images/image_demo.jpg"),
                      ),
                    ],
                  ),
                );
              },
              childCount: dataList.length,
            ),
          ),
        ],
      ),
      */
    );
  }

  /// 获取当前的聊天记录
  Future<List<MessageModel>> _getMessageData() async {
    // if (dataList.length > 0) {
    //   dataList.clear();
    // }
    String jsonString = await rootBundle.loadString("assets/message.json");
    final jsonResult = json.decode(jsonString);
    List<MessageModel> data = List();
    List<MessageModel> tagList = _addLocalData();
    data.addAll(tagList);
    for (Map<String, dynamic> map in jsonResult["respData"]) {
      MessageModel item = MessageModel.fromJson(map);
      data.add(item);
    }
    print("refreshCompleted");
    return data;
  }

  /// 加载更多信息
  Future<List<MessageModel>> _loadMoreData() async {
    String jsonString = await rootBundle.loadString("assets/message.json");
    final jsonResult = json.decode(jsonString);
    List<MessageModel> data = List();
    for (Map<String, dynamic> map in jsonResult["respData"]) {
      MessageModel item = MessageModel.fromJson(map);
      if (Random().nextBool() == true) {
        data.add(item);
      }
    }
    currentPage++;
    if (currentPage <= 3) {
      _refreshController.loadComplete();
    } else {
      _refreshController.loadNoData();
    }
    return data;
  }

  /// 添加本地的数据
  List<MessageModel> _addLocalData() {
    List<MessageModel> tagList = [];
    MessageModel m1 = MessageModel(
      "闲鱼网络生态治理专项行动公告(二十四)",
      "通知消息",
      "",
      "images/ic_notificate.png",
      true,
    );
    MessageModel m2 = MessageModel(
      "shwl8812关注了您",
      "互动消息",
      "",
      "images/ic_interact@3x.png",
      true,
    );
    MessageModel m3 = MessageModel(
      "因购物而生发布了“小米音响Pro”",
      "关注上新",
      "",
      "images/msg_followtrend_icon@3x.png",
      true,
    );
    MessageModel m4 = MessageModel(
      "[99+条]多人对你的宝贝感兴趣",
      "闲鱼情报社",
      "",
      "images/ic_information@3x.png",
      true,
    );
    tagList.add(m1);
    tagList.add(m2);
    tagList.add(m3);
    tagList.add(m3);
    tagList.add(m4);
    return tagList;
  }
}
