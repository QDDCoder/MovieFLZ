import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie_flz/tools/ColorTools.dart';
import 'package:video_player/video_player.dart';

import 'logic.dart';
import 'model/LookMovieModel.dart';

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
      //指定页面状态颜色
      return AnnotatedRegion(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          backgroundColor: hexToColor('#171115'),
          body: PageView.builder(
            controller: _pageController,
            itemCount: logic.movieDatas.value.data.length,
            itemBuilder: (context, index) {
              return LookMoviePlayerPage(
                itemModel: logic.movieDatas.value.data[index],
                data: widget.data,
              );
            },
            scrollDirection: Axis.vertical,
          ),
        ),
      );
    });
  }
}

class LookMoviePlayerPage extends StatefulWidget {
  // final String videoUrl;
  // final String previewImageUrl; //预览图片的地址
  final LookMovieItemModel itemModel;
  final ValueNotifierData data;

  const LookMoviePlayerPage({Key key, this.data, this.itemModel})
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
        widget.itemModel.playLink)
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
    // setState(() {});
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
          color: Color(0XFF000000),
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
        child: Image.network(widget.itemModel.cover),
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
          Align(
            alignment: Alignment(0, 1),
            child: Container(
              height: ScreenUtil().setHeight(1),
              decoration: BoxDecoration(
                boxShadow: [
                  //阴影
                  //阴影
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.3),
                      blurRadius: ScreenUtil().setHeight(400),
                      spreadRadius: ScreenUtil().setHeight(300),
                      offset: Offset(0, -1))
                ],
                gradient: LinearGradient(colors: [
                  Colors.black26,
                  Colors.black26,
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
              ),
            ),
          ),

          //title
          Container(
            padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(20),
              right: ScreenUtil().setWidth(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //左边的信息
                Expanded(child: _build_left_movie_info()),

                //右边的信息
                _build_right_action_info(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /**
   * 创建电影信息的左边信息
   */
  _build_left_movie_info() {
    return Padding(
      padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(28)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: ScreenUtil().setHeight(80)),
            child: Text(
              widget.itemModel.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white70),
            ),
          ),
          _build_movie_card(),
        ],
      ),
    );
  }

  //创建电影的卡片
  _build_movie_card() {
    return Container(
      height: ScreenUtil().setHeight(80),
      margin: EdgeInsets.only(
          right: ScreenUtil().setWidth(40), top: ScreenUtil().setWidth(24)),
      decoration: BoxDecoration(
          color: Color.fromRGBO(19, 19, 19, 1),
          borderRadius: BorderRadius.circular(ScreenUtil().setHeight(6))),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(
              ScreenUtil().setHeight(6),
            ),
            child: Container(
              width: ScreenUtil().setHeight(60),
              height: ScreenUtil().setHeight(80),
              child: Image.network(
                widget.itemModel.season?.cover ?? "",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(14)),
                  child: Text(
                    widget.itemModel.season?.title ?? '',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(2),
                ),
                Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(14)),
                  child: Text(
                    '${widget.itemModel.season?.score ?? 0.0}',
                    style: TextStyle(
                      color: Colors.indigoAccent,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: ScreenUtil().setWidth(28)),
            child: Image.asset(
              'src/icons/播放.png',
              width: ScreenUtil().setWidth(26),
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }

  /**
   * 右侧的电影信息条
   */
  _build_right_action_info() {
    return Container(
      width: ScreenUtil().setHeight(80),
      // color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //头像信息
          _build_head_info(),
          //按钮信息
          _build_action_button(icon: 'src/icons/赞.png', number: '99'),
          _build_action_button(icon: 'src/icons/消息.png', number: '99'),
          _build_action_button(icon: 'src/icons/更多.png', number: ''),
        ],
      ),
    );
  }

  Widget _build_head_info() {
    return (widget.itemModel.author?.headImgUrl ?? "") == ""
        ? Container()
        : Container(
            margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(36)),
            width: ScreenUtil().setWidth(80),
            height: ScreenUtil().setWidth(80),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    ScreenUtil().setWidth(40),
                  ),
                  child: Container(
                    width: ScreenUtil().setWidth(80),
                    child: Image.network(
                        widget.itemModel.author?.headImgUrl ?? ""),
                  ),
                ),
                Align(
                  alignment: Alignment(0.0, 1.5),
                  child: Container(
                    width: ScreenUtil().setWidth(30),
                    height: ScreenUtil().setWidth(30),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(15)),
                      color: Colors.indigoAccent,
                    ),
                    child: Icon(
                      Icons.add,
                      size: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ));
  }

  /**
   * 创建活动按钮
   */
  _build_action_button({String icon, String number}) {
    return Container(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(10), bottom: ScreenUtil().setHeight(10)),
      margin: EdgeInsets.only(
          top: ScreenUtil().setWidth(20),
          bottom: ScreenUtil().setWidth(number == "" ? 10 : 14)),
      width: ScreenUtil().setWidth(80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            width: ScreenUtil().setWidth(46),
            color: Colors.white70,
          ),
          SizedBox(
            height: ScreenUtil().setHeight(4),
          ),
          number == ""
              ? Container()
              : Text(
                  number,
                  style: TextStyle(fontSize: 10, color: Colors.white70),
                ),
        ],
      ),
    );
  }
}
