/*
 * @Author: 弗拉德
 * @Date: 2021-02-18 10:57:56
 * @LastEditTime: 2021-02-18 14:36:32
 * @Support: http://fulade.me
 */
import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {
  final moreData = [
    {
      "image": "http://gw.alicdn.com/mt/TB1DSUQg4D1gK0jSZFKXXcJrVXa-96-96.png",
      "title": "我的贴子"
    },
    {
      "image":
          "https://gw.alicdn.com/bao/uploaded/TB1ZXYnPmzqK1RjSZFLXXcn2XXa-96-96.png",
      "title": "我租到的"
    },
    {
      "image":
          "https://gw.alicdn.com/tfs/TB1IbofANnaK1RjSZFtXXbC2VXa-144-144.png",
      "title": "我的拍卖"
    },
    {
      "image":
          "https://gw.alicdn.com/bao/uploaded/TB1iorjPgTqK1RjSZPhXXXfOFXa-96-96.png",
      "title": "我的租房"
    },
    {
      "image":
          "https://gw.alicdn.com/bao/uploaded/TB1ZXYnPmzqK1RjSZFLXXcn2XXa-96-96.png",
      "title": "我的兼职"
    },
    {
      "image":
          "https://gw.alicdn.com/bao/uploaded/TB1t_DsPXYqK1RjSZLeXXbXppXa-96-96.png",
      "title": "我的红包"
    },
    {
      "image": "http://gw.alicdn.com/mt/TB1FgvjPmrqK1RjSZK9XXXyypXa-96-96.png",
      "title": "安全中心"
    },
    {
      "image":
          "https://gw.alicdn.com/bao/uploaded/TB1QHzqPlLoK1RjSZFuXXXn0XXa-96-96.png",
      "title": "客服中心"
    },
    {
      "image": "http://gw.alicdn.com/mt/TB1ELKidNn1gK0jSZKPXXXvUXXa-96-96.png",
      "title": "认证招商"
    },
    {
      "image": "http://gw.alicdn.com/mt/TB16mbFh_Zmx1VjSZFGXXax2XXa-96-96.png",
      "title": "闲鱼公约"
    },
    {
      "image": "http://gw.alicdn.com/mt/TB1DSUQg4D1gK0jSZFKXXcJrVXa-96-96.png",
      "title": "物流权益"
    },
    {
      "image":
          "https://gw.alicdn.com/tfs/TB1uuSocUz1gK0jSZLeXXb9kVXa-96-96.png",
      "title": "参与的免费送"
    },
    {
      "image": "http://gw.alicdn.com/mt/TB13_lIdLb2gK0jSZK9XXaEgFXa-96-96.png",
      "title": "助卖宝卡"
    },
    {
      "image": "http://gw.alicdn.com/mt/TB17USrdkL0gK0jSZFtXXXQCXXa-96-96.png",
      "title": "天天赚钱"
    },
    {
      "image": "http://gw.alicdn.com/mt/TB1MzzIbQP2gK0jSZPxXXacQpXa-96-96.png",
      "title": "闲鱼Family"
    },
    {
      "image":
          "https://gw.alicdn.com/bao/uploaded/TB1rKTkPjDpK1RjSZFrXXa78VXa-96-96.png",
      "title": "鱼力行动"
    },
  ];

  final String title;
  AccountCard({Key key, this.title = ""}) : super(key: key);
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
              top: 10,
              bottom: 20,
            ),
            child: Divider(
              height: 1,
            ),
          ),
          Container(
            height: 30,
            margin: EdgeInsets.only(left: 10, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Floor(
            floorOptions: moreData.map((data) {
              return CardItem(
                icon: Container(
                  child: Image.network(
                    data["image"],
                    width: 40,
                    height: 40,
                  ),
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                ),
                title: data["title"] == null ? "" : data["title"],
                titleColor: Colors.red,
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}

class Floor extends StatelessWidget {
  final List<CardItem> floorOptions;
  final double itemWidth;
  final double spacing;
  final double runSpacing;
  final EdgeInsets margin;
  final Color backgroundColor;
  Floor({
    Key key,
    this.floorOptions = const [],
    this.itemWidth = 70,
    this.spacing = 20,
    this.runSpacing = 20,
    this.margin = const EdgeInsets.only(
      top: 10,
      bottom: 10,
    ),
    this.backgroundColor = const Color(0xFFFFFFFF),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: margin,
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.spaceEvenly,
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: spacing,
        runSpacing: runSpacing,
        children: <Widget>[
          ...floorOptions.map((floorOption) {
            return GestureDetector(
              onTap: () => floorOption.onTab(floorOption.unionId),
              child: Container(
                width: itemWidth,
                child: Column(
                  children: <Widget>[
                    floorOption.icon,
                    Column(
                      children: <Widget>[
                        Text(
                          floorOption.title,
                          style: TextStyle(
                              fontSize: 12, color: floorOption.titleColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}

class CardItem {
  final String title;
  final Widget icon;
  final Color titleColor;
  final dynamic unionId;
  final Function(dynamic unionId) onTab;
  CardItem(
      {this.title = "",
      @required this.icon,
      this.titleColor = const Color(0xFF000000),
      this.onTab,
      this.unionId});
}
