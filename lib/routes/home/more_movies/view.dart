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
  int _seriesId = 0;

  double _bar_optation = 0;

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
          childWidget: _build_list_widget(),
        ),
      ),
    );
  }

  _build_list_widget() {
    //listView 嵌套 主要是 顶部和list有嵌套覆盖
    return
        //   ListView.builder(
        //   itemCount: 1,
        //   itemBuilder: (context, index) {
        //     return Obx(() {
        //       return Stack(
        //         children: [
        //           ///顶部的信息
        //           MoreMoviesListViewTopWidget(
        //             title: logic.movieModel.value.title,
        //             subTitle: logic.movieModel.value.subTitle,
        //             totalTitle: '共 ${logic.movieModel.value.total}部',
        //             coverUrl: logic.movieModel.value?.content.length > 0
        //                 ? logic.movieModel.value?.content?.first.coverUrl
        //                 : '',
        //             backAction: () {
        //               Get.back();
        //             },
        //           ),
        //
        //           ///底部的ListView
        //           MoreMoviesListViewListWidget(
        //             content: logic.movieModel.value.content,
        //           ),
        //         ],
        //       );
        //     });
        //   },
        // );

        Stack(
      children: [
        // Positioned.fill(child: child)
        NotificationListener(
            onNotification: (ScrollNotification note) {
              if (note.metrics.pixels > 120.0 && note.metrics.pixels < 300.0) {
                setState(() {
                  _bar_optation = 1.0;
                });
              } else if ((note.metrics.pixels) >= 10.0 &&
                  (note.metrics.pixels) <= 120.0) {
                setState(() {
                  _bar_optation = (note.metrics.pixels - 10.0) / 110.0;
                });
              } else if (note.metrics.pixels < 0.0) {
                setState(() {
                  _bar_optation = 0.0;
                });
              }
              print('透明度变化===>>${_bar_optation}');
            },
            child: ListView.builder(
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
            )),

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
}
