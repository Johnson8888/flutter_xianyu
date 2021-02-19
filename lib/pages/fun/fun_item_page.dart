/*
 * @Author: 弗拉德
 * @Date: 2021-02-19 18:15:22
 * @LastEditTime: 2021-02-19 18:18:09
 * @Support: http://fulade.me
 */
import 'package:flutter/material.dart';

class FunItemPage extends StatefulWidget {
  @override
  _FunItemPageState createState() => _FunItemPageState();
}

class _FunItemPageState extends State<FunItemPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Calls",
        style: new TextStyle(fontSize: 20.0),
      ),
    );
  }
}
