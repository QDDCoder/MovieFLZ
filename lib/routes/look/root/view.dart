import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import 'logic.dart';

class LookPage extends StatefulWidget {
  @override
  _LookPageState createState() => _LookPageState();
}

class _LookPageState extends State<LookPage> {
  final LookLogic logic = Get.put(LookLogic());
  PageController _pageController = PageController();
  @override
  void initState() {
    // TODO: implement initState
    logic.movieDatasList();
    _pageController.addListener(() {
      if (_pageController.page == logic.movieDatas.value.data.length - 2) {
        logic.movieDatasList();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.black87,
        body: PageView.builder(
          controller: _pageController,
          itemCount: logic.movieDatas.value.data.length,
          itemBuilder: (context, index) {
            return LookMoviePlayerPage(
              videoUrl: logic.movieDatas.value.data[index].playLink,
              previewImageUrl: logic.movieDatas.value.data[index].cover,
            );
          },
          scrollDirection: Axis.vertical,
        ),
      );
    });
  }
}

class LookMoviePlayerPage extends StatefulWidget {
  final String videoUrl;
  final String previewImageUrl; //预览图片的地址

  const LookMoviePlayerPage({Key key, this.videoUrl, this.previewImageUrl})
      : super(key: key);

  @override
  _LookMoviePlayerPageState createState() => _LookMoviePlayerPageState();
}

class _LookMoviePlayerPageState extends State<LookMoviePlayerPage> {
  VideoPlayerController _controller;
  bool videoPrepared = false; //视频是否初始化
  double aspectRatio = 1;
  Future _initializeVideoPlayerFuture;
  @override
  void initState() {
    print("创建了啊哈====>>>");
    // TODO: implement initState
    _controller = VideoPlayerController.network(//定义连接器内容，这里初学者可能有点难懂下面详细讲
        widget.videoUrl)
      ..initialize().then((a) {
        _controller.play();
        videoPrepared = true;
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    aspectRatio = _controller.value.aspectRatio;
    return Stack(
      children: <Widget>[
        Container(
          color: Color(0XFF333333),
          child: GestureDetector(
            child: Stack(
              children: <Widget>[
                _controller.value.isInitialized
                    ? Center(
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ],
            ),
            onTap: () {
              if (_controller.value.isPlaying) {
                _controller.pause();
                // _hideActionButton = false;
                // setState(() {});
              } else {
                _controller.play();
                // _hideActionButton = true;
                // setState(() {});
              }
            },
          ),
        ),
        _getPreviewImage(), //预览图
      ],
    );
  }

  _getPreviewImage() {
    return Visibility(
      visible: !videoPrepared,
      child: Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        child: Image.network(widget.previewImageUrl),
      ),
    );

  }
}
