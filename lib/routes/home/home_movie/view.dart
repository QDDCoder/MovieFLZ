import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie_flz/config/RouteConfig.dart';
import 'package:movie_flz/routes/home/views/HomeMovieView.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'logic.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage>
    with AutomaticKeepAliveClientMixin {
  final HomeMovieLogic logic = Get.put(HomeMovieLogic());

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await logic.getMovieInfo().then((value) {
      _refreshController.refreshCompleted();
    });
  }

  void _onLoading() async {
    await logic.getMovieInfo(refresh: false).then((value) {
      _refreshController.loadComplete();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    print("页面返回调用了吗");
    logic.getMovieInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        color: Color(0xFFefefef),
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropHeader(),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("pull up load");
              } else if (mode == LoadStatus.loading) {
                body = CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = Text("Load Failed!Click retry!");
              } else if (mode == LoadStatus.canLoading) {
                body = Text("release to load more");
              } else {
                body = Text("No more Data");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: ListView(
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
    return Column(
      children: [
        //轮播图
        _build_swiper_widget(),
        //猜你喜欢
        _build_guess_like(),
      ],
    );
  }

  /**
   * 整个轮播图模块儿
   */
  _build_swiper_widget() {
    return Container(
      height: ScreenUtil().setHeight(420),
      child: Stack(
        children: [
          //创建轮播图
          _build_swiper(),
          //创建轮播下面的渐变
          _build_swiper_shadow(),
          //创建四个大分类
          _build_home_category(),
        ],
      ),
    );
  }

  /**
   * 轮播图
   */
  _build_swiper() {
    return logic.homeMovieInfo.value.bannerTop == null
        ? Container()
        : SwiperWidget(
            images: logic.homeMovieInfo.value.bannerTop
                .map((e) => e.imgUrl)
                .toList(),
          );
  }

  /**
   * 轮播图下面的阴影部分
   */
  _build_swiper_shadow() {
    return Positioned(
      top: ScreenUtil().setHeight(360),
      width: ScreenUtil().screenWidth,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            //阴影
            BoxShadow(
                color: Colors.white,
                blurRadius: 16,
                spreadRadius: 20,
                offset: Offset(0, 0))
          ],
          gradient: LinearGradient(colors: [
            Colors.white70,
            Colors.white,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
      ),
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
          String display = logic.homeMovieInfo.value?.sections[index].display;
          String sectionType =
              logic.homeMovieInfo.value?.sections[index].sectionType;

          if (display == "SCROLL" && sectionType == "VIDEO") {
            return GridViewMovieWidget(
              section: logic.homeMovieInfo.value?.sections[index],
            );
          } else if (display == "SLIDE" && sectionType == "VIDEO") {
            //即将上线
            return HorizontalListMovieSectionWidget(
                leftName: logic.homeMovieInfo.value?.sections[index].name ?? "",
                moreText:
                    logic.homeMovieInfo.value?.sections[index]?.moreText ?? "",
                sectionContents: logic.homeMovieInfo.value?.sections[index]
                        ?.sectionContents ??
                    []);
          } else if (display == "SLIDE" && sectionType == "SHEET") {
            return HorizontalListMovieCardWidget(
              section: logic.homeMovieInfo.value?.sections[index],
            );
          } else if (sectionType == "AD") {
            return Container();
          } else if (sectionType == "TOP") {
            //电影榜单
            return HorizontalTopListMovieWidget(
              sections: logic.homeMovieInfo.value?.sections[index],
            );
          } else if (sectionType == "SINGLE_IMAGE") {
            return SingleImageWidget(
              coverImage: logic.homeMovieInfo.value?.sections[index]
                      .sectionContents[0].icon ??
                  "",
            );
          } else {
            return Text('hahah2222');
          }
        },
      ),
    );
  }
}
