/*
 * @Author: 弗拉德
 * @Date: 2021-03-28 14:01:25
 * @LastEditTime: 2021-03-28 22:52:52
 * @Support: http://fulade.me
 */
import 'package:flutter/material.dart';
import './model/attention_item_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../common/utils.dart';
import '../../common/api.dart';

class ItemDetailsPage extends StatefulWidget {
  final CommonGood model;

  /// 初始化方法
  const ItemDetailsPage({Key key, this.model}) : super(key: key);

  @override
  _ItemDetailsPageState createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  /// 颜色
  String hpCon = '';
  //定义透明度
  double appBarAlpha = 1.0;

  _onScroll(offset) {
    /*
    double alpha = offset / 100;
    print(offset);
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: Container(
            child: NotificationListener(
              onNotification: (ScrollNotification notification) {
                if (notification is ScrollUpdateNotification &&
                    notification.depth == 0) {
                  _onScroll(notification.metrics.pixels);
                }
              },
              child: ListView(
                children: <Widget>[
                  /// 用戶信息 Container
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 64, 0, 0),
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  imageUrl: widget.model.userPhoto,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(widget.model.userName),
                                  Text(widget.model.specialUserDesc.desc),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Color(0xfffbababa),
                              width: 1.0,
                            ),
                          ),
                          width: 60,
                          child: Text("已关注"),
                        ),
                      ],
                    ),
                  ),

                  /// 价格 信息
                  Container(
                    width: 100,
                    child: Row(
                      children: [
                        Text(
                          "¥" +
                              ((widget.model.infoPrice / 100).toInt())
                                  .toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          "¥" +
                              ((widget.model.infoPrice / 100 - 50).toInt())
                                  .toString(),
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffbababa),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Text(
                            "包邮",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// 描述
                  Container(
                    height: 120,
                    child: Text("手机号手机号就是结婚三大件贺卡收到和风纪扣撒谎看见啥尽快好几十块的后即可收到" +
                        widget.model.infoDesc),
                  ),

                  /// 要显示的图片
                  Container(
                    child: Column(
                      children: _getImageList(),
                    ),
                  ),

                  /// 担保交易
                  Container(
                    height: 20,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 100,
                          child: Row(
                            children: [
                              Image.asset(
                                "images/detail_alipay@2x.png",
                                width: 10,
                                height: 10,
                              ),
                              Text("担保交易")
                            ],
                          ),
                        ),
                        Container(
                          width: 180,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                //width: 40,
                                child: Text("60人想要 ·"),
                              ),
                              Container(
                                // width: 40,
                                child: Text("浏览1083"),
                              ),
                              Container(
                                width: 40,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "images/detail_alipay@2x.png",
                                      width: 10,
                                      height: 10,
                                    ),
                                    Text("举报"),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //// 用户信息展示
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 80,
                          child: Column(
                            children: [
                              Text(
                                widget.model.userName,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "来咸鱼985天，卖出过3410件宝贝。90后射手座女生，IT/互联网/通信行业销售。江西财经大学毕业。",
                                style: TextStyle(),
                                maxLines: 2,
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Text("实人认证已通过"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text("芝麻信用已授权"),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        CachedNetworkImage(
                          width: 40,
                          height: 40,
                          errorWidget: (context, url, error) {
                            return Icon(Icons.error);
                          },
                          imageUrl: widget.model.userPhoto,
                        ),
                      ],
                    ),
                  ),

                  /// 留言信息
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "全部留言 · 1",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "images/image_demo.jpg",
                              width: 30,
                              height: 30,
                            ),
                            Container(
                              child: Text(
                                "看对眼就留言,问问更多细节~",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        //这里是搜索框
        //这里可以自定义组件,使用自己的头,我的是项目的
        Opacity(
          opacity: appBarAlpha, //滑动offset改变透明度
          child: Container(
            decoration: BoxDecoration(
              color: Colors.yellow,
            ),
            height: 64,
            child: AppBar(
              title: Text("Title"),
              centerTitle: true,
            ),
          ),
        )
      ],
    ));
    // );
  }

  List<Widget> _getImageList() {
    List<Widget> list = [];
    widget.model.infoCoverList.forEach(
      (element) {
        print(PIC_URL_PREFIX + element.picUrl);
        list.add(
          CachedNetworkImage(
            errorWidget: (context, url, error) {
              return Icon(Icons.error);
            },
            imageUrl: PIC_URL_PREFIX + element.picUrl,
          ),
        );
      },
    );
    return list;
  }
}
