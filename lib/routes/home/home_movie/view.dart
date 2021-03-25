import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';

import 'Model/HomeMovieModel.dart';
import 'logic.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  final HomeMovieLogic logic = Get.put(HomeMovieLogic());

  @override
  void initState() {
    // TODO: implement initState
    logic.getMovieInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        ////0x 后面开始 两位FF表示透明度16进制，之后的0099ff 代表RGB色值
        color: Color(0xFFefefef),
        child: ListView(
          children: [
            _build_top_info_widget(),
            _build_list_movie_info(),
          ],
        ),
      );
    });
  }

  _build_top_info_widget() {
    return Column(
      children: [
        _build_swiper_widget(),
        _build_guess_like(),
      ],
    );
  }

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

  _build_swiper() {
    return logic.homeMovieInfo.value.bannerTop == null
        ? Container()
        : _build_swiwper_widget();
  }

  _build_swiwper_widget() {
    return Container(
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().setHeight(360),
      child: Swiper(
        key: UniqueKey(),
        itemBuilder: (BuildContext context, int index) {
          // 配置图片地址
          return new Image.network(
            logic.homeMovieInfo.value.bannerTop[index].imgUrl,
            fit: BoxFit.fill,
          );
        },
        // 配置图片数量
        itemCount: logic.homeMovieInfo.value.bannerTop == null
            ? 0
            : logic.homeMovieInfo.value.bannerTop.length,
        // 底部分页器
        pagination: SwiperPagination(
            alignment: Alignment(0.86, 0.6),
            builder: DotSwiperPaginationBuilder(
                space: ScreenUtil().setWidth(6),
                color: Colors.grey,
                activeColor: Colors.white70,
                size: ScreenUtil().setWidth(10),
                activeSize: ScreenUtil().setWidth(10))),
        // 无限循环
        loop: true,
        // 自动轮播
        autoplay: true,
        //时间间隔
        autoplayDelay: 5000,
        //动画执行时间
        duration: 800,
      ),
    );
  }

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
        ));
  }

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: logic.homeMovieInfo.value?.bean?.sectionContents
                ?.map((e) => _build_home_category_item(e.title, e.icon))
                ?.toList() ??
            [],
      ),
    );
  }

  Widget _build_home_category_item(String title, String iconUrl) {
    return Expanded(
        child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            iconUrl,
            width: ScreenUtil().setWidth(50),
          ),
          Container(
            margin: EdgeInsets.only(top: ScreenUtil().setHeight(8)),
            child: Text(title),
          ),
        ],
      ),
    ));
  }

  ///猜你喜欢
  _build_guess_like() {
    return Column(
      children: [
        //顶部的信息条
        _build_guess_like_top(
          logic.homeMovieInfo.value.guessFavorite?.name ?? "",
          true,
          logic.homeMovieInfo.value.guessFavorite?.moreText ?? "",
        ),
        //下面的喜欢的内容
        _build_guess_like_movie(),
      ],
    );
  }

  _build_guess_like_top(String leftInfo, bool isMore, String rightInfo) {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
      height: ScreenUtil().setHeight(60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
            child: Text(
              leftInfo,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
          ),
          Visibility(
            visible: isMore,
            child: GestureDetector(
              onTap: () {
                print("更多猜你喜欢");
              },
              child: Container(
                margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                child: Row(
                  children: [
                    Text(
                      rightInfo,
                      style: TextStyle(fontSize: 13),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: ScreenUtil().setWidth(30),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _build_guess_like_movie() {
    return Container(
      height: ScreenUtil().setHeight(300),
      child: RepaintBoundary(
        //边距和填充
        child: ListView.separated(
          itemCount: logic.homeMovieInfo.value?.guessFavorite?.sectionContents
                  ?.length ??
              0,
          itemBuilder: (context, index) {
            return _build_quess_like_movie_item(
                logic
                    .homeMovieInfo.value?.guessFavorite?.sectionContents[index],
                false);
          },
          //头尾间隔
          padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(20),
              right: ScreenUtil().setWidth(20)),
          scrollDirection: Axis.horizontal,
          //item 间隔
          separatorBuilder: (context, index) {
            return SizedBox(
              width: ScreenUtil().setWidth(10),
            );
          },
        ),
      ),
    );
  }

  _build_quess_like_movie_item(
      SectionContents sectionContents, bool grid_view_width) {
    return Container(
      width: ScreenUtil().setWidth(grid_view_width ? 0 : 200),
      height: ScreenUtil().setHeight(grid_view_width ? 0 : 220),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //顶部大图
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(6)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(20)),
                child: Stack(
                  children: [
                    //背景图
                    Positioned.fill(
                      child: Image.network(
                        sectionContents.coverUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                    //关注按钮
                    Container(
                      width: ScreenUtil().setWidth(50),
                      height: ScreenUtil().setWidth(50),
                      decoration: BoxDecoration(
                        color: Colors.white38.withOpacity(0.3),
                        borderRadius: BorderRadius.only(
                            bottomRight:
                                Radius.circular(ScreenUtil().setWidth(20))),
                      ),
                      child: Icon(
                        Icons.favorite_border,
                        color: Color(0xffefefef),
                        size: ScreenUtil().setWidth(36),
                      ),
                    ),

                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: ScreenUtil().setHeight(1),
                        width: ScreenUtil().setWidth(200),
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          boxShadow: [
                            //阴影
                            BoxShadow(
                                color: Colors.black54,
                                blurRadius: ScreenUtil().setHeight(20),
                                spreadRadius: ScreenUtil().setHeight(20),
                                offset: Offset(0, -ScreenUtil().setHeight(10)))
                          ],
                          gradient: LinearGradient(
                              colors: [
                                Colors.black54,
                                Colors.black54,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Text(
                        '${sectionContents.score}',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xffefefef),
                            fontWeight: FontWeight.w600),
                      ),
                      bottom: ScreenUtil().setHeight(10),
                      right: ScreenUtil().setWidth(12),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //     Container(
          //       // width: ScreenUtil().setWidth(200),
          //       // height: ScreenUtil().setHeight(220),
          // width: double.infinity,
          //   height: double.infinity,
          //       margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(6)),
          //       child: ClipRRect(
          //         borderRadius: BorderRadius.circular(ScreenUtil().setWidth(20)),
          //         child: Stack(
          //           children: [
          //             //背景图
          //             Positioned.fill(
          //               child: Image.network(
          //                 sectionContents.coverUrl,
          //                 fit: BoxFit.fill,
          //               ),
          //             ),
          //             //关注按钮
          //             Container(
          //               width: ScreenUtil().setWidth(50),
          //               height: ScreenUtil().setWidth(50),
          //               decoration: BoxDecoration(
          //                 color: Colors.white38.withOpacity(0.3),
          //                 borderRadius: BorderRadius.only(
          //                     bottomRight:
          //                         Radius.circular(ScreenUtil().setWidth(20))),
          //               ),
          //               child: Icon(
          //                 Icons.favorite_border,
          //                 color: Color(0xffefefef),
          //                 size: ScreenUtil().setWidth(36),
          //               ),
          //             ),
          //
          //             Positioned(
          //               bottom: 0,
          //               child: Container(
          //                 height: ScreenUtil().setHeight(1),
          //                 width: ScreenUtil().setWidth(200),
          //                 alignment: Alignment.bottomCenter,
          //                 decoration: BoxDecoration(
          //                   boxShadow: [
          //                     //阴影
          //                     BoxShadow(
          //                         color: Colors.black54,
          //                         blurRadius: ScreenUtil().setHeight(20),
          //                         spreadRadius: ScreenUtil().setHeight(20),
          //                         offset: Offset(0, -ScreenUtil().setHeight(10)))
          //                   ],
          //                   gradient: LinearGradient(
          //                       colors: [
          //                         Colors.black54,
          //                         Colors.black54,
          //                       ],
          //                       begin: Alignment.topCenter,
          //                       end: Alignment.bottomCenter),
          //                 ),
          //               ),
          //             ),
          //             Positioned(
          //               child: Text(
          //                 '${sectionContents.score}',
          //                 style: TextStyle(
          //                     fontSize: 16,
          //                     color: Color(0xffefefef),
          //                     fontWeight: FontWeight.w600),
          //               ),
          //               bottom: ScreenUtil().setHeight(10),
          //               right: ScreenUtil().setWidth(12),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //底部的名称
          Text(
            sectionContents.title,
            maxLines: 1,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis, // 显示不完，就在后面显示点点
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
          ),
          //介绍
          Text(
            sectionContents.subTitle,
            maxLines: 1,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis, // 显示不完，就在后面显示点点
            style: TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ],
      ),
    );
  }

  _build_list_movie_info() {
    return ListView.builder(
      shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
      physics: NeverScrollableScrollPhysics(), //禁用滑动事件
      itemCount: logic.homeMovieInfo.value?.sections?.length ?? 0,
      itemBuilder: (context, index) {
        if (logic.homeMovieInfo.value?.sections[index].sequence == 1004) {
          return _build_other_in_look(
              logic.homeMovieInfo.value?.sections[index]);
        } else {
          return Text('hahah2222');
        }
      },
    );
  }

  Widget _build_other_in_look(Sections section) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _build_guess_like_top(section.name, false, ''),
        Padding(
          padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(20),
              right: ScreenUtil().setWidth(20)),
          child: GridView.builder(
              //屏蔽无限高度
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), //禁用滑动事件
              itemCount: section.sectionContents.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: ScreenUtil().setWidth(10),
                  mainAxisSpacing: ScreenUtil().setWidth(20),
                  childAspectRatio: ScreenUtil().setWidth(200) /
                      ScreenUtil().setHeight(220) *
                      0.8),
              itemBuilder: (context, index) {
                return _build_quess_like_movie_item(
                    section.sectionContents[index], true);
              }),
        )
      ],
    );
  }
}
