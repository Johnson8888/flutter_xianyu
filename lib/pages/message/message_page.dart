/*
 * @Author: 弗拉德
 * @Date: 2021-02-02 18:06:16
 * @LastEditTime: 2021-02-09 22:11:51
 * @Support: http://fulade.me
 */

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../../header/loading_header.dart';
import '../../header/loading_footer.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  var selectedIndex = 3;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "消息",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
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
      body: EasyRefresh.custom(
        header: LoadingHeader(),
        footer: LoadingFooter(
          color: Color.fromRGBO(192, 192, 192, 1),
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
                    color: Colors.red,
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
              childCount: 10,
            ),
          ),

          /*
          ListView.separated(
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return Text("ttt");
              
              return Container(
                color: Colors.white,
                height: 80,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 15, 5),
                      child: CircleAvatar(
                        radius: 25, // 头像的半径
                        backgroundImage: AssetImage('images/ic_notificate.png'),
                      ),
                    ),
                    Expanded(
                      // child: Column(),
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
            separatorBuilder: (context, index) {
              return Divider(
                thickness: 10,
                height: index == 2 ? 10 : 0,
                color: index == 2 ? Colors.white30 : Colors.white,
              );
            },
          ),*/
        ],
      ),
      /*

      */
      bottomNavigationBar: _getBottomNavigationBar(),
    );
  }

  /// 获取到 底部导航栏
  BottomNavigationBar _getBottomNavigationBar() {
    return BottomNavigationBar(
      /// 这个很重要
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          title: Text('闲鱼'),
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          title: Text('会玩'),
          icon: Icon(Icons.book),
        ),
        BottomNavigationBarItem(
          title: Text(''),
          icon: Icon(Icons.school),
        ),
        BottomNavigationBarItem(
          title: Text('消息'),
          icon: Icon(Icons.perm_identity),
        ),
        BottomNavigationBarItem(
          title: Text('我的'),
          icon: Icon(Icons.perm_identity),
        ),
      ],
    );
  }
}
