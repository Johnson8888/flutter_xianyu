/*
 * @Author: 弗拉德
 * @Date: 2020-12-17 20:32:59
 * @LastEditTime: 2021-02-25 11:44:23
 * @Support: http://fulade.me
 */

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../../header/loading_header.dart';
import '../../header/loading_footer.dart';
import 'account_card.dart';
import 'account_deal.dart';
import 'account_header.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollController scrollController = ScrollController();

  double appBarOpacity = 0.0;
  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {});
    return Scaffold(
      body: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              // print(notification.metrics.pixels);
              // print(notification.context);
              var scrollY = notification.metrics.pixels;
              if (scrollY > 0) {
                var opacity = scrollY / 80;
                setState(() {
                  appBarOpacity = opacity <= 1 ? opacity : 1;
                });
              } else if (scrollY < 0) {
                setState(() {
                  appBarOpacity = 0;
                });
              }
              return false;
            },
            child: EasyRefresh(
              header: LoadingHeader(),
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 2), () {
                  if (mounted) {}
                });
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AccountHeader(),
                    AccountDealCard(),
                    AccountCard(
                      title: "更多",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
