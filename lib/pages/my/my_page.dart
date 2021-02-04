/*
 * @Author: 弗拉德
 * @Date: 2020-12-17 20:32:59
 * @LastEditTime: 2021-02-04 13:48:48
 * @Support: http://fulade.me
 */

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colors.yellow,
      ),
      body: Container(
        child: Text("hello"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        /// 这个很重要
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
        onTap: (index) {
          setState(() {});
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('F1'),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text('F2'),
            icon: Icon(Icons.book),
          ),
          BottomNavigationBarItem(
            title: Text('F3'),
            icon: Icon(Icons.school),
          ),
          BottomNavigationBarItem(
            title: Text('F4'),
            icon: Icon(Icons.perm_identity),
          ),
        ],
      ),
    );
  }
}
