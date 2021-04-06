import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:get/get.dart';
import 'package:movie_flz/config/RouteConfig.dart';
import 'package:movie_flz/routes/home/home_root/views/HomeMovieView.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'logic.dart';

class HomeFilmPage extends StatefulWidget {
  final String page_key;

  const HomeFilmPage({Key key, this.page_key}) : super(key: key);
  @override
  _HomeFilmPageState createState() => _HomeFilmPageState();
}

class _HomeFilmPageState extends State<HomeFilmPage>
    with AutomaticKeepAliveClientMixin {
  final HomeFilmLogic logic = Get.put(HomeFilmLogic());

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await logic.getMovieInfo(page_key: widget.page_key).then((value) {
      _refreshController.refreshCompleted();
    });
  }

  void _onLoading() async {
    await logic
        .getMovieInfo(refresh: false, page_key: widget.page_key)
        .then((value) {
      if (logic.homeMovieInfo.value.isEnd) {
        //没有更多数据了
        _refreshController.loadNoData();
      } else {
        _refreshController.loadComplete();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    print("页面返回调用了吗");
    logic.getMovieInfo(page_key: widget.page_key);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        color: Color(0xFFefefef),
        child: PullAndPushWidget(
          controller: _refreshController,
          onLoading: _onLoading,
          onRefresh: _onRefresh,
          childWidget: ListView(
            children: [
              //上半部分的
              _build_top_info_widget(),
              //下半部分list
              _build_list_movie_info()
            ],
          ),
        ),
      );
    });
  }

  /**
   * 上半部分
   */
  _build_top_info_widget() {
    return _build_swiper_widget();
  }

  /**
   * 整个轮播图模块儿
   */
  _build_swiper_widget() {
    return Container(
      height: ScreenUtil().setHeight(356),
      child: _build_swiper(),
    );
  }

  /**
   * 轮播图
   */
  _build_swiper() {
    return logic.homeMovieInfo.value.bannerTop == null
        ? Container()
        : SwiperWidget(
            alignment: Alignment(0.86, 0.94),
            images: logic.homeMovieInfo.value.bannerTop
                .map((e) => e.imgUrl)
                .toList(),
          );
  }

  /**
   * 轮播图下面的四个导航
   */
  _build_home_category() {
    return Container(
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(20),
          right: ScreenUtil().setWidth(20),
          top: ScreenUtil().setHeight(310)),
      height: ScreenUtil().setHeight(110),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            ScreenUtil().setWidth(20),
          ),
          color: Colors.white),
      //category的模块儿
      child: CategoryWidget(
        click_action: (jumpAction) {
          var jumpUrl =
              jumpAction.toString().replaceAll('rrspjump://', '/home/');
          if (jumpUrl.contains('seasonRank')) {
            Get.toNamed(jumpUrl, arguments: {'sectionId': 3177});
          } else {
            Get.toNamed(jumpUrl);
          }
        },
        sectionContents: logic.homeMovieInfo.value?.bean?.sectionContents ?? [],
      ),
    );
  }

  ///猜你喜欢
  _build_guess_like() {
    return HorizontalListMovieSectionWidget(
        clickAction: () {
          Get.toNamed(RouteConfig.ges_you_like);
        },
        leftName: logic.homeMovieInfo.value.guessFavorite?.name ?? "",
        moreText: logic.homeMovieInfo.value.guessFavorite?.moreText ?? "",
        sectionContents:
            logic.homeMovieInfo.value?.guessFavorite?.sectionContents ?? []);
  }

  /**
   * 下半部分的movie 集合
   *
   */
  _build_list_movie_info() {
    return MediaQuery.removePadding(
      //解决listview顶部有个空白的问题。
      removeTop: true,
      context: context,
      child: ListView.builder(
        shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
        physics: NeverScrollableScrollPhysics(), //禁用滑动事件
        itemCount: logic.homeMovieInfo.value?.sections?.length ?? 0,
        itemBuilder: (context, index) {
          //获取类型
          String display = logic.homeMovieInfo.value?.sections[index].display;
          String sectionType =
              logic.homeMovieInfo.value?.sections[index].sectionType;

          if (logic.homeMovieInfo.value?.sections[index].sectionContents
                  .length ==
              0) {
            return Container();
          }

          if (display == "SCROLL" && sectionType == "VIDEO") {
            return GridViewMovieWidget(
              section: logic.homeMovieInfo.value?.sections[index],
              //查看更多
              lookMore: () {
                //URL解析参数
                Uri u = Uri.parse(
                    logic.homeMovieInfo.value?.sections[index].targetId);
                String seriesId = u.queryParameters['seriesId'];
                Get.toNamed(RouteConfig.look_more_movies,
                    arguments: {'id': seriesId});
              },
              //换一批
              refush: () {
                logic.refushPeoplesLook(
                    sectionId: logic.homeMovieInfo.value?.sections[index].id);
              },
            );
          } else if (display == "SLIDE" &&
              (sectionType == "VIDEO" || sectionType == "VIDEO_AUTO")) {
            //即将上线
            return HorizontalListMovieSectionWidget(
                clickAction: () {
                  //URL解析参数
                  Uri u = Uri.parse(
                      logic.homeMovieInfo.value?.sections[index].targetId);
                  String seriesId = u.queryParameters['seriesId'];
                  Get.toNamed(RouteConfig.look_more_movies,
                      arguments: {'id': seriesId});
                },
                leftName: logic.homeMovieInfo.value?.sections[index].name ?? "",
                moreText:
                    logic.homeMovieInfo.value?.sections[index]?.moreText ?? "",
                sectionContents: logic.homeMovieInfo.value?.sections[index]
                        ?.sectionContents ??
                    []);
          } else if (display == "SLIDE" && sectionType == "SHEET") {
            //横向卡片片单
            return HorizontalListMovieCardWidget(
              moreClickAction: () {
                //查看更多
                Get.toNamed(RouteConfig.list_card_more, arguments: {
                  'title': logic.homeMovieInfo.value?.sections[index].name,
                  'sectionId': logic.homeMovieInfo.value?.sections[index].id
                });
              },
              itemClickAction: (tapIndex) {
                var id = logic.homeMovieInfo.value?.sections[index]
                    ?.sectionContents[tapIndex]?.seriesId;
                if (id != null) {
                  Get.toNamed(RouteConfig.look_more_movies,
                      arguments: {'id': '${id}'});
                }
              },
              section: logic.homeMovieInfo.value?.sections[index],
            );
          } else if (sectionType == "AD") {
            return Container();
          } else if (sectionType == 'SHEET' && display == 'SCROLL') {
            //专属片单
            return FilmListSHEETWidget(
              click_more: () {
                //查看更多
                Get.toNamed(RouteConfig.list_card_more, arguments: {
                  'title': logic.homeMovieInfo.value?.sections[index].name,
                  'sectionId': logic.homeMovieInfo.value?.sections[index].id
                });
              },
              click_item: (id) {
                Get.toNamed(RouteConfig.look_more_movies,
                    arguments: {'id': '${id}'});
              },
              sections: logic.homeMovieInfo.value?.sections[index],
            );
          } else if (sectionType == "TOP") {
            //电影榜单
            return HorizontalTopListMovieWidget(
              clickItemMore: (tapIndex) {
                //item的查看更多
                Get.toNamed(RouteConfig.top_movies_list, arguments: {
                  'sectionId': logic.homeMovieInfo.value?.sections[index]
                      ?.sectionContents[tapIndex].sectionId
                });
                //测试
                // Get.toNamed(RouteConfig.ttv);
              },
              clickRightMore: () {
                //最右边的查看更多
              },
              sections: logic.homeMovieInfo.value?.sections[index],
            );
          } else if (sectionType == "SINGLE_IMAGE") {
            return SingleImageWidget(
              click_action: () {
                //URL解析参数
                Uri u = Uri.parse(logic.homeMovieInfo.value?.sections[index]
                    .sectionContents[0].targetId);
                String navigationId = u.queryParameters['navigationId'];
                // targetId
                Get.toNamed(RouteConfig.single_image,
                    arguments: {'navigationId': navigationId});
              },
              coverImage: logic.homeMovieInfo.value?.sections[index]
                      .sectionContents[0].icon ??
                  "",
            );
          } else if (sectionType == "MAGIC_CUBE") {
            //普通的分类
            return NormalCategoryWidget(
              sections:
                  logic.homeMovieInfo.value?.sections[index].sectionContents,
            );
          } else if (sectionType == 'MULTI_IMAGE' && display == 'SLIDE') {
            //电影专栏
            return Filme_MULTI_IMAGE_Widget(
              click_item: (targetId) {
                //URL解析参数
                Uri u = Uri.parse(targetId);
                String navigationId = u.queryParameters['navigationId'];
                // targetId
                Get.toNamed(RouteConfig.single_image,
                    arguments: {'navigationId': navigationId});
              },
              sections: logic.homeMovieInfo.value?.sections[index],
            );
          } else {
            print('----->>>>${sectionType}--->>>${display}');
            return Text('hahah2222');
          }
        },
      ),
    );
  }
}
