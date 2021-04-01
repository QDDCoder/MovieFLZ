import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'model/SeasonRankListModel.dart';

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
    logic.getDays(DateTime.now().year, DateTime.now().month);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: NestedScrollView(
          // controller: _scrollController,
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
          //scroll_body
          body: _build_scroll_body_view(),
        ),
      );
    });
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
      ),
    );
  }

  _build_no_inkwell_bar() {
    return PreferredSize(
      preferredSize: Size(0, ScreenUtil().setHeight(120)),
      child: Obx(() {
        return Container(
          color: Colors.white,
          height: ScreenUtil().setHeight(120),
          child: _build_top_date_list_view(),
        );
      }),
    );
  }

  _build_top_date_list_view() {
    return ListView.separated(
      itemCount: logic.dayInfos.value.days.length,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${logic.dayInfos.value.days[index]['weakday']}',
              ),
              _build_day(index),
            ],
          ),
        );
      },
      //头尾间隔
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(10), right: ScreenUtil().setWidth(10)),
      scrollDirection: Axis.horizontal,
      //item 间隔
      separatorBuilder: (context, index) {
        return SizedBox(
          width: ScreenUtil().setWidth(20),
        );
      },
    );
  }

  _build_day(index) {
    var day = logic.dayInfos.value.days[index];
    return GestureDetector(
      onTap: () {
        logic.updateSelect(index);
      },
      child: Container(
        margin: EdgeInsets.only(top: ScreenUtil().setHeight(6)),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(70),
        height: ScreenUtil().setWidth(70),
        decoration: BoxDecoration(
          color: day['select'] == 1 ? Colors.indigo : Colors.white,
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(35)),
          border: Border.all(
              color: day['today'] == 1 ? Colors.indigo : Colors.white,
              width: day['today'] == 1 ? 1 : 0),
        ),
        child: Text(
          day['today'] == 1 ? '今' : '${day['day']}',
          style: TextStyle(
              color: select_text_color(day),
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Color select_text_color(day) {
    //今天
    if (day['today'] == 1) {
      return (day['select'] == 1) ? Colors.white : Colors.indigo;
    }
    if (day['select'] == 1) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  //中间的TabBarView嵌套ListView
  _build_scroll_body_view() {
    return Container(
      margin: EdgeInsets.only(
          top: ScreenUtil().setHeight(200),
          left: ScreenUtil().setWidth(20),
          right: ScreenUtil().setWidth(20)),
      child: GridView.builder(
        itemCount: logic.listModel.value.scheduleList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //数量
            crossAxisCount: 3,
            //横向间隔
            crossAxisSpacing: ScreenUtil().setWidth(14),
            //纵向间隔
            mainAxisSpacing: ScreenUtil().setWidth(34),
            //宽高比
            childAspectRatio: ScreenUtil().setWidth(200) /
                ScreenUtil().setHeight(220) *
                0.76),
        itemBuilder: (context, index) {
          return Container(
            // color: Colors.redAccent,
            child: _build_grid_item1(logic.listModel.value.scheduleList[index]),
          );
        },
      ),
    );
  }

  _build_grid_item1(ScheduleListItemModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: ScreenUtil().setHeight(246),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10)),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    model.coverUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment(0, 1),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: ScreenUtil().setHeight(40),
                    width: double.infinity,
                    color: Colors.black54.withOpacity(0.6),
                    child: Text(
                      '  ' + model.episode,
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
          child: Text(
            model.title,
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w700,
                fontSize: 16),
          ),
        ),
      ],
    );
  }
}
