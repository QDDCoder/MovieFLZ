import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:get/get.dart';
import 'package:movie_flz/routes/home/home_root/views/HomeMovieView.dart';
import 'package:movie_flz/tools/ColorTools.dart';
import 'package:movie_flz/tools/video/video_player_UI.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'logic.dart';
import 'model/MovieCommentModel.dart';
import 'model/ShortMovieDetailModel.dart';

class ShortMoviePlayPage extends StatefulWidget {
  @override
  _ShortMoviePlayPageState createState() => _ShortMoviePlayPageState();
}

class _ShortMoviePlayPageState extends State<ShortMoviePlayPage> {
  final ShortMoviePlayLogic logic = Get.put(ShortMoviePlayLogic());

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onLoading() async {
    await logic.getMovieCommentInfos(movieId: _movieId).then((value) {
      if (logic.movieCommentModel.value.isEnd) {
        //没有更多数据了
        _refreshController.loadNoData();
      } else {
        _refreshController.loadComplete();
      }
    });
  }

  int _movieId = 0;

  @override
  void initState() {
    // TODO: implement initState
    _movieId = Get.arguments['movieId'];

    logic.getShortMovieInfo(movieId: _movieId);
    logic.getShortWatchMovieInfo(movieId: _movieId);
    logic.getMovieCommentInfos(movieId: _movieId);
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
      height: logic.isFullScreen.value
          ? ScreenUtil().screenWidth
          : ScreenUtil().setHeight(430),
      child: logic.shortWatchModel.value.m3u8 == null
          ? Container()
          : VideoPlayerUI.network(
              url: logic.shortWatchModel.value.m3u8.webUrl,
              title: "",
              share: () async {
                // await myBottomTip(context,
                //     title: '关于', desp: '飞鱼是一个极简的播放器，它是我最近的一个Flutter项目。');
              },
              full: (bool full) async {
                logic.changeFullScreen();
                // await myBottomTip(context,
                //     title: '关于', desp: full ? '全屏--》未全屏' : '未全屏--》全屏');
              },
            ),
    );
  }

  /**
   * 中间的信息条
   */
  _build_top_movie_info(String titleInfo, {double marginTop = 24}) {
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
          _build_top_title_info(marginTop, titleInfo),
        ],
      ),
    );
  }

  _build_top_title_info(double marginTop, String titleInfo) {
    return Container(
      margin: EdgeInsets.only(
          top: ScreenUtil().setHeight(marginTop),
          left: ScreenUtil().setWidth(20),
          right: ScreenUtil().setWidth(20)),
      child: Text(
        titleInfo,
        style: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
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
        child: PullAndPushWidget(
          enablePullDown: false,
          controller: _refreshController,
          onLoading: _onLoading,
          childWidget: CustomScrollView(
            slivers: [
              // 如果不是Sliver家族的Widget，需要使用SliverToBoxAdapter做层包裹
              SliverToBoxAdapter(child: _build_top_movie_info('相关视频')),
              //相关视频
              SliverFixedExtentList(
                itemExtent: ScreenUtil().setHeight(130),
                delegate: SliverChildBuilderDelegate(
                  _build_movie_item,
                  childCount:
                      logic.shortMovieInfo.value.recommendVideoList.length,
                ),
              ),
              SliverToBoxAdapter(
                child: _build_top_title_info(50, '全部评论'),
              ),
              //全部评论
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  _build_comment_item,
                  childCount:
                      logic.movieCommentModel.value?.content?.length ?? 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /**
   * 电影的item
   */
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

  Widget _build_comment_item(BuildContext context, int index) {
    MovieCommentContent _comment = logic.movieCommentModel.value.content[index];
    return Container(
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(20),
          right: ScreenUtil().setWidth(20),
          top: ScreenUtil().setHeight(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///用户信息
          _user_info_widget(_comment),

          //评论信息
          _build_comment_infos(_comment),

          //底部的赞和更多
          _build_comment_action(_comment),

          //底部的分割线
          _build_bottom_div(),
        ],
      ),
    );
  }

  _user_info_widget(MovieCommentContent commentItem) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(30)),
          child: SizedBox(
            width: ScreenUtil().setWidth(60),
            height: ScreenUtil().setWidth(60),
            child: commentItem.author.headImgUrl == null
                ? Image.asset(
                    'src/icons/未登录头像.png',
                    color: Colors.black54,
                  )
                : Image.network(
                    commentItem.author.headImgUrl,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(10),
                  top: ScreenUtil().setHeight(2)),
              child: Row(
                children: [
                  Text(
                    commentItem.author.nickName,
                    style: TextStyle(color: Colors.black54, fontSize: 11),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: ScreenUtil().setWidth(4),
                      right: ScreenUtil().setWidth(4),
                      top: ScreenUtil().setHeight(1),
                      bottom: ScreenUtil().setHeight(1),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.indigoAccent,
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setWidth(8))),
                    margin: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                    child: Text(
                      'LV.${commentItem.author.level}',
                      style: TextStyle(color: Colors.white, fontSize: 8),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(10),
              ),
              child: Text(
                commentItem.createTimeStr,
                style: TextStyle(color: Colors.black54, fontSize: 10),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _build_comment_infos(MovieCommentContent commentItem) {
    return Container(
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(70), top: ScreenUtil().setHeight(26)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //评论的信息
          Text(commentItem.content),
          //评论的回复信息
          Offstage(
            offstage: !((commentItem.replies?.length ?? 0) > 0),
            child: MediaQuery.removePadding(
              //解决listview顶部有个空白的问题。
              removeTop: true,
              removeBottom: true,
              context: context,
              child: Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius:
                        BorderRadius.circular(ScreenUtil().setWidth(6))),
                padding: EdgeInsets.all(
                  ScreenUtil().setWidth(20),
                ),
                child: ListView.builder(
                    shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
                    physics: NeverScrollableScrollPhysics(), //禁用滑动事件
                    itemCount: commentItem.replies?.length ?? 0,
                    itemBuilder: (context, index) {
                      return _build_comment_replay_info(
                          commentItem.replies[index]);
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _build_comment_action(MovieCommentContent commentItem) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: ScreenUtil().setWidth(40),
            height: ScreenUtil().setWidth(40),
            child: Image.asset(
              'src/icons/评论赞.png',
              color: Colors.black54,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: ScreenUtil().setWidth(4),
                right: ScreenUtil().setWidth(26),
                bottom: ScreenUtil().setHeight(6)),
            child: Text(
              '${commentItem.likeCount > 0 ? '${commentItem.likeCount}' : ''}',
              style: TextStyle(fontSize: 10),
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(40),
            height: ScreenUtil().setWidth(40),
            child: Image.asset('src/icons/更多活动.png', color: Colors.black54),
          ),
        ],
      ),
    );
  }

  _build_bottom_div() {
    return Container(
      margin: EdgeInsets.only(
          top: ScreenUtil().setHeight(20), bottom: ScreenUtil().setHeight(20)),
      child: Divider(
        height: 1,
        color: Colors.black12,
      ),
    );
  }

  Widget _build_comment_replay_info(MovieCommentReplies replies) {
    return Container(
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: replies.authorName + ":  ",
            style: TextStyle(color: Colors.indigoAccent)),
        TextSpan(text: replies.content, style: TextStyle(color: Colors.black87))
      ])),
    );
  }
}
