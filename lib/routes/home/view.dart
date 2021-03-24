import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          titleSpacing: 0.0,
          backgroundColor: Colors.transparent,
          toolbarHeight:
              ScreenUtil().statusBarHeight + ScreenUtil().setHeight(44),
          bottom: buildTabBar(),
          flexibleSpace: _build_custom_appbar(),
          // title: buildTopAppBar(),
        ),
        body: getTabView(),
      );
    });
  }

  /**
   * 创建TabBar
   */
  buildTabBar() {
    return TabBar(
      indicatorColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorWeight: 4,
      isScrollable: true,
      controller: tabController,
      tabs: getTab(),
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
    return TabBarView(
      controller: tabController,
      children: logic.topCategory.value.filmTelevsionList.map((e) {
        return Center(
          child: Text('${e.name}'),
        );
      }).toList(),
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
    return Positioned.fill(
      child: Stack(
        children: [
          //背景色
          buildAppBarGB(),
          //顶部工具栏
          buildTopAppBar(),
        ],
      ),
    );
  }

  buildAppBarGB() {
    return Container(
      // height: ScreenUtil().statusBarHeight + ScreenUtil().setHeight(100),
      decoration: BoxDecoration(
        boxShadow: [
          //阴影
          BoxShadow(
              color: Colors.indigo,
              offset: Offset(0.0, 0.0),
              blurRadius: 14,
              spreadRadius: 20)
        ],
        gradient: LinearGradient(colors: [
          Colors.indigo.shade400,
          Colors.indigo,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
    );
  }

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

  buildLogo() {
    return FlutterLogo(
      size: 34,
    );
  }

  buildRightDowlod() {
    return Container(
      margin: EdgeInsets.only(
          right: ScreenUtil().setWidth(14), left: ScreenUtil().setWidth(14)),
      child: Icon(
        Icons.arrow_circle_down_sharp,
        size: ScreenUtil().setWidth(50),
      ),
    );
  }

  buildRightHistory() {
    return Container(
      margin: EdgeInsets.only(right: ScreenUtil().setWidth(14)),
      child: Icon(
        Icons.history_sharp,
        size: ScreenUtil().setWidth(50),
      ),
    );
  }

  buildCenterSS() {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        height: ScreenUtil().setWidth(60),
        decoration: BoxDecoration(
            color: Colors.black38.withOpacity(0.2),
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(60))),
        margin: EdgeInsets.only(
          left: 10,
        ),
        child: Text('123'),
        // color: Colors.redAccent,
      ),
    );
  }
}
