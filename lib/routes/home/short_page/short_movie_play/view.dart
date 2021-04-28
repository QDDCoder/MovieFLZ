import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:get/get.dart';
import 'package:movie_flz/tools/ColorTools.dart';
import 'package:video_player/video_player.dart';

import 'logic.dart';
import 'model/ShortMovieDetailModel.dart';

class ShortMoviePlayPage extends StatefulWidget {
  @override
  _ShortMoviePlayPageState createState() => _ShortMoviePlayPageState();
}

class _ShortMoviePlayPageState extends State<ShortMoviePlayPage> {
  final ShortMoviePlayLogic logic = Get.put(ShortMoviePlayLogic());

  int _movieId = 0;

  @override
  void initState() {
    // TODO: implement initState
    _movieId = Get.arguments['movieId'];

    logic.getShortMovieInfo(movieId: _movieId);
    logic.getShortWatchMovieInfo(movieId: _movieId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnnotatedRegion(
          value: SystemUiOverlayStyle.light,
          child: Scaffold(
            backgroundColor: hexToColor('#f9f9f9'),
            body: Container(
              margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(0),
                  right: ScreenUtil().setWidth(0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //顶部的视频
                  _build_top_movie_player(),
                  //相关的视频
                  _build_bottom_movies(),
                ],
              ),
            ),
          ));
    });
  }

  /**
   * 顶部的信息的播放
   */
  _build_top_movie_player() {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
      height: ScreenUtil().setHeight(430),
      child: logic.shortWatchModel.value.m3u8 == null
          ? Container()
          : ShortWatchPlayer(
              video_link: logic.shortWatchModel.value.m3u8.webUrl,
              video_cover_link:
                  logic.shortMovieInfo.value.videoDetailView?.cover ?? '',
            ),
    );
  }

  /**
   * 中间的信息条
   */
  _build_top_movie_info() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
                top: ScreenUtil().setHeight(20),
                left: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(20),
                bottom: ScreenUtil().setHeight(40)),
            child: _build_movie_name_info(),
          ),
          Divider(
            height: 1,
          ),
          Container(
            margin: EdgeInsets.only(
                top: ScreenUtil().setHeight(24),
                left: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(20)),
            child: Text(
              '相关视频',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  /**
   * 电影的名字信息等
   */
  _build_movie_name_info() {
    int viewCount =
        (logic.shortMovieInfo.value.videoDetailView?.viewCount ?? 0);
    String playCount = viewCount >= 10000
        ? (viewCount / 10000.0).toStringAsFixed(1) + 'w'
        : '${viewCount}';
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///顶部的名字
          Container(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  logic.shortMovieInfo.value.videoDetailView?.title ?? "",
                  maxLines: logic.clickmore.value ? 2 : 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
              ),
              GestureDetector(
                onTap: () {
                  logic.changeClickMore();
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: ScreenUtil().setWidth(10),
                      top: ScreenUtil().setHeight(5)),
                  child: Image.asset(
                    logic.clickmore.value
                        ? 'src/icons/向上.png'
                        : 'src/icons/向下.png',
                    width: ScreenUtil().setWidth(40),
                  ),
                ),
              ),
            ],
          )),

          ///播放量
          Container(
            margin: EdgeInsets.only(
                top: ScreenUtil().setHeight(logic.clickmore.value ? 14 : 6)),
            child: Text(
              '${playCount}播放',
              style: TextStyle(color: Colors.black54, fontSize: 12),
            ),
          ),

          _build_center_more_info(),

          ///作者和收藏分享
          ///
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(24)),
            child: Row(
              children: [
                ///左侧的作者信息
                _movie_info_author(),
                Expanded(child: Container()),

                ///右侧的收藏量和分享
                _build_collect(
                    iconString: 'src/icons/收藏.png',
                    count:
                        '${logic.shortMovieInfo.value.videoDetailView?.favCount ?? 0}'),
                SizedBox(
                  width: ScreenUtil().setWidth(40),
                ),
                _build_collect(iconString: 'src/icons/分享.png', count: ''),
              ],
            ),
          )
        ],
      );
    });
  }

  //中间的更多信息
  _build_center_more_info() {
    return Offstage(
      offstage: !logic.clickmore.value,
      child: Container(
        margin: EdgeInsets.only(top: ScreenUtil().setHeight(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //信息
            Text(
              logic.shortMovieInfo.value.videoDetailView?.brief ?? '',
              style: TextStyle(fontSize: 11.4),
            ),
            //间隔
            SizedBox(
              height: ScreenUtil().setHeight(15),
            ),
            //禁止转载
            Row(
              children: [
                Icon(
                  Icons.report_problem_outlined,
                  size: ScreenUtil().setHeight(20),
                ),
                Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(6)),
                  child: Text(
                    '未经作者授权禁止转载',
                    style: TextStyle(fontSize: 11.4),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(16),
            ),
            //标签信息
            Wrap(
              alignment: WrapAlignment.start,
              spacing: ScreenUtil().setWidth(20),
              runSpacing: ScreenUtil().setHeight(16),
              children: List.generate(
                logic.shortMovieInfo.value.videoDetailView?.tagList == null
                    ? 0
                    : logic.shortMovieInfo.value.videoDetailView.tagList.length,
                (index) {
                  return InkWell(
                    onTap: () {
                      // _controller.text = searchValue;
                    },
                    child: Container(
                      height: ScreenUtil().setHeight(44),
                      padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(24),
                          right: ScreenUtil().setWidth(24),
                          top: ScreenUtil().setHeight(6)),
                      decoration: BoxDecoration(
                          color: Colors.black12.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(
                              ScreenUtil().setHeight(22))),
                      child: Text(
                        logic.shortMovieInfo.value.videoDetailView
                            .tagList[index].name,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black45, fontSize: 12),
                      ),
                    ),
                  );
                },
              ),
            ),

            //举报视频
            Container(
              margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(18),
                  bottom: ScreenUtil().setHeight(54)),
              child: GestureDetector(
                child: Text(
                  '举报短视频',
                  style: TextStyle(
                      color: Colors.indigoAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///电影的
  _movie_info_author() {
    String headImage =
        logic.shortMovieInfo.value.videoDetailView?.author?.headImgUrl ?? '';
    return Container(
      height: ScreenUtil().setHeight(40),
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenUtil().setHeight(20)),
          color: Colors.white),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(ScreenUtil().setHeight(20)),
            child: Container(
              height: ScreenUtil().setHeight(20),
              width: ScreenUtil().setHeight(20),
              child: headImage == '' ? Container() : Image.network(headImage),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: ScreenUtil().setWidth(10),
              right: ScreenUtil().setWidth(10),
            ),
            child: Text(
              logic.shortMovieInfo.value.videoDetailView?.author?.nickName ??
                  '',
              style: TextStyle(fontSize: 12),
            ),
          ),
          Icon(
            Icons.add,
            size: ScreenUtil().setWidth(30),
          )
        ],
      ),
    );
  }

  _build_collect({String iconString, String count}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          iconString,
          width: ScreenUtil().setWidth(34),
          color: Colors.black54,
        ),
        count == ''
            ? Container()
            : Container(
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(4)),
                child: Text(
                  count,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ),
      ],
    );
  }

  /**
   * 底部的电影列表
   */
  _build_bottom_movies() {
    return Expanded(
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: CustomScrollView(
          slivers: [
            // 如果不是Sliver家族的Widget，需要使用SliverToBoxAdapter做层包裹
            SliverToBoxAdapter(child: _build_top_movie_info()),
            SliverFixedExtentList(
              itemExtent: ScreenUtil().setHeight(130),
              delegate: SliverChildBuilderDelegate(
                _build_movie_item,
                childCount:
                    logic.shortMovieInfo.value.recommendVideoList.length,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _build_movie_item(BuildContext context, int index) {
    ShortMovieRecommendVideoList item =
        logic.shortMovieInfo.value.recommendVideoList[index];
    String playCount = item.viewCount >= 10000
        ? (item.viewCount / 10000.0).toStringAsFixed(1) + 'w'
        : '${item.viewCount}';

    return Container(
      margin: EdgeInsets.only(
          top: ScreenUtil().setHeight(16),
          left: ScreenUtil().setWidth(20),
          right: ScreenUtil().setWidth(20)),
      height: ScreenUtil().setHeight(130),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //图标
          Container(
              width: ScreenUtil().setWidth(240),
              height: ScreenUtil().setHeight(140),
              margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10)),
                child: Image.network(
                  item.cover,
                  fit: BoxFit.cover,
                ),
              )),

          //名字
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(6)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(6)),
                    child: Text(
                      '${item.author.nickName}' + '      ${playCount}次播放',
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/**
 * 短视频的播放
 */
class ShortWatchPlayer extends StatefulWidget {
  final String video_link;
  final String video_cover_link;

  const ShortWatchPlayer({Key key, this.video_link, this.video_cover_link})
      : super(key: key);

  @override
  _ShortWatchPlayerState createState() => _ShortWatchPlayerState();
}

class _ShortWatchPlayerState extends State<ShortWatchPlayer> {
  VideoPlayerController _controller;
  bool videoPrepared = false; //视频是否初始化
  @override
  void initState() {
    // TODO: implement initState
    _controller = VideoPlayerController.network(//定义连接器内容，这里初学者可能有点难懂下面详细讲
        widget.video_link)
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
    return Stack(
      children: <Widget>[
        Container(
          color: Color(0XFF000000),
          child: GestureDetector(
            child: Stack(
              children: <Widget>[
                _controller.value.isInitialized
                    ? Container(
                        child: Center(
                          child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          ),
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
              } else {
                _controller.play();
              }
            },
          ),
        ),
        _getPreviewImage(),
      ],
    );
  }

  _getPreviewImage() {
    return Visibility(
      visible: !videoPrepared,
      child: widget.video_cover_link == ''
          ? Container()
          : Container(
              width: ScreenUtil().screenWidth,
              height: ScreenUtil().screenHeight,
              child: Image.network(widget.video_cover_link),
            ),
    );
  }
}
