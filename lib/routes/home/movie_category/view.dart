import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:get/get.dart';
import 'package:movie_flz/routes/home/home_root/views/HomeMovieView.dart';
import 'package:movie_flz/tools/ColorTools.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'logic.dart';

/**
 * 影视分类
 */

class MovieCategoryPage extends StatefulWidget {
  @override
  _MovieCategoryPageState createState() => _MovieCategoryPageState();
}

class _MovieCategoryPageState extends State<MovieCategoryPage> {
  final MovieCategoryLogic logic = Get.put(MovieCategoryLogic());

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    logic.getCategoryTopModel(ageLimit: 0);
    _scrollController.addListener(() {
      print('------->>>>${_scrollController.offset}');
    });
    super.initState();
  }

  _onRefresh() async {
    logic.get_select_movies(refush: true).then((value) {
      _refreshController.refreshCompleted();
    });
  }

  _onLoading() async {
    logic.get_select_movies(refush: false).then((value) {
      _refreshController.loadComplete();
    });
  }

  //手指移动的位置
  double _lastMoveY = 0.0;
  //手指按下的位置
  double _downY = 0.0;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        //手指按下的距离
        _downY = event.position.distance;
      },
      onPointerMove: (PointerMoveEvent event) {
        //手指移动的距离
        var position = event.position.distance;
        //判断距离差
        var detal = position - _lastMoveY;
        if (detal > 0) {
          //手指移动的距离
          double pos = (position - _downY);
          print("================向下移动================${detal}");
        } else {
          // 所摸点长度 +滑动距离  = IistView的长度  说明到达底部
          print("================向上移动================${detal}");
        }
        _lastMoveY = position;
      },
      child: Scaffold(
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                //SliverAppBar
                sliver: _build_SliverAppBar(),
              ),
            ];
          },
          body: _build_grid_view(),
        ),
      ),
    );
  }

  Widget _build_grid_view() {
    return Builder(builder: (context) {
      return Container(
        margin: EdgeInsets.only(
            top: ScreenUtil().setHeight(150),
            left: ScreenUtil().setWidth(20),
            right: ScreenUtil().setWidth(20)),
        child: Obx(() {
          return PullAndPushWidget(
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            childWidget: CustomScrollView(
              slivers: [
                //列表
                _build_scroll_body_view(),
              ],
            ),
          );
        }),
      );
    });
  }

  SliverAppBar _build_SliverAppBar() {
    return SliverAppBar(
      //为true则appbar不消失，在下拉时会多划出一段距离SliverAppBar才开始滚动
      pinned: true,
      //最大扩展高度
      expandedHeight: ScreenUtil().setHeight(500),
      primary: true,
      title: Text(
        '影视分类',
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black45),
      flexibleSpace: _build_flexible_space_bar(),
    );
  }

  //顶部的扩展内容区域
  _build_flexible_space_bar() {
    return FlexibleSpaceBar(
      collapseMode: CollapseMode.pin,
      background: Padding(
        padding: EdgeInsets.only(top: 54),
        child: Obx(() {
          return ListView.builder(
            shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
            physics: NeverScrollableScrollPhysics(), //禁用滑动事件
            itemCount: logic.topCategoryModel.value.data.length,
            itemBuilder: (context, index) {
              return _build_top_category_listview(index);
            },
          );
        }),
      ),
    );
  }

  _build_top_category_listview(int index) {
    return Container(
      height: ScreenUtil().setHeight(58),
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(8), bottom: ScreenUtil().setHeight(8)),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20)),
        itemBuilder: (context, indexIn) {
          return GestureDetector(
            onTap: () {
              logic.update_select_index(index, indexIn);
            },
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(20),
              ),
              decoration: BoxDecoration(
                  color: logic.topCategoryModel.value.data[index]
                          .dramaFilterItemList[indexIn].isSelect
                      ? hexToColor('#f9f9f9')
                      : Colors.white,
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setWidth(30))),
              child: Text(
                logic.topCategoryModel.value.data[index]
                    .dramaFilterItemList[indexIn].displayName,
                style: TextStyle(
                    fontWeight: logic.topCategoryModel.value.data[index]
                            .dramaFilterItemList[indexIn].isSelect
                        ? FontWeight.w700
                        : FontWeight.w500,
                    fontSize: 16,
                    color: logic.topCategoryModel.value.data[index]
                            .dramaFilterItemList[indexIn].isSelect
                        ? Colors.blue
                        : Colors.black45),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            width: ScreenUtil().setWidth(4),
          );
        },
        itemCount:
            logic.topCategoryModel.value.data[index].dramaFilterItemList.length,
      ),
    );
  }

  /**
   * 底部的GridView
   */
  _build_scroll_body_view() {
    return SliverGrid(
      delegate: _mySliverChildBuilderDelegate(),
      gridDelegate: _mySliverGridDelegateWithFixedCrossAxisCount(),
    );
  }

  _mySliverChildBuilderDelegate() {
    return SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return MovieItemCard(
          sectionContents: logic.movieCategoryListModel.value.data[index],
          grid_view_width: true,
        );
      },
      childCount: logic.movieCategoryListModel.value.data.length,
    );
  }

  _mySliverGridDelegateWithFixedCrossAxisCount() {
    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      mainAxisSpacing: ScreenUtil().setWidth(10),
      crossAxisSpacing: ScreenUtil().setWidth(20),
      childAspectRatio:
          ScreenUtil().setWidth(200) / ScreenUtil().setHeight(220) * 0.8,
    );
  }
}
