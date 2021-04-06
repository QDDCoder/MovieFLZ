import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:get/get.dart';
import 'package:movie_flz/routes/home/home_root/views/HomeMovieView.dart';
import 'package:movie_flz/tools/Button+Extension.dart';
import 'package:movie_flz/tools/Sheet.dart';

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
  ScrollController _scrollController = ScrollController();
  double _scoll_offset = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    logic.getDays(DateTime.now().year, DateTime.now().month).then((value) {
      _then_top_season_refush_data();
    });

    //监听Scrol
    _scrollController.addListener(() {
      setState(() {
        _scoll_offset = _scrollController.offset;
      });
    });
    super.initState();
  }

  /**
   * 切换过排期类型后重新刷新数据
   */
  Future<void> _then_top_season_refush_data() {
    //获取area
    var tempType = '';
    logic.chedule_seanson.forEach((element) {
      if (element['isSelect'] == 1) {
        tempType = element['type'];
      }
    });
    //日期
    var tempDay = DateTime.now().day;
    logic.dayInfos.value.days.forEach((element) {
      if (element['select'] == 1) {
        tempDay = element['day'];
      }
    });

    var tempYear = DateTime.now().year;
    var tempMonth = DateTime.now().month;
    logic.chedule_days.forEach((element) {
      if (element['isSelect'] == 1) {
        tempMonth = element['month'];
        tempYear = element['year'];
      }
    });
    logic.getMoviesList(
        date: '${tempYear}-${tempMonth}-${tempDay}', type: tempType);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
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
      title: Text(
        '${logic.current_month.value}月排期',
        style: TextStyle(
            color: _scoll_offset > ScreenUtil().setHeight(10)
                ? Colors.black
                : Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 24),
      ),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black45),
      actions: [
        //右侧分享按钮
        _app_bar_right(),
      ],
      flexibleSpace: _build_flexible_space_bar(),
      bottom: _build_no_inkwell_bar(),
    );
  }

  /**
   * 右侧的日历图标
   */
  _app_bar_right() {
    return GestureDetector(
      onTap: () {
        _show_date_time_choise().then((value) {
          if (value != null && value >= 1) {
            //状态更新保存
            logic.changeCurrentMonth(value);
            //发起网络请求
            _then_top_season_refush_data();
          }
        });
      },
      child: Container(
        width: ScreenUtil().setWidth(80),
        height: ScreenUtil().setWidth(80),
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0, 0),
              child: Icon(
                Icons.calendar_today,
              ),
            ),
            Align(
              alignment: Alignment(0, 0.1),
              child: Text(
                '${logic.current_month.value}',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///显示日期的选择
  _show_date_time_choise() {
    return showCustomBottomSheet(
      context: context,
      title: '',
      cancelTitle: '取消',
      children: logic.chedule_days.map((e) {
        return actionItem(
          context: context,
          index: e['num'],
          title: '${e['month']}' + '月',
          color: e['isSelect'] == 1 ? Colors.indigo : Colors.black38,
        );
      }).toList(),
    );
  }

  //顶部的扩展内容区域
  _build_flexible_space_bar() {
    return FlexibleSpaceBar(
      collapseMode: CollapseMode.pin,
      background: Align(
        alignment: Alignment(-0.91, 0),
        child: Text(
          '${logic.current_month.value}月排期',
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
          left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20)),
      scrollDirection: Axis.horizontal,
      //item 间隔
      separatorBuilder: (context, index) {
        return SizedBox(
          width: ScreenUtil().setWidth(44),
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
        width: ScreenUtil().setWidth(50),
        height: ScreenUtil().setWidth(50),
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

  //底部的ScrollView
  _build_scroll_body_view() {
    return Container(
      margin: EdgeInsets.only(
          top: ScreenUtil().setHeight(270),
          left: ScreenUtil().setWidth(20),
          right: ScreenUtil().setWidth(20)),
      child: CustomScrollView(
        slivers: [
          _build_top_change_type(),
          _build_bottom_grid_view(),
        ],
      ),
    );
  }

  ///顶部的类别筛选
  _build_top_change_type() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          _build_type_change(),
        ],
      ),
    );
  }

  _build_type_change() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //左侧的筛选类别
          Container(
            width: ScreenUtil().setWidth(120),
            height: ScreenUtil().setHeight(70),
            child: LZClickTitleAndImageBtn(
              onTap: () {
                //排序的类型
                _bottom_show_schedule_types().then((value) {
                  if (value != null && value >= 1) {
                    //状态更新保存
                    logic.update_top_season_list_select(value);
                    //发起网络请求
                    _then_top_season_refush_data();
                  }
                });
              },
              mainAxisAlignment: MainAxisAlignment.center,
              image: Icon(
                Icons.keyboard_arrow_down_outlined,
                size: ScreenUtil().setWidth(40),
                color: Colors.black38,
              ),
              imageSize: Size(60, 70),
              title: logic.top_chedule_title.value,
              textColor: Colors.black38,
              fontSize: 16,
            ),
          ),
          //右侧的排列格式
          GestureDetector(
            onTap: () {
              //切换列表展示的形式
              logic.changeDisplayType();
            },
            child: Container(
              alignment: Alignment.centerRight,
              width: ScreenUtil().setWidth(70),
              height: ScreenUtil().setHeight(70),
              child: Icon(
                Icons.call_to_action_outlined,
                color: Colors.black38,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /**
   * 顶部的排期类型
   */
  _bottom_show_schedule_types() {
    return showCustomBottomSheet(
      context: context,
      title: '',
      cancelTitle: '取消',
      children: logic.chedule_seanson.map((e) {
        print('什么啊${e['isSelect']}');
        return actionItem(
          context: context,
          index: e['num'],
          title: e['name'],
          color: e['isSelect'] == 1 ? Colors.indigo : Colors.black38,
        );
      }).toList(),
    );
  }

  _mySliverChildBuilderDelegate() {
    return SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        if (logic.displayType.value == 0) {
          return _build_grid_item1(logic.listModel.value.scheduleList[index]);
        } else {
          return _build_grid_item2(logic.listModel.value.scheduleList[index]);
        }
      },
      childCount: logic.listModel.value.scheduleList.length ?? 0,
    );
  }

  _mySliverGridDelegateWithFixedCrossAxisCount() {
    return SliverGridDelegateWithFixedCrossAxisCount(
        //数量
        crossAxisCount: logic.displayType.value == 0 ? 3 : 1,
        //横向间隔
        crossAxisSpacing:
            ScreenUtil().setWidth((logic.displayType.value == 0) ? 14 : 0),
        //纵向间隔
        mainAxisSpacing:
            ScreenUtil().setWidth((logic.displayType.value == 0) ? 34 : 46),
        //宽高比
        childAspectRatio: (logic.displayType.value == 0)
            ? ScreenUtil().setWidth(200) / ScreenUtil().setHeight(220) * 0.76
            : 3.6);
  }

  _build_bottom_grid_view() {
    if (logic.listModel.value.scheduleList.length == 0) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return EmptyWidget();
          },
          childCount: 1,
        ),
        // delegate: _mySliverChildListDelegate(),
      );
    } else {
      return SliverGrid(
        delegate: _mySliverChildBuilderDelegate(),
        gridDelegate: _mySliverGridDelegateWithFixedCrossAxisCount(),
      );
    }
  }

  ///类型1的item
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
                  child: CachedNetworkImage(
                    imageUrl: model.verticalUrl,
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w700,
                fontSize: 16),
          ),
        ),
      ],
    );
  }

  ///类型2的item
  _build_grid_item2(ScheduleListItemModel model) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10)),
          child: SizedBox(
            width: ScreenUtil().setWidth(140),
            height: double.infinity,
            child: CachedNetworkImage(
              imageUrl: model.verticalUrl,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: ScreenUtil().setHeight(14),
            left: ScreenUtil().setWidth(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(13),
                ),
                child: Text(
                  '${model.year}/${model.area}/${model.cat}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black87, fontSize: 13),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
