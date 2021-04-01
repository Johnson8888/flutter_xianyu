/*
 * @Author: 弗拉德
 * @Date: 2021-04-01 22:20:14
 * @LastEditTime: 2021-04-01 22:21:02
 * @Support: http://fulade.me
 */
import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'video_widget.dart';

class VideoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        InViewNotifierList(
          scrollDirection: Axis.vertical,
          initialInViewIds: ['0'],
          isInViewPortCondition:
              (double deltaTop, double deltaBottom, double viewPortDimension) {
            return deltaTop < (0.5 * viewPortDimension) &&
                deltaBottom > (0.5 * viewPortDimension);
          },
          itemCount: 10,
          builder: (BuildContext context, int index) {
            return Container(
              width: double.infinity,
              height: 300.0,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 50.0),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return InViewNotifierWidget(
                    id: '$index',
                    builder:
                        (BuildContext context, bool isInView, Widget child) {
                      return VideoWidget(
                          play: isInView,
                          url:
                              'https://zzwos.58cdn.com.cn/ZEXwVuTsRZb/zhuanzhuan/b0d0a24b67099d467b5f352ce7adb0ea.mp4');
                    },
                  );
                },
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 1.0,
            color: Colors.redAccent,
          ),
        )
      ],
    );
  }
}
