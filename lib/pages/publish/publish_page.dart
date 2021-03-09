/*
 * @Author: 弗拉德
 * @Date: 2021-02-19 18:07:42
 * @LastEditTime: 2021-03-09 22:11:46
 * @Support: http://fulade.me
 */
import 'package:flutter/material.dart';
import 'package:flutter_xianyu/common/colors.dart';

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
          color: Color(0xff333333),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              height: 120,
            ),
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(paddingLeft, 0, 0, 0),
                    // color: Colors.red,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Image.asset(
                          "images/img_7.png",
                          width: 60,
                          height: 60,
                        ),
                        Container(
                          padding:
                              EdgeInsets.fromLTRB(textPaddingLeft, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "发会玩贴子",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "分享你的趣事",
                                style: TextStyle(
                                  color: mPublishTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(paddingLeft, 0, 0, 0),
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.blue,
                    child: Row(
                      children: [
                        Image.asset(
                          "images/img_7.png",
                          width: 60,
                          height: 60,
                        ),
                        Container(
                          padding:
                              EdgeInsets.fromLTRB(textPaddingLeft, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "淘宝转卖",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "淘宝宝贝一键转卖",
                                style: TextStyle(
                                  color: mPublishTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(paddingLeft, 0, 0, 0),
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.red,
                    child: Row(
                      children: [
                        Image.asset(
                          "images/img_7.png",
                          width: 60,
                          height: 60,
                        ),
                        Container(
                          padding:
                              EdgeInsets.fromLTRB(textPaddingLeft, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "省心卖",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "平台帮卖免沟通 48小时必卖",
                                style: TextStyle(
                                  color: mPublishTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(paddingLeft, 0, 0, 0),
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.blue,
                    child: Row(
                      children: [
                        Image.asset(
                          "images/img_7.png",
                          width: 60,
                          height: 60,
                        ),
                        Container(
                          padding:
                              EdgeInsets.fromLTRB(textPaddingLeft, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "发闲置",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "30s发布宝贝",
                                style: TextStyle(
                                  color: mPublishTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: FlatButton(
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ), // 也可控件一边圆角大小
                        ),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Image.asset(
                            "images/ic_publish_close@3x.png",
                          ),
                        ),
                      ),
                      onPressed: () {},
                    ),
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
