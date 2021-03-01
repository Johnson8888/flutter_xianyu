/*
 * @Author: 弗拉德
 * @Date: 2021-02-28 11:01:41
 * @LastEditTime: 2021-03-01 13:51:20
 * @Support: http://fulade.me
 */
/// 关注页面
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AttentionPage extends StatefulWidget {
  @override
  _AttentionPageState createState() => _AttentionPageState();
}

class _AttentionPageState extends State<AttentionPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
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
      ListView.builder(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        shrinkWrap: true,
        primary: false,
        itemCount: 10,
        itemExtent: 270,
        itemBuilder: (context, index) {
          return _getInfoList()[index];
        },
      ),
    ]);
  }

  /// 获取关注用户的信息列表
  List<Widget> _getInfoList() {
    List<Widget> list = [];
    for (int i = 0; i < 10; ++i) {
      Widget co = Column(
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
                      backgroundImage: AssetImage('images/image_demo.jpg'),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "用户_334",
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
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
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
                  flex: 2,
                  child: Container(
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
                    color: Colors.yellow,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "images/refresh_normal.png",
                          fit: BoxFit.contain,
                          height: 90,
                        ),
                        Image.asset(
                          "images/refresh_normal.png",
                          fit: BoxFit.contain,
                          height: 90,
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
      list.add(co);
    }
    return list;
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
