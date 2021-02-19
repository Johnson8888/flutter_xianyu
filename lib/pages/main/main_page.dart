/*
 * @Author: 弗拉德
 * @Date: 2021-02-02 18:05:57
 * @LastEditTime: 2021-02-19 18:09:22
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
    );
  }
}
