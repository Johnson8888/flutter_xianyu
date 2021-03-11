/*
 * @Author: 弗拉德
 * @Date: 2021-02-28 11:01:41
 * @LastEditTime: 2021-03-10 20:49:30
 * @Support: http://fulade.me
 */
/// 关注页面
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';
import './model/attention_item_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AttentionPage extends StatefulWidget {
  @override
  _AttentionPageState createState() => _AttentionPageState();
}

class _AttentionPageState extends State<AttentionPage> {
  List<CommonGood> dataList = [];
  @override
  void initState() {
    super.initState();

    getData().then(
      (data) {
        setState(() {
          print(dataList.length);
          dataList = data;
        });
      },
    );
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
                itemExtent: 270,
                itemBuilder: (context, index) {
                  CommonGood element = dataSource[index];
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 200,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 15, // 头像的半径
                                  backgroundImage:
                                      AssetImage('images/image_demo.jpg'),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        element.userName,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0),
                                      child: Text(
                                        "1天前发布",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(fontSize: 11.0),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Text(
                              "¥500",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Text(
                          "游戏本，关联战神，雷神，外星人，拯救者，飞行堡垒，炫龙玩家，国度等...,游戏本，关联战神，雷神，外星人，拯救者，飞行堡垒，炫龙玩家，国度等...游戏本，关联战神，雷神，外星人，拯救者，飞行堡垒，炫龙玩家，国度等...",
                          maxLines: 2,
                          style: TextStyle(fontSize: 13.0),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                color: Colors.red,
                                child: Image.asset(
                                  "images/refresh_normal.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                color: Colors.yellow,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      "images/refresh_normal.png",
                                      fit: BoxFit.contain,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.25,
                                    ),
                                    Image.asset(
                                      "images/refresh_normal.png",
                                      fit: BoxFit.contain,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.25,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
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
    String jsonString = await rootBundle.loadString("assets/attention1.json");
    final jsonResult = json.decode(jsonString);
    //遍历List，并且转成Anchor对象放到另一个List中
    List<CommonGood> data = List();
    for (Map<String, dynamic> map in jsonResult["respData"]["infoData"]) {
      Map<String, dynamic> commonGood = map["commonGoods"];
      CommonGood item = CommonGood.fromJson(commonGood);
      // print(item.userName);
      data.add(item);
    }
    return data;
  }

  /// 获取常访问的列表
  List<Widget> _getInterviewList() {
    List names = ["NB之家", "王话筒", "萨斯剋", "超级可爱", "王一战"];
    List images = [
      "images/image_demo.jpg",
      "images/image_demo.jpg",
      "images/image_demo.jpg",
      "images/image_demo.jpg",
      "images/image_demo.jpg"
    ];
    List<Widget> list = [];
    for (var i = 0; i < names.length; ++i) {
      String name = names[i];
      String imagePath = images[i];
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
}
