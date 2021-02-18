/*
 * @Author: 弗拉德
 * @Date: 2021-02-18 11:21:29
 * @LastEditTime: 2021-02-18 14:40:36
 * @Support: http://fulade.me
 */
import 'package:flutter/material.dart';

class AccountDealCard extends StatelessWidget {
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
          Padding(
            padding: EdgeInsets.only(
              top: 0,
              bottom: 10,
            ),
            child: Divider(
              height: 10,
              thickness: 10,
              color: Color.fromARGB(255, 192, 192, 192),
            ),
          ),
          Container(
            height: 105,
            margin: EdgeInsets.only(left: 10, right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "我的交易",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "在闲鱼赚了3095.00元",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF848484),
                          ),
                        ),
                      ],
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
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            "http://gw.alicdn.com/mt/TB1c9eMraL7gK0jSZFBXXXZZpXa-96-96.png",
                            width: 30,
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              "我发布的 3",
                              style: TextStyle(fontSize: 13.0),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            "http://gw.alicdn.com/mt/TB1aL_kPjDpK1RjSZFrXXa78VXa-96-96.png",
                            width: 30,
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              "我卖出的 10",
                              style: TextStyle(fontSize: 13.0),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            "http://gw.alicdn.com/mt/TB1HivpPhTpK1RjSZR0XXbEwXXa-96-96.png",
                            width: 30,
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "我买到的 19",
                              style: TextStyle(fontSize: 13.0),
                            ),
                          ),
                        ],
                      )
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
