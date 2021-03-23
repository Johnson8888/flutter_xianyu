/*
 * @Author: 弗拉德
 * @Date: 2021-03-23 10:28:23
 * @LastEditTime: 2021-03-23 10:59:24
 * @Support: http://fulade.me
 */
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;

class GifFooter1 extends StatefulWidget {
  GifFooter1() : super();

  @override
  State<StatefulWidget> createState() {
    return _GifFooter1State();
  }
}

class _GifFooter1State extends State<GifFooter1>
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomFooter(
      height: 80,
      builder: (context, mode) {
        return GifImage(
          image: AssetImage("images/gifindicator1.gif"),
          controller: _gifController,
          height: 80.0,
          width: 537.0,
        );
      },
      loadStyle: LoadStyle.ShowWhenLoading,
      onModeChange: (mode) {
        if (mode == LoadStatus.loading) {
          _gifController.repeat(
              min: 0, max: 29, period: Duration(milliseconds: 500));
        }
      },
      endLoading: () async {
        _gifController.value = 30;
        return _gifController.animateTo(59,
            duration: Duration(milliseconds: 500));
      },
    );
  }

  @override
  void dispose() {
    _gifController.dispose();
    super.dispose();
  }
}
