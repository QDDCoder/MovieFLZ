import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie_flz/routes/home/home_film/view.dart';

import '../home_movie/view.dart';
import 'logic.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final HomeLogic logic = Get.put(HomeLogic());

  TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(
        length: logic.topCategory.value.filmTelevsionList.length, vsync: this);
    //发起网络请求顶部的分类数据
    getNetInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        children: [
          //最底层的tabView
          getTabView(),
          //顶层Appbar
          _build_App_Bar(),
          //顶层tabbar
          buildTabBar(),
        ],
      );
    });
  }

  /**
   * 创建AppBar
   */
  _build_App_Bar() {
    return Container(
      height: ScreenUtil().statusBarHeight + ScreenUtil().setHeight(76),
      child: AppBar(
        primary: false,
        elevation: 0.0,
        titleSpacing: 0.0,
        backgroundColor: Colors.transparent,
        toolbarHeight:
            ScreenUtil().statusBarHeight + ScreenUtil().setHeight(44),
        flexibleSpace: _build_custom_appbar(),
      ),
    );
  }

  /**
   * 创建TabBar
   */
  buildTabBar() {
    //去除TabBar点击水波纹效果
    return PreferredSize(
      preferredSize: Size(0, ScreenUtil().setHeight(44)),
      child: Container(
        padding: EdgeInsets.only(
            top: ScreenUtil().statusBarHeight + ScreenUtil().setHeight(44)),
        child: Theme(
          data: ThemeData(
            //默认显示的背景颜色
            backgroundColor: Colors.transparent,
            //点击的背景高亮颜色
            highlightColor: Colors.transparent,
            //点击水波纹颜色
            splashColor: Colors.transparent,
          ),
          child: TabBar(
            indicatorColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3,
            isScrollable: true,
            controller: tabController,
            tabs: getTab(),
          ),
        ),
      ),
    );
  }

  /**
   *创建bar
   */
  getTab() {
    return logic.topCategory.value.filmTelevsionList
        .map((e) => Tab(
              child: Text(
                e.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ))
        .toList();
  }

  /**
   *创建TabBarView
   */
  getTabView() {
    return Container(
      margin: EdgeInsets.only(
          top: ScreenUtil().statusBarHeight + ScreenUtil().setHeight(74)),
      child: TabBarView(
        controller: tabController,
        children: logic.topCategory.value.filmTelevsionList.map((e) {
          if (e.key == "INDEX") {
            return HomeMoviePage(
              page_key: e.key,
            );
          } else {
            return HomeFilmPage(
              page_key: e.key,
            );
          }
        }).toList(),
      ),
    );
  }

  /**
   *获取网络数据
   */
  void getNetInfo() async {
    await logic.getCategory().then((value) {
      setState(() {
        tabController = TabController(
            length: logic.topCategory.value.filmTelevsionList.length,
            vsync: this);
        tabController.animateTo(0);
      });
    });
  }

  /**
   * 设置Appbar的样式
   */
  _build_custom_appbar() {
    return Stack(
      children: [
        //背景色
        buildAppBarGB(),
        //顶部工具栏
        buildTopAppBar(),
      ],
    );
  }

  /**
   * appBar的背景
   */
  buildAppBarGB() {
    return Container(
      height: ScreenUtil().statusBarHeight + ScreenUtil().setHeight(76),
      decoration: BoxDecoration(
        boxShadow: [
          //阴影
          BoxShadow(
              color: Colors.indigo.withOpacity(0.98),
              offset: Offset(0.0, 0.0),
              blurRadius: 18,
              spreadRadius: 20)
        ],
        gradient: LinearGradient(colors: [
          Colors.indigo.shade400,
          Colors.indigo,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
    );
  }

  /**
   * AppBar 上面的工具条
   */
  buildTopAppBar() {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().statusBarHeight - 4),
      child: Row(
        children: [
          //左侧的logo
          buildLogo(),
          //中间的输入框
          buildCenterSS(),
          //右侧的下载
          buildRightDowlod(),
          //右侧的历史记录
          buildRightHistory(),
        ],
      ),
    );
  }

  /**
   * 左侧的logo
   */
  buildLogo() {
    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(16)),
      child: FlutterLogo(
        size: 34,
      ),
    );
  }

  /**
   * 右侧的下载按钮
   */
  buildRightDowlod() {
    return Container(
      margin: EdgeInsets.only(
          right: ScreenUtil().setWidth(14), left: ScreenUtil().setWidth(14)),
      child: Icon(
        Icons.arrow_circle_down_sharp,
        color: Colors.white70,
        size: ScreenUtil().setWidth(50),
      ),
    );
  }

  /**
   * 右侧的历史按钮
   */
  buildRightHistory() {
    return Container(
      margin: EdgeInsets.only(right: ScreenUtil().setWidth(14)),
      child: Icon(
        Icons.history_sharp,
        color: Colors.white70,
        size: ScreenUtil().setWidth(50),
      ),
    );
  }

  /**
   * 搜索条
   */
  buildCenterSS() {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        height: ScreenUtil().setHeight(44),
        decoration: BoxDecoration(
            color: Colors.black38.withOpacity(0.2),
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(60))),
        margin: EdgeInsets.only(
          left: 10,
        ),
        child: _build_search_info(),
      ),
    );
  }

  /**
   * 搜索条
   */
  _build_search_info() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: ScreenUtil().setWidth(16),
              right: ScreenUtil().setWidth(10)),
          child: Icon(
            Icons.search,
            size: 24,
            color: Colors.white70,
          ),
        ),
        Text(
          '搜索',
          style: TextStyle(
            color: Colors.white70,
          ),
        )
      ],
    );
  }
}
