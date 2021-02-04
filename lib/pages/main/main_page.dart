/*
 * @Author: 弗拉德
 * @Date: 2021-02-02 18:05:57
 * @LastEditTime: 2021-02-04 13:51:11
 * @Support: http://fulade.me
 */
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Container(
        child: Text("hello"),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }
}
