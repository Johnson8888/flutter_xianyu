/*
 * @Author: 弗拉德
 * @Date: 2021-02-02 18:06:16
 * @LastEditTime: 2021-03-23 17:24:55
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
              itemCount: dataSource.length,
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              // shrinkWrap: true,
              // primary: false,
              itemExtent: 80,
              itemBuilder: (context, index) {
                MessageModel model = dataSource[index];
                // if (index == 2) {
                //   return Divider(
                //     thickness: 10,
                //     height: 10,
                //     color: Color.fromRGBO(220, 220, 220, 1),
                //   );
                // }
                return Container(
                  color: Colors.white,
                  height: 80,
                  child: Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(10, 5, 15, 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(imageUrl: model.portrait),
                          )
                          // CircleAvatar(
                          //   radius: 25, // 头像的半径
                          //   backgroundImage:
                          //       AssetImage('images/ic_notificate.png'),
                          // ),
                          ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Text(
                                model.nickName,
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
                          child: CachedNetworkImage(
                            imageUrl: model.imageUrl,
                          )),
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
    for (Map<String, dynamic> map in jsonResult["respData"]) {
      MessageModel item = MessageModel.fromJson(map);
      data.add(item);
      print(item);
    }
    return data;
  }
}
