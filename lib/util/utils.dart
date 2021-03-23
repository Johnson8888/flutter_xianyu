/*
 * @Author: 弗拉德
 * @Date: 2021-03-23 20:08:04
 * @LastEditTime: 2021-03-23 20:09:31
 * @Support: http://fulade.me
 */
import 'dart:math';
import 'dart:convert';
import 'dart:async';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class Utils {
  /// 随机一个时间
  static String getRandomTimeTag() {
    int value = Random().nextInt(7);
    if (value == 1) {
      return "5分钟前";
    }
    if (value == 2) {
      return "10分钟前";
    }
    if (value == 3) {
      return "30分之前";
    }
    if (value == 4) {
      return "1小时前";
    }
    if (value == 5) {
      return "1天前";
    }
    int nowSeconds = (DateTime.now().millisecondsSinceEpoch / 1000).toInt();
    int timestamp = nowSeconds - 60 * 60 * 24 * 3;
    var format = DateFormat('yyyy-MM-dd');
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return format.format(date);
  }
}
