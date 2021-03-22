/*
 * @Author: 弗拉德
 * @Date: 2021-02-19 18:15:22
 * @LastEditTime: 2021-03-22 20:39:15
 * @Support: http://fulade.me
 */
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:math' as math;
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../../header/loading_header.dart';
import '../../header/loading_footer.dart';
import 'dart:math';
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
    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      crossAxisCount: 4,
      itemCount: dataList.length,
      itemBuilder: (BuildContext context, int index) {
        String url = dataList[index].images_list.first.url;
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: CachedNetworkImage(
                  errorWidget: (context, url, error) => Icon(Icons.error),
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              imageUrl: dataList[index].user.images,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            width: 70,
                            child: Text(
                              dataList[index].user.nickname,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          color: Color(0xFFababab),
                          width: 1.0,
                        ),
                      ),
                      width: 55,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10), // 角标
                            child:
                                Image.asset("images/ic_detail_like_nor@3x.png"),
                          ),
                          Text(
                            //dataList[index].likes.toString(),
                            _parseLikes(dataList[index].likes),
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
        // int height = dataList[index].images_list.first.height + 250;
        // int width = dataList[index].images_list.first.width;
        return StaggeredTile.fit(2);
      },
      mainAxisSpacing: 15.0,
      crossAxisSpacing: 15.0,
    );

    /*
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
                crossAxisCount: 4,
                itemCount: 28,
                itemBuilder: (BuildContext context, int index) => new Container(
                    color: Colors.green,
                    child: new Center(
                      child: new CircleAvatar(
                        backgroundColor: Colors.white,
                        child: new Text('$index'),
                      ),
                    )),
                staggeredTileBuilder: (int index) =>
                    new StaggeredTile.count(2, index.isEven ? 2 : 1),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              );

              return StaggeredGridView.countBuilder(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                crossAxisCount: 2,
                itemCount: 5,
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
                  // int height = dataList[index].images_list.first.height + 250;
                  // int width = dataList[index].images_list.first.width;
                  return StaggeredTile.fit(2);
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
    */
  }

  Future<List> getData() async {
    final randowFile = Random().nextInt(7) + 1;
    String jsonString =
        await rootBundle.loadString("assets/fun$randowFile.json");
    final jsonResult = json.decode(jsonString);
    //遍历List，并且转成Anchor对象放到另一个List中
    List<FunItemModel> data = List();
    for (Map<String, dynamic> map in jsonResult["data"]) {
      FunItemModel item = FunItemModel.fromJson(map);
      data.add(item);
    }
    return data;
  }

  /// 解析喜欢的数
  String _parseLikes(int count) {
    if (count > 1000) {
      return (count / 1000).toStringAsFixed(1) + "k";
    }
    return count.toString();
  }
}
