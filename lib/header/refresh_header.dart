/*
 * @Author: 弗拉德
 * @Date: 2021-03-23 10:28:31
 * @LastEditTime: 2021-03-27 15:15:50
 * @Support: http://fulade.me
 */
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;
import 'package:lottie/lottie.dart';

class LottieHeader extends RefreshIndicator {
  LottieHeader() : super(height: 80.0, refreshStyle: RefreshStyle.Follow);
  @override
  State<StatefulWidget> createState() {
    return LottieHeaderState();
  }
}

class LottieHeaderState extends RefreshIndicatorState<LottieHeader>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
  }

  @override
  void onModeChange(RefreshStatus mode) {
    if (mode == RefreshStatus.refreshing) {
      _animationController.repeat(
          min: 80, max: 100, period: Duration(milliseconds: 500));
    }
    super.onModeChange(mode);
  }

  @override
  Future<void> endRefresh() {
    _animationController.value = 30;
    return _animationController.animateTo(150,
        duration: Duration(milliseconds: 500));
  }

  @override
  void resetValue() {
    _animationController.value = 0;
    super.resetValue();
  }

  @override
  Widget buildContent(BuildContext context, RefreshStatus mode) {
    return Lottie.asset(
      "assets/if_refresh.json",
      width: 60,
      height: 60,
      controller: _animationController,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
