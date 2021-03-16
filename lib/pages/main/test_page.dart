/*
 * @Author: 弗拉德
 * @Date: 2021-03-05 19:27:21
 * @LastEditTime: 2021-03-16 22:20:33
 * @Support: http://fulade.me
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';

const double buttonSize = 40.0;

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  GlobalKey _myKey = new GlobalKey();
  ScrollController _controller;
  int index = 0;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    //来监听 节点是否build完成
    WidgetsBinding widgetsBinding = WidgetsBinding.instance;
    widgetsBinding.addPostFrameCallback((callback) {
      Timer.periodic(new Duration(seconds: 5), (timer) {
        index += _myKey.currentContext.size.height.toInt();
        _controller.animateTo((index).toDouble(),
            duration: new Duration(seconds: 2), curve: Curves.easeOutSine);
        //滚动到底部从头开始
        if ((index - _myKey.currentContext.size.height.toInt()).toDouble() >
            _controller.position.maxScrollExtent) {
          _controller.jumpTo(_controller.position.minScrollExtent);
          index = 0;
        }
      });
    });
    _controller = new ScrollController(initialScrollOffset: 0);
    /*   _controller.addListener(() {
      print(_controller.offset);
    });*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: 21,
        color: Colors.red,
        child: ListView.builder(
          key: _myKey,
          //禁止手动滑动
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          //item固定高度
          itemExtent: 21,
          scrollDirection: Axis.vertical,
          controller: _controller,
          itemBuilder: (context, index) {
            return Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 10, // 头像的半径
                    backgroundImage: AssetImage('images/image_demo.jpg'),
                  ),
                  Text(
                    "【猎毒人】吕云鹏计划通楚天南中风下线？" + index.toString(),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
