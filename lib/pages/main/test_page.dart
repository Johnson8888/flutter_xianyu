/*
 * @Author: 弗拉德
 * @Date: 2021-03-05 19:27:21
 * @LastEditTime: 2021-03-23 14:51:21
 * @Support: http://fulade.me
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../header/refresh_header.dart';
import '../../header/refresh_footer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../header/refresh_header.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/*
void main() => runApp(VideoPlayerApp());

class VideoPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Player Demo',
      home: VideoPlayerScreen(),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({Key key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    // _controller = VideoPlayerController.network(
    //   'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    // );
    _controller = VideoPlayerController.network(
        "https://zzwos.58cdn.com.cn/ZEXwVuTsRZb/zhuanzhuan/4d24908b2d14a6683384450a22746d53.mp4");
    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Butterfly Video'),
      ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return AspectRatio(
              // aspectRatio: _controller.value.aspectRatio,
              aspectRatio: 16 / 9,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(_controller),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

*/

class LoginVideo extends StatefulWidget {
  const LoginVideo();
  @override
  _LoginVideoState createState() => _LoginVideoState();
}

class _LoginVideoState extends State<LoginVideo> {
  // 声明视频控制器
  VideoPlayerController _controller;
  //
  final String videoUrl =
      "https://video.pearvideo.com/mp4/third/20190730/cont-1584187-10136163-164150-hd.mp4";

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
        // _controller.setVolume(0.0);
        Timer.periodic(Duration(seconds: 15), (Timer time) {
          print(time);
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.pause();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    print(width / height);
    print("mmm");
    print(MediaQuery.of(context).size.aspectRatio);
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Transform.scale(
            // scale: _controller.value.aspectRatio /
            //     MediaQuery.of(context).size.aspectRatio *
            //     1.01,
            scale: _controller.value.aspectRatio / (320 / 180) * 1.01,
            child: Center(
              child: Container(
                child: _controller.value.initialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : Text("正在初始化"),
              ),
            ),
          ),
          /*
        Positioned(
          width: MediaQuery.of(context).size.width,
          bottom: 26.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                onPressed: () {},
                child: Container(
                  height: 44.0,
                  width: 240.0,
                  child: Center(
                    child: Text(
                      "微信登录",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                color: Color(0xffFFDB2E),
                textColor: Color(0xff202326),
                elevation: 0.0,
                focusElevation: 0.0,
                highlightElevation: 0.0,
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                onPressed: () {},
                child: Container(
                  height: 44.0,
                  width: 240.0,
                  child: Center(
                    child: Text(
                      "手机号登录",
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                color: Color(0xff202326),
                textColor: Color(0xffededed),
                elevation: 0.0,
                focusElevation: 0.0,
                highlightElevation: 0.0,
              ),
              SizedBox(
                height: 60.0,
              ),
              Text(
                "我已阅读并同意《服务协议》及《隐私政策》",
                style: TextStyle(color: Colors.white, fontSize: 13.0),
              )
            ],
          ),
        ),
        */
          /*
        Positioned(
          width: MediaQuery.of(context).size.width,
          top: 80.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "登录",
                style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "视频背景登录页面",
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              )
            ],
          ),
        )
        */
        ],
      ),
    );
  }
}
