/*
 * @Author: 弗拉德
 * @Date: 2021-03-23 10:28:31
 * @LastEditTime: 2021-03-24 11:56:23
 * @Support: http://fulade.me
 */
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;
import 'package:lottie/lottie.dart';

class GifHeader1 extends RefreshIndicator {
  GifHeader1() : super(height: 80.0, refreshStyle: RefreshStyle.Follow);
  @override
  State<StatefulWidget> createState() {
    return GifHeader1State();
  }
}

class GifHeader1State extends RefreshIndicatorState<GifHeader1>
    with SingleTickerProviderStateMixin {
  GifController _gifController;

  @override
  void initState() {
    _gifController = GifController(
      vsync: this,
      value: 1,
    );
    super.initState();
  }

  @override
  void onModeChange(RefreshStatus mode) {
    if (mode == RefreshStatus.refreshing) {
      _gifController.repeat(
          min: 0, max: 29, period: Duration(milliseconds: 500));
    }
    super.onModeChange(mode);
  }

  @override
  Future<void> endRefresh() {
    _gifController.value = 30;
    return _gifController.animateTo(59, duration: Duration(milliseconds: 500));
  }

  @override
  void resetValue() {
    _gifController.value = 0;
    super.resetValue();
  }

  @override
  Widget buildContent(BuildContext context, RefreshStatus mode) {
    // return GifImage(
    //   image: AssetImage("images/gifindicator1.gif"),
    //   controller: _gifController,
    //   height: 80.0,
    //   width: 537.0,
    // );
    return Lottie.asset(
      "assets/if_refresh.json",
      width: 60,
      height: 60,
    );
  }

  @override
  void dispose() {
    _gifController.dispose();
    super.dispose();
  }
}
