/*
 * @Author: 弗拉德
 * @Date: 2021-02-18 10:54:30
 * @LastEditTime: 2021-02-18 15:59:05
 * @Support: http://fulade.me
 */

import 'package:flutter/material.dart';

class AccountHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 60),
            height: 196,
            margin: EdgeInsets.only(left: 10, right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 25, // 头像的半径
                          backgroundImage: AssetImage('images/image_demo.jpg'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "新德里的兰花",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                "会员名:逃之夭夭零",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black45),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Icon(
                      Icons.navigate_next,
                      size: 12,
                      color: Color(0xFF848484),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  height: 80,
                  width: double.infinity,
                  child: Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.spaceEvenly,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "17",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "收藏",
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "354",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "历史浏览",
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "6",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "关注",
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "3",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "粉丝",
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
