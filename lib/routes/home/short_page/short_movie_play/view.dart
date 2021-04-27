import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:get/get.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Container(
          margin: EdgeInsets.only(
              left: ScreenUtil().setWidth(0), right: ScreenUtil().setWidth(0)),
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
      );
    });
  }

  /**
   * 顶部的信息的播放
   */
  _build_top_movie_player() {
    return Container(
      height: ScreenUtil().setHeight(400),
    );
  }

  /**
   * 中间的信息条
   */
  _build_top_movie_info() {
    return Container(
      height: 120,
      color: Colors.grey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                  top: ScreenUtil().setHeight(20),
                  left: ScreenUtil().setWidth(20),
                  right: ScreenUtil().setWidth(20)),
              child: _build_movie_name_info(),
            ),
          ),
          Divider(
            height: 1,
          ),
          Container(
            margin: EdgeInsets.only(
                top: ScreenUtil().setHeight(20),
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
    return Column(
      children: [
        //顶部的名字
        Text(logic.shortMovieInfo.value.videoDetailView?.title ?? ""),
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
                      margin:
                          EdgeInsets.only(bottom: ScreenUtil().setHeight(6)),
                      child: Text(
                        '${item.author.nickName}' + '      ${playCount}次播放',
                        style: TextStyle(color: Colors.black54, fontSize: 12),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
