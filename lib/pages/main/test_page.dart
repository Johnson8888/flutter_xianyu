/*
 * @Author: 弗拉德
 * @Date: 2021-03-05 19:27:21
 * @LastEditTime: 2021-03-05 19:58:41
 * @Support: http://fulade.me
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  var data = [];
  @override
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 100,
        itemExtent: 50.0, //强制高度为50.0
        itemBuilder: (BuildContext context, int index) {
          return ListTile(title: Text("$index"));
        },
      ),
    );
  }

  Future<void> getData() async {
    String filePath = await rootBundle.loadString("xianyu_json/file.txt");
    File(filePath)
        .openRead()
        .map(utf8.decode)
        .transform(
          new LineSplitter(),
        )
        .forEach((l) async {
      if (l.endsWith("txt") == false) {
        String bundlePath = "xianyu_json/" + l;
        // String stringContent = await rootBundle.loadString(bundlePath);
        // List jsonList = json.decode(stringContent);
        // print(bundlePath);
      }
    });
  }
}
