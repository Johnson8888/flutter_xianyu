/*
 * @Author: 弗拉德
 * @Date: 2021-02-02 18:05:57
 * @LastEditTime: 2021-02-08 14:21:48
 * @Support: http://fulade.me
 */
import 'package:flutter/material.dart';
import 'package:group_list_view/group_list_view.dart';

class FunPage extends StatefulWidget {
  @override
  _FunPageState createState() => _FunPageState();
}

class _FunPageState extends State<FunPage> {
  @override
  var selectedIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Container(
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
                      Text(
                        "whls1234",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.all(2),
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
                  padding: EdgeInsets.fromLTRB(5, 5, 10, 5),
                  child: Image.asset("images/image_demo.jpg"),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 0,
            height: index == 2 ? 20 : 0,
            color: Colors.white,
          );
        },
      ),
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
