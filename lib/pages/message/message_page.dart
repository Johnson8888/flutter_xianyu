/*
 * @Author: 弗拉德
 * @Date: 2021-02-02 18:06:16
 * @LastEditTime: 2021-03-23 20:59:37
 * @Support: http://fulade.me
 */

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../../header/loading_header.dart';
import '../../header/loading_footer.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'message_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../util/utils.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  var selectedIndex = 3;
  List<MessageModel> dataList = [];
  void initState() {
    super.initState();
  }

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
        future: _getMessageData(),
        builder: (BuildContext context, AsyncSnapshot snap) {
          /// 如果没有数据 我们就显示loading页面
          if (snap.hasData == false) {
            return CircularProgressIndicator();
          } else {
            /// 如果获取到了数据 我们就初始化一个 ListView来展示获取到的数据
            List<MessageModel> dataSource = snap.data;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: dataSource.length,
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              // itemExtent: 80,
              itemBuilder: (context, index) {
                MessageModel model = dataSource[index];
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
                      ClipOval(
                        child: Container(
                          width: 55,
                          height: 55,
                          // padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: CachedNetworkImage(imageUrl: model.portrait),
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
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                                  "点击查看评论内容",
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
                          child: CachedNetworkImage(
                            imageUrl: model.imageUrl,
                            imageBuilder: (context, imageProvider) => Container(
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
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
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
    String jsonString = await rootBundle.loadString("assets/message.json");
    final jsonResult = json.decode(jsonString);
    List<MessageModel> data = List();
    _addLocalData(data);
    for (Map<String, dynamic> map in jsonResult["respData"]) {
      MessageModel item = MessageModel.fromJson(map);
      data.add(item);
    }
    print("length " + data.length.toString());
    return data;
  }

  /// 添加本地的数据
  _addLocalData(List<MessageModel> data) {
    MessageModel m1 = MessageModel(
        "闲鱼网络生态治理专项行动公告(二十四)", "通知消息", "", "images/ic_notificate.png", true);
    MessageModel m2 = MessageModel(
        "shwl8812关注了您", "互动消息", "", "images/ic_interact@3x.png", true);
    MessageModel m3 = MessageModel("因购物而生发布了“小米音响Pro”", "关注上新", "",
        "images/msg_followtrend_icon@3x.png", true);
    MessageModel m4 = MessageModel(
        "[99+条]多人对你的宝贝感兴趣", "闲鱼情报社", "", "images/ic_information@3x.png", true);
    data.add(m1);
    data.add(m2);
    data.add(m3);
    data.add(m3);
    data.add(m4);
    return data;
  }
}
