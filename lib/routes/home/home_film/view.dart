import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:get/get.dart';
import 'package:movie_flz/config/RouteConfig.dart';
import 'package:movie_flz/routes/home/home_movie/Model/HomeMovieModel.dart';
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
  bool get wantKeepAlive => false;

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
          } else if (display == "SLIDE" && sectionType == "VIDEO") {
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
            //横向卡片
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
            return Column(
              children: [
                //顶部的信息条
                MovieSectionHead(
                  leftInfo: logic.homeMovieInfo.value?.sections[index].name,
                  isMore: true,
                  rightInfo:
                      logic.homeMovieInfo.value?.sections[index].moreText,
                  clickAction: () {},
                ),
                //下面的喜欢的内容
                // HorizontalListMovieWidget(
                //   sectionContents: sectionContents,
                // ),
                //专属片单的gridview
                _build_exclusive_film_list(
                    logic.homeMovieInfo.value?.sections[index].sectionContents),
              ],
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
            return _build_category_items(
                logic.homeMovieInfo.value?.sections[index].sectionContents);
          } else {
            return Text('hahah2222');
          }
        },
      ),
    );
  }

  /**
   * 专属片单
   */
  _build_exclusive_film_list(List<SectionContents> list) {
    return Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20)),
      child: GridView.builder(
          //屏蔽无限高度
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), //禁用滑动事件
          itemCount: list.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //数量
              crossAxisCount: 2,
              //横向间隔
              crossAxisSpacing: ScreenUtil().setWidth(10),
              //纵向间隔
              mainAxisSpacing: ScreenUtil().setWidth(10),
              //宽高比
              childAspectRatio: 1.04),
          itemBuilder: (context, index) {
            return _build_exclusive_film_list_item_card(list[index]);
          }),
    );
  }

  //专属片单的itemcard
  _build_exclusive_film_list_item_card(SectionContents sectionContents) {
    return Container(
      color: Colors.red,
      child: Row(
        children: [
          _build_left_images(sectionContents.series),
        ],
      ),
    );
  }

  _build_left_images(List<Series> seriesList) {
    return Container(
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          _build_left_image_widget(
              0.8, ScreenUtil().setWidth(110), seriesList[2].coverUrl),
          _build_left_image_widget(
              0.9, ScreenUtil().setWidth(50), seriesList[1].coverUrl),
          _build_left_image_widget(
              1.0, ScreenUtil().setWidth(0), seriesList[0].coverUrl),
        ],
      ),
    );
  }

  _build_left_image_widget(double scale, double ml, String coverImag) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: EdgeInsets.only(
          left: ml,
        ),
        width: ScreenUtil().setWidth(140 * scale),
        height: ScreenUtil().setHeight(148 * scale),
        child: Stack(
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: coverImag,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1 - scale, sigmaY: 1 - scale),
                child: Container(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _build_category_items(List<SectionContents> sections) {
    return Container(
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(40),
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30)),
      height: ScreenUtil().setHeight(156),
      //category的模块儿
      child: CategoryWidget(
        space: MainAxisAlignment.spaceBetween,
        iconSize: Size(ScreenUtil().setWidth(90), ScreenUtil().setWidth(90)),
        click_action: (jumpAction) {
          var jumpUrl =
              jumpAction.toString().replaceAll('rrspjump://', '/home/');
          if (jumpUrl.contains('seasonRank')) {
            Get.toNamed(jumpUrl, arguments: {'sectionId': 3177});
          } else {
            Get.toNamed(jumpUrl);
          }
        },
        sectionContents: sections ?? [],
      ),
    );
  }
}
