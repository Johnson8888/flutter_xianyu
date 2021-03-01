/*
 * @Author: 弗拉德
 * @Date: 2021-03-01 16:14:39
 * @LastEditTime: 2021-03-01 16:37:27
 * @Support: http://fulade.me
 */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class XBTestPage extends StatefulWidget {
  @override
  _XBTestPageState createState() => _XBTestPageState();
}

class _XBTestPageState extends State<XBTestPage> {
  HoverHeaderVM _hoverVM = HoverHeaderVM();
  ScrollController _controller = ScrollController();
  List<HoverOffsetInfo> _hoverOffsetInfoList = [];
  int _hoverOffsetInfoIndex = 0;
  List _titles = _dataSource.keys.toList();
  double _lastOffset = 0;

  static Map<String, List<String>> _dataSource = {
    "2020": ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"],
    "2021": ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"],
  };

  @override
  void initState() {
    super.initState();
    _computeHoverOffsetInfo();
    _controller.addListener(() {
      double offset = _controller.offset;
      bool show = offset >= 0;
      if (_hoverVM.show != show) {
        _hoverVM.show = show;
      }
      bool upward = offset - _lastOffset > 0;
      _lastOffset = offset;

      HoverOffsetInfo offsetInfo;

      if (_hoverOffsetInfoList.length > _hoverOffsetInfoIndex) {
        offsetInfo = _hoverOffsetInfoList[_hoverOffsetInfoIndex];
//              print(
//                  "start offset:${offsetInfo.startOffset},end offset:${offsetInfo.endOffset},_hoverOffsetInfoIndex:$_hoverOffsetInfoIndex");
        if (upward) {
          ///向上滚动
          if (offset < offsetInfo.startOffset) {
            /// [sectionStartOffset,startOffset)
            if (_hoverVM.offset != 0) {
              print("1");
              _hoverVM.update(offsetInfo.prevTitle, 0);
            }
          } else if (offset > offsetInfo.endOffset) {
            ///(endOffset
            ///超过endOffset，切换到下一个offsetInfo
            print("2");
            _hoverOffsetInfoIndex++;
            if (_hoverOffsetInfoIndex >= _hoverOffsetInfoList.length) {
              _hoverOffsetInfoIndex = _hoverOffsetInfoList.length - 1;
            }
            _hoverVM.update(offsetInfo.title, 0);
          } else {
            /// [startOffset,endOffset]
            print("3");
            _hoverVM.update(
                offsetInfo.prevTitle, offset - offsetInfo.startOffset);
          }
        } else {
          ///向下滚动
          if (offset >= offsetInfo.startOffset &&
              offset <= offsetInfo.endOffset) {
            ///[startOffset,endOffset]
            _hoverVM.update(
                offsetInfo.prevTitle, offset - offsetInfo.startOffset);
            print(
                "4 _hoverVM.offset:${_hoverVM.offset},offset:$offset,offsetInfo.startOffset:${offsetInfo.startOffset}");
          } else if (offset >= offsetInfo.sectionStartOffset) {
            ///[sectionStartOffset,startOffset）
            if (_hoverVM.offset != 0) {
              print("5");
              _hoverVM.update(offsetInfo.prevTitle, 0);
            }
          } else {
            /// sectionStartOffset)
            /// 切换到上一个offsetInfo
            ///其实就是offset小于上一个offsetInfo的endOffset的情况
            print("6");
            _hoverOffsetInfoIndex--;
            if (_hoverOffsetInfoIndex < 0) {
              _hoverOffsetInfoIndex = 0;
            }
            _hoverVM.update(offsetInfo.prevTitle, 0);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) {
        return _hoverVM;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            CustomScrollView(
              controller: _controller,
              slivers: List.generate(_titles.length, (titleIndex) {
                String title = _titles[titleIndex];
                List<String> dataList = _dataSource[title];
                return SliverList(
                    delegate: SliverChildBuilderDelegate((ctx, cellIndex) {
                  if (cellIndex == 0) {
                    return Header(title);
                  } else {
                    int fixIndex = cellIndex - 1;
                    String data = dataList[fixIndex];
                    return Cell(data);
                  }
                }, childCount: dataList.length + 1));
              }),
            ),
            Consumer(builder: (ctx, HoverHeaderVM hoverVM, child) {
              return Visibility(
                visible: hoverVM.show,
                child: Header(hoverVM.title,
                    color: Colors.green, offset: -hoverVM.offset),
              );
            })
          ],
        ),
      ),
    );
  }

  //计算需要悬停的区间信息
  _computeHoverOffsetInfo() {
    _hoverOffsetInfoList.clear();
    double totalOffset = 0;
    for (var i = 0; i < _titles.length; i++) {
      ///最后一段不需要计算
      if (i != _titles.length - 1) {
        String element = _titles[i];
        List<String> dataList = _dataSource[element];

        double sectionStartOffset = totalOffset;
        double sectionOffset = dataList.length * Cell.height;
        double startOffset = sectionOffset + totalOffset;
        double endOffset = startOffset + Header.height;
        totalOffset += sectionOffset + Header.height;
        _hoverOffsetInfoList.add(HoverOffsetInfo(
            prevTitle: element,
            title: _titles[i + 1],
            startOffset: startOffset,
            endOffset: endOffset,
            sectionStartOffset: sectionStartOffset));
      }
    }
    print(_hoverOffsetInfoList);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Header extends StatelessWidget {
  static final height = 50.0;
  final String title;
  final Color color;
  final double offset;

  Header(this.title, {this.color, this.offset = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(-0.8, 0.0),
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: offset,
            child: Container(
              height: height,
              width: MediaQueryData.fromWindow(window).size.width,
              color: color ?? Colors.orange,
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Cell extends StatelessWidget {
  static final height = 80.0;
  final String title;

  Cell(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.center,
      color: Colors.black26,
      child: Column(
        children: <Widget>[
          Expanded(
              child: Container(
            alignment: Alignment.center,
            child: Text(title),
          )),
          Container(
            height: 1,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}

class HoverOffsetInfo {
  String prevTitle;
  String title;
  double startOffset;
  double endOffset;
  double sectionStartOffset;

  HoverOffsetInfo(
      {@required this.prevTitle,
      @required this.title,
      @required this.startOffset,
      @required this.endOffset,
      @required this.sectionStartOffset});

  @override
  String toString() {
    return 'HoverOffsetInfo{prevTitle: $prevTitle, title: $title, startOffset: $startOffset, endOffset: $endOffset}';
  }
}

class HoverHeaderVM extends ChangeNotifier {
  String _title = "2020";
  bool _show = true;
  double _offset = 0;

  String get title => _title;

  double get offset => _offset;

  update(String title, double offset) {
    _title = title;
    _offset = offset;
    notifyListeners();
  }

  bool get show => _show;

  set show(bool show) {
    _show = show;
    notifyListeners();
  }
}
