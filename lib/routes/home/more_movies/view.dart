import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie_flz/routes/home/views/HomeMovieView.dart';
import 'package:movie_flz/tools/ColorTools.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'logic.dart';

class MoreMoviesPage extends StatefulWidget {
  @override
  _MoreMoviesPageState createState() => _MoreMoviesPageState();
}

class _MoreMoviesPageState extends State<MoreMoviesPage> {
  final MoreMoviesLogic logic = Get.put(MoreMoviesLogic());
  int _seriesId = 0;
  @override
  void initState() {
    //String 转Int
    _seriesId = int.parse(Get.arguments['id']);
    logic.getMoreMoviesList(id: _seriesId, refresh: true);
    super.initState();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _onRefresh() async {
    await logic.getMoreMoviesList(id: _seriesId, refresh: true).then((value) {
      _refreshController.refreshCompleted();
    });
  }

  _onLoading() async {
    await logic.getMoreMoviesList(id: _seriesId, refresh: false).then((value) {
      if (logic.movieModel.value.total ==
          logic.movieModel.value.content.length) {
        //停止刷新
        _refreshController.loadNoData();
      } else {
        _refreshController.loadComplete();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //去除ListView的顶部空白
      body: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        //创建ListView
        child: PullAndPushWidget(
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            childWidget: _build_list_widget()),
      ),
    );
    // return Obx(() {
    //
    // });
  }

  _build_list_widget() {
    //listView 嵌套 主要是 顶部和list有嵌套覆盖
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            _build_head_widget(),
            _build_list_in_widget(),
          ],
        );
      },
    );
  }

  _build_list_in_widget() {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(380)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(ScreenUtil().setWidth(10)),
            topLeft: Radius.circular(ScreenUtil().setWidth(10))),
        color: Colors.white,
      ),
      child: Obx(() {
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), //禁用滑动事件
          itemCount: (logic.movieModel.value?.content?.length ?? 0),
          itemBuilder: (context, index) {
            return GessYouLikeListItemWidget(
              model: logic.movieModel.value?.content[index],
            );
          },
        );
      }),
    );
  }

  Widget _build_head_widget() {
    return Obx(() {
      return Container(
        width: double.infinity,
        height: ScreenUtil().setHeight(406),
        child: Stack(
          children: [
            //背景图片
            _build_bg_widget(),
            //背景遮罩层
            _build_blure_widget(),

            //顶部的工具条
            _build_top_tools(),
            //中间的信息
            _build_center_info(),

            //底部的数量
            _build_bottom_info(),
          ],
        ),
      );
    });
  }

  _build_bg_widget() {
    return Positioned.fill(
      child: logic.movieModel.value?.content.length > 0
          ? Image.network(
              logic.movieModel.value?.content[0]?.coverUrl,
              fit: BoxFit.cover,
            )
          : Container(),
    );
  }

  _build_blure_widget() {
    return Positioned.fill(
        child: Container(
      decoration: BoxDecoration(
        //设置一个渐变的背景
        gradient: LinearGradient(
          //修改一下方向
          //开始
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            hexToColor('#505A6A').withOpacity(0.9),
            hexToColor('#505A6A').withOpacity(0.5)
          ],
        ),
      ),
    ));
  }

  _build_top_tools() {
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().statusBarHeight + ScreenUtil().setHeight(10),
          left: ScreenUtil().setWidth(10),
          right: ScreenUtil().setWidth(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                //页面返回
                Get.back();
              }),
          IconButton(
              icon: Icon(
                Icons.share,
                color: Colors.white,
              ),
              onPressed: () {}),
        ],
      ),
    );
  }

  _build_center_info() {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(20), top: ScreenUtil().setHeight(0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(2)),
            child: Text(
              logic.movieModel.value.title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Text(
            logic.movieModel.value.subTitle,
            style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  _build_bottom_info() {
    return Align(
      alignment: Alignment(-1, 0.64),
      child: Padding(
        padding: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
        child: Text(
          '共 ${logic.movieModel.value.total}部',
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}
