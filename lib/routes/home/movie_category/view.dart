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

  //gridview 偏移了150 bar偏移了70 所以offset滚动的距离
  double realOffset = ScreenUtil().setHeight(500 - 80);

  @override
  void initState() {
    // TODO: implement initState
    logic.getCategoryTopModel(ageLimit: 0);
    super.initState();
  }

  /**
   * 处理上下滑 自动吸顶的问题
   */
  handle_scroll_top(double detal_gl) {
    if (detal_gl > 0) {
      //向下滑动了
      if (_scrollController.offset <= realOffset.truncate() &&
          _scrollController.offset > ScreenUtil().setHeight(0)) {
        _scrollController.animateTo(ScreenUtil().setHeight(0),
            duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      }
    } else if (detal_gl < 0) {
      //向上滑动了
      if (_scrollController.offset < realOffset.truncate() &&
          _scrollController.offset > ScreenUtil().setHeight(0)) {
        _scrollController.animateTo(ScreenUtil().setHeight(500),
            duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      }
    }
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

  @override
  Widget build(BuildContext context) {
    //监听滚动方向
    return ScrollDriectionListion(
      offset_callback: handle_scroll_top,
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
              // controller: _grid_view_controller,
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
        padding: EdgeInsets.only(top: ScreenUtil().setHeight(70)),
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
          return _build_list_view_item(index, indexIn);
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
   * 创建横向的listview的item
   */
  _build_list_view_item(int index, int indexIn) {
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
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(30))),
        child: Text(
          logic.topCategoryModel.value.data[index].dramaFilterItemList[indexIn]
              .displayName,
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
