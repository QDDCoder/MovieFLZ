import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';

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

        //     Column(
        //   children: [
        //     //创建轮播图
        //     _build_swiper_widget(),
        //     //创建猜你喜欢
        //     _build_guess_like(),
        //   ],
        // ),
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
        _build_guess_like_top(),
        //下面的喜欢的内容
        _build_guess_like_movie(),
      ],
    );
  }

  _build_guess_like_top() {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
      height: ScreenUtil().setHeight(60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
            child: Text(
              logic.homeMovieInfo.value.guessFavorite?.name ?? "",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
          ),
          GestureDetector(
            onTap: () {
              print("更多猜你喜欢");
            },
            child: Container(
              margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
              child: Row(
                children: [
                  Text(
                    logic.homeMovieInfo.value.guessFavorite?.moreText ?? "",
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
            return _build_quess_like_movie_item(index);
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

  _build_quess_like_movie_item(int index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //顶部大图
          Container(
            width: ScreenUtil().setWidth(200),
            height: ScreenUtil().setHeight(220),
            margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(6)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(20)),
              child: Image.network(
                logic.homeMovieInfo.value?.guessFavorite?.sectionContents[index]
                    .coverUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
          //底部的名称
          Text(
            logic.homeMovieInfo.value?.guessFavorite?.sectionContents[index]
                .title,
            maxLines: 1,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis, // 显示不完，就在后面显示点点
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
          ),
          //介绍
          Text(
            logic.homeMovieInfo.value?.guessFavorite?.sectionContents[index]
                .subTitle,
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
      itemCount: 10,
      itemBuilder: (context, index) {
        return Text('hahah');
      },
    );
  }
}
