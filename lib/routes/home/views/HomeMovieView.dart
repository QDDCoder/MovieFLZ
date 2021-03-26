/*
# @Time : 3/26/21 8:33 AM 
# @Author : 湛
# @File : HomeMovieView.py
# @Desc : ==============================================
# 打工赚不了几个钱,但打工能让你没时间花钱。
#      ┌─┐       ┌─┐
#   ┌──┘ ┴───────┘ ┴──┐
#   │       ───       │
#   │  ─┬┘       └┬─  │
#   │       ─┴─       │
#   └───┐         ┌───┘
#       │         │
#       │         └──────────────┐
#       │                        ├─┐
#       │                        ┌─┘
#       └─┐  ┐  ┌───────┬──┐  ┌──┘
#         │ ─┤ ─┤       │ ─┤ ─┤
#         └──┴──┘       └──┴──┘
#                神兽保佑
#               代码无BUG!
# ======================================================
*/

import 'dart:ui';

/**
 *
 * 首页的View的综合
 *
 *
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_star/custom_rating.dart';
import 'package:flutter_star/star.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie_flz/routes/home/home_movie/Model/HomeMovieModel.dart';
import 'package:movie_flz/tools/ColorTools.dart';

/**
 * 电影card
 */
class MovieItemCard extends StatelessWidget {
  final bool grid_view_width;
  final SectionContents sectionContents;

  const MovieItemCard({Key key, this.grid_view_width, this.sectionContents})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(grid_view_width ? 0 : 210),
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
                        fit: BoxFit.cover,
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
          Text(
            sectionContents.title,
            maxLines: 1,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis, // 显示不完，就在后面显示点点
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15),
          ),
          //介绍
          Text(
            sectionContents.subTitle,
            maxLines: 1,
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis, // 显示不完，就在后面显示点点
            style: TextStyle(
                color: Colors.black54,
                fontSize: 13,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

/**
 * 每个section顶部的信息条
 */
class MovieSectionHead extends StatelessWidget {
  final String leftInfo;
  final bool isMore;
  final String rightInfo;
  final double paddingTop;
  final bool color_rever;

  const MovieSectionHead(
      {Key key,
      this.leftInfo,
      this.isMore,
      this.rightInfo,
      this.paddingTop = 20,
      this.color_rever = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(paddingTop)),
      height: ScreenUtil().setHeight(60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
            child: Text(
              leftInfo,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: color_rever ? Colors.white : Colors.black),
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
                      style: TextStyle(
                          fontSize: 13,
                          color: color_rever ? Colors.white70 : Colors.black45),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: color_rever ? Colors.white70 : Colors.black45,
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
}

/**
 * 轮播图
 */
class SwiperWidget extends StatelessWidget {
  final List<String> images;

  const SwiperWidget({Key key, this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().setHeight(360),
      child: Swiper(
        key: UniqueKey(),
        itemBuilder: (BuildContext context, int index) {
          // 配置图片地址
          return new Image.network(
            images[index],
            fit: BoxFit.cover,
          );
        },
        // 配置图片数量
        itemCount: images.length,
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
}

/**
 * 分类导航模块
 */
class CategoryWidget extends StatelessWidget {
  final List<SectionContents> sectionContents;

  const CategoryWidget({Key key, this.sectionContents}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: sectionContents
          .map((e) => _build_home_category_item(e.title, e.icon))
          .toList(),
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
            fit: BoxFit.cover,
          ),
          Container(
            margin: EdgeInsets.only(top: ScreenUtil().setHeight(8)),
            child: Text(title),
          ),
        ],
      ),
    ));
  }
}

/**
 * 横向滚动的listView
 */
class HorizontalListMovieWidget extends StatelessWidget {
  final List<SectionContents> sectionContents;

  const HorizontalListMovieWidget({Key key, this.sectionContents})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(300),
      child: RepaintBoundary(
        //边距和填充
        child: ListView.separated(
          itemCount: sectionContents.length,
          itemBuilder: (context, index) {
            return MovieItemCard(
              sectionContents: sectionContents[index],
              grid_view_width: false,
            );
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
}

/**
 * 横向列表展示movie
 */
class GridViewMovieWidget extends StatelessWidget {
  final Sections section;

  const GridViewMovieWidget({Key key, this.section}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //信息条
        MovieSectionHead(
          leftInfo: section.name ?? "",
          isMore: false,
          rightInfo: "",
        ),
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
                  //数量
                  crossAxisCount: 3,
                  //横向间隔
                  crossAxisSpacing: ScreenUtil().setWidth(10),
                  //纵向间隔
                  mainAxisSpacing: ScreenUtil().setWidth(20),
                  //宽高比
                  childAspectRatio: ScreenUtil().setWidth(200) /
                      ScreenUtil().setHeight(220) *
                      0.8),
              itemBuilder: (context, index) {
                return MovieItemCard(
                  sectionContents: section.sectionContents[index],
                  grid_view_width: true,
                );
              }),
        ),
        //底部的按钮条
        _build_bottom_actions(),
      ],
    );
  }

  _build_bottom_actions() {
    return Container(
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(20),
          right: ScreenUtil().setWidth(20),
          top: ScreenUtil().setHeight(16)),
      height: ScreenUtil().setHeight(60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _build_button(Icons.arrow_circle_down, '查看更多'),
          SizedBox(
            width: ScreenUtil().setWidth(10),
          ),
          _build_button(Icons.refresh, '换一换'),
        ],
      ),
    );
  }

  _build_button(IconData leftIcon, String rightInfo) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: LZClickImageAndTitleBtn(
          mainAxisAlignment: MainAxisAlignment.center,
          image: Icon(
            leftIcon,
            color: Colors.indigo.shade400,
            size: ScreenUtil().setWidth(38),
          ),
          imageSize: Size(38, 38),
          title: rightInfo,
          padding: 2,
          fontSize: 15,
          textColor: Colors.black54,
          onTap: () {},
        ),
      ),
    );
  }
}

/**
 * 横向滚动的section组合
 */
class HorizontalListMovieSectionWidget extends StatelessWidget {
  final String leftName;
  final String moreText;
  final List<SectionContents> sectionContents;

  const HorizontalListMovieSectionWidget(
      {Key key, this.leftName, this.moreText, this.sectionContents})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //顶部的信息条
        MovieSectionHead(
          leftInfo: leftName,
          isMore: true,
          rightInfo: moreText,
        ),
        //下面的喜欢的内容
        HorizontalListMovieWidget(
          sectionContents: sectionContents,
        ),
      ],
    );
  }
}

/*
 *图片 + 文字按钮  icon在左 tiitle在右
 */
class LZClickImageAndTitleBtn extends StatelessWidget {
  const LZClickImageAndTitleBtn(
      {Key key,
      this.image,
      this.imageSize,
      this.title,
      this.padding,
      this.fontSize,
      this.textColor,
      this.onTap,
      this.mainAxisAlignment})
      : super(key: key);
  final Widget image; //image
  final Size imageSize; //image的宽高
  final String title; //文字
  final double padding; //图片和文字之间的间距
  final double fontSize; //文字的大小
  final Color textColor; //文字的颜色
  final onTap; //执行的方法
  final MainAxisAlignment mainAxisAlignment;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: ScreenUtil().setWidth(imageSize.width),
              height: ScreenUtil().setHeight(imageSize.height),
              child: image,
            ),
            SizedBox(
              width: ScreenUtil().setWidth(padding),
            ),
            Container(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: fontSize,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/**
 * 横向的card List的组件
 */
class HorizontalListMovieCardWidget extends StatelessWidget {
  final Sections section;

  const HorizontalListMovieCardWidget({Key key, this.section})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //顶部的信息条
        MovieSectionHead(
          leftInfo: section.name ?? "",
          isMore: true,
          rightInfo: section.moreText ?? "",
        ),
        //下面的喜欢的内容
        _build_list_card(),
      ],
    );
  }

  _build_list_card() {
    return Container(
      height: ScreenUtil().setHeight(200),
      child: RepaintBoundary(
        //边距和填充
        child: ListView.separated(
          itemCount: section.sectionContents.length,
          itemBuilder: (context, index) {
            return Container(
              width: 280,
              decoration: BoxDecoration(
                color: hexToColor(section.sectionContents[index].color),
                borderRadius: BorderRadius.circular(
                  ScreenUtil().setWidth(20),
                ),
              ),
              child: HorizontalListMovieCardItemWidget(
                section: section?.sectionContents[index],
              ),
            );
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
}

/**
 * 横向的card List item的组件
 */
class HorizontalListMovieCardItemWidget extends StatelessWidget {
  final SectionContents section;

  const HorizontalListMovieCardItemWidget({Key key, this.section})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: ScreenUtil().setHeight(26),
          bottom: ScreenUtil().setHeight(26),
          left: ScreenUtil().setWidth(30)),
      child: Row(
        children: [
          //左侧的图片叠加
          _build_left_images(),
          //右侧信息
          _build_right_text_info(),
        ],
      ),
    );
  }

  _build_left_images() {
    return Container(
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          _build_left_image_widget(
              0.8, ScreenUtil().setWidth(110), section.series[2].coverUrl),
          _build_left_image_widget(
              0.9, ScreenUtil().setWidth(50), section.series[1].coverUrl),
          _build_left_image_widget(
              1.0, ScreenUtil().setWidth(0), section.series[0].coverUrl),
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
              child: Image.network(
                coverImag,
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

  _build_right_text_info() {
    return Expanded(
        child: Container(
      padding: EdgeInsets.only(top: 10),
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text(section.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis, // 显示不完，就在后面显示点点
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
                strutStyle: StrutStyle(
                    forceStrutHeight: true, height: 0.48, leading: 1)),
          ),
          // Container(color: Colors.grey, child: Text('adasda')

          LZClickImageAndTitleBtn(
            mainAxisAlignment: MainAxisAlignment.start,
            image: Icon(
              Icons.arrow_circle_down,
              color: Colors.white54,
              size: ScreenUtil().setWidth(28),
            ),
            imageSize: Size(28, 28),
            title: '共${section.relevanceCount}部',
            padding: 6,
            fontSize: 13,
            textColor: Colors.white54,
            onTap: () {},
          ),
          // ),
        ],
      ),
    ));
  }
}

/**
 * top 榜的list控制
 */
class HorizontalTopListMovieWidget extends StatelessWidget {
  final Sections sections;

  const HorizontalTopListMovieWidget({Key key, this.sections})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
      height: ScreenUtil().setHeight(380),
      child: RepaintBoundary(
        //边距和填充
        child: ListView.separated(
          itemCount: sections.sectionContents.length,
          itemBuilder: (context, index) {
            //组件card
            return ClipRRect(
              borderRadius: BorderRadius.circular(
                ScreenUtil().setWidth(20),
              ),
              child: Container(
                width: 280,
                color: hexToColor(sections.sectionContents[index].color),
                child: HorizontalTopListMovieItemWidget(
                  sectionContents: sections.sectionContents[index],
                ),
              ),
            );
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
}

/**
 * top 榜的list的item控制
 */
class HorizontalTopListMovieItemWidget extends StatelessWidget {
  final SectionContents sectionContents;

  const HorizontalTopListMovieItemWidget({Key key, this.sectionContents})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //顶部信息头
        Positioned(
          child: MovieSectionHead(
            color_rever: true,
            paddingTop: ScreenUtil().setHeight(8),
            leftInfo: sectionContents.title,
            isMore: true,
            rightInfo: sectionContents.subTitle,
          ),
        ),
        //影片列表
        Positioned.fill(
            top: ScreenUtil().setHeight(68),
            bottom: ScreenUtil().setHeight(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _build_top_movie_item(
                    '1',
                    sectionContents.series[0].title,
                    sectionContents.series[0].coverUrl,
                    sectionContents.series[0].score),
                _build_top_movie_item(
                    '2',
                    sectionContents.series[1].title,
                    sectionContents.series[1].coverUrl,
                    sectionContents.series[1].score),
                _build_top_movie_item(
                    '3',
                    sectionContents.series[2].title,
                    sectionContents.series[2].coverUrl,
                    sectionContents.series[2].score),
              ],
            )),
      ],
    );
  }

  _build_top_movie_item(
      String number, String name, String coverImg, double score) {
    return Container(
      width: double.infinity,
      height: 64,
      // color: Colors.redAccent,
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          //排行版
          Container(
            width: ScreenUtil().setWidth(20),
            child: Text(
              number,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
          ),

          //图片信息
          Container(
            width: ScreenUtil().setWidth(86),
            margin: EdgeInsets.only(
                top: ScreenUtil().setHeight(2),
                bottom: ScreenUtil().setHeight(2),
                left: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(18)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                coverImg,
                fit: BoxFit.cover,
              ),
            ),
          ),
          //介绍
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              //名称
              Container(
                width: ScreenUtil().setWidth(290),
                margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(10),
                    bottom: ScreenUtil().setHeight(8),
                    right: 10),
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis, // 显示不完，就在后面显示点点
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ),
              //评价的星星
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: ScreenUtil().setWidth(6)),
                    child: CustomRating(
                      max: 5,
                      score: score / 2,
                      star: Star(
                          progress: 0,
                          num: 5,
                          fat: 0.5,
                          size: ScreenUtil().setWidth(26),
                          fillColor: Colors.indigoAccent,
                          emptyColor: Colors.white54),
                    ),
                  ),
                  Text(
                    '${score}',
                    style: TextStyle(fontSize: 14, color: Colors.white54),
                  ),
                ],
              ),

              // Row(
              //   children: [],
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

/**
 * single image的图片widget
 */
class SingleImageWidget extends StatelessWidget {
  final String coverImage;

  const SingleImageWidget({Key key, this.coverImage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: ScreenUtil().setHeight(40),
        left: ScreenUtil().setWidth(20),
        right: ScreenUtil().setWidth(20),
      ),
      height: 130,
      child: Image.network(
        coverImage,
        fit: BoxFit.cover,
      ),
    );
  }
}
