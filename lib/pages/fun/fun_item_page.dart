/*
 * @Author: 弗拉德
 * @Date: 2021-02-19 18:15:22
 * @LastEditTime: 2021-02-26 20:48:21
 * @Support: http://fulade.me
 */
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:math' as math;
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../../header/loading_header.dart';
import '../../header/loading_footer.dart';

import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';
import 'fun_item_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FunItemPage extends StatefulWidget {
  @override
  _FunItemPageState createState() => _FunItemPageState();
}

class _FunItemPageState extends State<FunItemPage> {
  List<FunItemModel> dataList = [];
  @override
  void initState() {
    super.initState();
    getData().then((data) {
      setState(() {
        dataList = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh.custom(
      header: LoadingHeader(),
      footer: LoadingFooter(
        color: Color.fromRGBO(220, 220, 220, 1),
      ),
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 2), () {
          if (mounted) {
            setState(() {});
          }
        });
      },
      onLoad: () async {
        await Future.delayed(Duration(seconds: 2), () {
          if (mounted) {
            setState(() {});
          }
        });
      },
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return StaggeredGridView.countBuilder(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                crossAxisCount: 2,
                itemCount: dataList.length,
                itemBuilder: (BuildContext context, int index) {
                  String url = dataList[index].images_list.first.url;
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: CachedNetworkImage(
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            imageUrl: url,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Text(
                            dataList[index].title,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          height: 20,
                          child: Wrap(
                            direction: Axis.vertical,
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 80,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 10, // 头像的半径
                                      backgroundImage:
                                          AssetImage('images/image_demo.jpg'),
                                    ),
                                    Text(
                                      dataList[index].user.nickname,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 60,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 10, // 头像的半径
                                      backgroundImage:
                                          AssetImage('images/image_demo.jpg'),
                                    ),
                                    Text(
                                      dataList[index].likes.toString(),
                                      style: TextStyle(
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                staggeredTileBuilder: (int index) {
                  int height = dataList[index].images_list.first.height + 250;
                  int width = dataList[index].images_list.first.width;
                  return StaggeredTile.count(1, height / width);
                },
                mainAxisSpacing: 15.0,
                crossAxisSpacing: 15.0,
              );
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }

  Future<List> getData() async {
    String jsonString = await rootBundle.loadString("assets/fun2.json");
    final jsonResult = json.decode(jsonString);
    //遍历List，并且转成Anchor对象放到另一个List中
    List<FunItemModel> data = List();
    for (Map<String, dynamic> map in jsonResult["data"]) {
      FunItemModel item = FunItemModel.fromJson(map);
      data.add(item);
    }
    return data;
  }
}
