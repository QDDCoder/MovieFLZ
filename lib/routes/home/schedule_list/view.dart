import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:get/get.dart';

import 'logic.dart';

/**
 * 电影排期
 */

class ScheduleListPage extends StatefulWidget {
  @override
  _ScheduleListPageState createState() => _ScheduleListPageState();
}

class _ScheduleListPageState extends State<ScheduleListPage> {
  final ScheduleListLogic logic = Get.put(ScheduleListLogic());

  @override
  void initState() {
    // TODO: implement initState
    logic.getMoviesList(date: '2021-04-02');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        // controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              //SliverAppBar
              sliver: _build_SliverAppBar(),
            ),
          ];
        },
        //scroll_body
        body: _build_scroll_body_view(),
      ),
    );
  }

  SliverAppBar _build_SliverAppBar() {
    return SliverAppBar(
      //为true则appbar不消失，在下拉时会多划出一段距离SliverAppBar才开始滚动
      pinned: true,
      //最大扩展高度
      expandedHeight: ScreenUtil().setHeight(280),
      primary: true,
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black45),
      actions: [
        //右侧分享按钮
        IconButton(
            icon: Icon(
              Icons.calendar_today,
            ),
            onPressed: () {}),
      ],
      flexibleSpace: _build_flexible_space_bar(),
      bottom: _build_no_inkwell_bar(),
    );
  }

  //顶部的扩展内容区域
  _build_flexible_space_bar() {
    return FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Align(
          alignment: Alignment(-0.91, 0),
          child: Text(
            '4月排期',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700, fontSize: 25),
          ),
        ));
  }

  _build_no_inkwell_bar() {
    return PreferredSize(
      preferredSize: Size(0, ScreenUtil().setHeight(120)),
      child: Container(
        color: Colors.indigo,
        height: ScreenUtil().setHeight(120),
        child: _build_top_date_list_view(),
      ),
    );
  }

  _build_top_date_list_view() {
    return ListView.separated(
      itemCount: logic.listModel.value.scheduleList.length,
      itemBuilder: (context, index) {
        return Container(
          width: ScreenUtil().setWidth(100),
          height: ScreenUtil().setHeight(100),
          color: Colors.yellow,
          child: Column(
            children: [
              Text('1'),
              _build_day(),
            ],
          ),
        );
      },
      //头尾间隔
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20)),
      scrollDirection: Axis.horizontal,
      //item 间隔
      separatorBuilder: (context, index) {
        return SizedBox(
          width: ScreenUtil().setWidth(10),
        );
      },
    );
  }

  _build_day() {
    return Container(
      width: ScreenUtil().setWidth(60),
      height: ScreenUtil().setWidth(60),
      decoration: BoxDecoration(
        color: Colors.indigo,
        border: Border.all(color: Colors.indigo, width: 1),
      ),
    );
  }

  //中间的TabBarView嵌套ListView
  _build_scroll_body_view() {
    return Container(
        margin: EdgeInsets.only(top: ScreenUtil().setHeight(196)),
        child: Container());
  }
}
