import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:get/get.dart';
import 'package:movie_flz/tools/ColorTools.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    logic.getCategoryTopModel(ageLimit: 0);

    logic.get_select_movies();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              //SliverAppBar
              sliver: _build_SliverAppBar(),
            ),
          ];
        },
        body: _build_scroll_body_view(),
      ),
    );
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
      background: Obx(() {
        return Padding(
          padding: EdgeInsets.only(top: 54),
          child: ListView.builder(
            shrinkWrap: true, //为true可以解决子控件必须设置高度的问题
            physics: NeverScrollableScrollPhysics(), //禁用滑动事件
            itemCount: logic.topCategoryModel.value.data.length,
            itemBuilder: (context, index) {
              return _build_top_category_listview(index);
            },
          ),
        );
      }),
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

  _build_scroll_body_view() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            height: 50,
            color: Colors.primaries[index % 8],
          );
        },
        childCount: 10,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: ScreenUtil().setWidth(10),
        crossAxisSpacing: ScreenUtil().setWidth(20),
        childAspectRatio:
            ScreenUtil().setWidth(200) / ScreenUtil().setHeight(220) * 0.8,
      ),
    );
  }
}
