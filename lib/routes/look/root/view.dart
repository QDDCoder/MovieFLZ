import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie_flz/tools/ColorTools.dart';
import 'package:video_player/video_player.dart';

import 'logic.dart';

class ValueNotifierData extends ValueNotifier<bool> {
  ValueNotifierData(value) : super(value);
}

class LookPage extends StatefulWidget {
  final ValueNotifierData data;
  const LookPage({Key key, this.data}) : super(key: key);

  @override
  _LookPageState createState() => _LookPageState();
}

class _LookPageState extends State<LookPage>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

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
        backgroundColor: hexToColor('#171115'),
        body: PageView.builder(
          controller: _pageController,
          itemCount: logic.movieDatas.value.data.length,
          itemBuilder: (context, index) {
            return LookMoviePlayerPage(
              videoUrl: logic.movieDatas.value.data[index].playLink,
              previewImageUrl: logic.movieDatas.value.data[index].cover,
              data: widget.data,
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

  final ValueNotifierData data;

  const LookMoviePlayerPage(
      {Key key, this.videoUrl, this.previewImageUrl, this.data})
      : super(key: key);

  @override
  _LookMoviePlayerPageState createState() => _LookMoviePlayerPageState();
}

class _LookMoviePlayerPageState extends State<LookMoviePlayerPage> {
  VideoPlayerController _controller;
  bool videoPrepared = false; //视频是否初始化
  double aspectRatio = 1;
  @override
  void initState() {
    // TODO: implement initState
    _controller = VideoPlayerController.network(//定义连接器内容，这里初学者可能有点难懂下面详细讲
        widget.videoUrl)
      ..initialize().then((a) {
        if (widget.data.value) {
          _controller.play();
        } else {
          _controller.pause();
        }
        videoPrepared = true;
        setState(() {});
      });

    widget.data.addListener(_handleValueChanged);

    super.initState();
  }

  void _handleValueChanged() {
    if (widget.data.value) {
      _controller.play();
    } else {
      _controller.pause();
    }
    setState(() {});
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
                    ? _build_video_body()
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ],
            ),
            onTap: () {
              if (_controller.value.isPlaying) {
                _controller.pause();
              } else {
                _controller.play();
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

  //中间的视频数据
  Widget _build_video_body() {
    return Container(
      child: Stack(
        children: [
          //视频播放的
          Center(
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          ),
          //title
          Align(
            alignment: Alignment(-0.3, 0.7),
            child: Text('啊哈哈哈'),
          ),
        ],
      ),
    );
  }
}
