import 'package:flutter/material.dart';
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
          backgroundColor: Colors.transparent,
          toolbarHeight: 80,
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 4,
            isScrollable: true,
            controller: tabController,
            tabs: getTab(),
          ),
          flexibleSpace: _build_custom_appbar(),
        ),
        body: getTabView(),
      );
    });
  }

  /**
   *
   */
  getTab() {
    return logic.topCategory.value.filmTelevsionList
        .map((e) => Tab(
              text: e.name,
            ))
        .toList();
  }

  /**
   *
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
   *
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

  _build_custom_appbar() {
    return Container(
      height: 120,
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
}
