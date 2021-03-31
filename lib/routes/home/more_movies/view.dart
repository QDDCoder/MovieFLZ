import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:get/get.dart';
import 'package:movie_flz/routes/home/home_root/views/HomeMovieView.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'logic.dart';

class MoreMoviesPage extends StatefulWidget {
  @override
  _MoreMoviesPageState createState() => _MoreMoviesPageState();
}

class _MoreMoviesPageState extends State<MoreMoviesPage> {
  final MoreMoviesLogic logic = Get.put(MoreMoviesLogic());

  ScrollController _scrollController = ScrollController();

  int _seriesId = 0;

  double _bar_optation = 0;

  @override
  void initState() {
    super.initState();
    //String 转Int
    _seriesId = int.parse(Get.arguments['id']);
    //处理是否加载更多
    logic.getMoreMoviesList(id: _seriesId, refresh: true).then((value) {
      if (logic.movieModel.value.total ==
          logic.movieModel.value.content.length) {
        //停止刷新
        _refreshController.loadNoData();
      }
    });

    //监听ListView的滚动监听
    _scrollController.addListener(() {
      if (_scrollController.offset > 120.0 &&
          _scrollController.offset < 300.0) {
        setState(() {
          _bar_optation = 1.0;
        });
      } else if ((_scrollController.offset) >= 10.0 &&
          (_scrollController.offset) <= 120.0) {
        setState(() {
          _bar_optation = (_scrollController.offset - 10.0) / 110.0;
        });
      } else if (_scrollController.offset < 0.0) {
        setState(() {
          _bar_optation = 0.0;
        });
      }
    });
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _onRefresh() async {
    await logic.getMoreMoviesList(id: _seriesId, refresh: true).then((value) {
      if (logic.movieModel.value.total ==
          logic.movieModel.value.content.length) {
        //停止刷新
        _refreshController.loadNoData();
      }
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
        child: _build_list_widget(),
      ),
    );
  }

  _build_list_widget() {
    //listView 嵌套 主要是 顶部和list有嵌套覆盖
    return Stack(
      children: [
        //ListView
        PullAndPushWidget(
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          childWidget: _build_list_view(),
        ),
        //透明度的bar
        Opacity(
          opacity: _bar_optation,
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
            height: 62 + ScreenUtil().statusBarHeight,
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black45),
              title: Text(
                logic.movieModel.value.title,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        )
      ],
    );
  }

  _build_list_view() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: 1,
      itemBuilder: (context, index) {
        return Obx(() {
          return Stack(
            children: [
              ///顶部的信息
              MoreMoviesListViewTopWidget(
                title: logic.movieModel.value.title,
                subTitle: logic.movieModel.value.subTitle,
                totalTitle: '共 ${logic.movieModel.value.total}部',
                coverUrl: logic.movieModel.value?.content.length > 0
                    ? logic.movieModel.value?.content?.first.coverUrl
                    : '',
                backAction: () {
                  Get.back();
                },
              ),

              ///底部的ListView
              MoreMoviesListViewListWidget(
                content: logic.movieModel.value.content,
              ),
            ],
          );
        });
      },
    );
  }
}
