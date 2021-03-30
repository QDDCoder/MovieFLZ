import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:get/get.dart';
import 'package:movie_flz/config/RouteConfig.dart';
import 'package:movie_flz/routes/home/views/HomeMovieView.dart';

import 'logic.dart';

class HomeListCardViewPage extends StatefulWidget {
  @override
  _HomeListCardViewPageState createState() => _HomeListCardViewPageState();
}

class _HomeListCardViewPageState extends State<HomeListCardViewPage> {
  final HomeListCardViewLogic logic = Get.put(HomeListCardViewLogic());

  String _title = '';
  int _section_id = 0;

  @override
  void initState() {
    // TODO: implement initState
    _title = Get.arguments['title'];
    _section_id = Get.arguments['sectionId'];

    logic.getMoreMoviesList(refresh: true, sectionId: _section_id);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black45),
          title: Text(
            _title,
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
        //listView
        body: _build_list_widget(),
      );
    });
  }

  _build_list_widget() {
    return ListView.separated(
      itemBuilder: (context, index) {
        return HomeListCardMoreItemWidget(
          topClickAction: () {
            Get.toNamed(RouteConfig.look_more_movies, arguments: {
              'id': '${logic.movieModel.value.itemList[index].id}'
            });
          },
          sectionContents: logic.movieModel.value.itemList[index],
        );
      },
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(20),
          bottom: ScreenUtil().setHeight(20),
          left: ScreenUtil().setWidth(20),
          right: ScreenUtil().setWidth(20)),
      separatorBuilder: (context, index) {
        return SizedBox(
          height: ScreenUtil().setHeight(18),
        );
      },
      itemCount: logic.movieModel.value.itemList.length,
    );
  }
}
