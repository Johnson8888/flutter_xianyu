/*
 * @Author: 弗拉德
 * @Date: 2021-02-19 18:07:42
 * @LastEditTime: 2021-03-07 22:32:36
 * @Support: http://fulade.me
 */
import 'package:flutter/material.dart';

class PublishPage extends StatefulWidget {
  @override
  _PublishPageState createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {
  @override
  Widget build(BuildContext context) {
    final paddingLeft = 20.0;
    final textPaddingLeft = 10.0;
    return Scaffold(
      body: Container(
        decoration: new BoxDecoration(
          color: Colors.yellow,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              color: Colors.red,
              height: 120,
            ),
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(paddingLeft, 0, 0, 0),
                    color: Colors.red,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Image.asset(
                          "images/image_demo.jpg",
                          width: 60,
                          height: 60,
                        ),
                        Container(
                          padding:
                              EdgeInsets.fromLTRB(textPaddingLeft, 0, 0, 0),
                          child: Column(
                            children: [
                              Text("发会玩贴子"),
                              Text("分享你的趣事"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(paddingLeft, 0, 0, 0),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue,
                    child: Row(
                      children: [
                        Image.asset(
                          "images/image_demo.jpg",
                          width: 60,
                          height: 60,
                        ),
                        Container(
                          padding:
                              EdgeInsets.fromLTRB(textPaddingLeft, 0, 0, 0),
                          child: Column(
                            children: [
                              Text("发会玩贴子"),
                              Text("分享你的趣事"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(paddingLeft, 0, 0, 0),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.red,
                    child: Row(
                      children: [
                        Image.asset(
                          "images/image_demo.jpg",
                          width: 60,
                          height: 60,
                        ),
                        Container(
                          padding:
                              EdgeInsets.fromLTRB(textPaddingLeft, 0, 0, 0),
                          child: Column(
                            children: [
                              Text("发会玩贴子"),
                              Text("分享你的趣事"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(paddingLeft, 0, 0, 0),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue,
                    child: Row(
                      children: [
                        Image.asset(
                          "images/image_demo.jpg",
                          width: 60,
                          height: 60,
                        ),
                        Container(
                          padding:
                              EdgeInsets.fromLTRB(textPaddingLeft, 0, 0, 0),
                          child: Column(
                            children: [
                              Text("发会玩贴子"),
                              Text("分享你的趣事"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child: Text("Close"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
