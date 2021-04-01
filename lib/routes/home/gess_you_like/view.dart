import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_flz/routes/home/home_root/views/HomeMovieView.dart';
import 'package:movie_flz/tools/StringTools.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'logic.dart';
import 'model/GessYouLikeModel.dart';

class GessYouLikePage extends StatefulWidget {
  @override
  _GessYouLikePageState createState() => _GessYouLikePageState();
}

class _GessYouLikePageState extends State<GessYouLikePage> {
  final GessYouLikeLogic logic = Get.put(GessYouLikeLogic());

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _onRefresh() async {
    await logic.getGessYouLikeList().then((value) {
      _refreshController.refreshCompleted();
    });
  }

  _onLoading() async {
    await logic.getGessYouLikeList(refresh: false).then((value) {
      _refreshController.loadComplete();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    logic.getGessYouLikeList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Color(0xFFefefef),
        appBar: AppBar(
          backgroundColor: Colors.indigoAccent,
          title: Text('猜你喜欢'),
        ),
        body: PullAndPushWidget(
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          childWidget: ListView.builder(
            itemBuilder: (context, index) {
              //
              GessYouLikeItmeModel mode =
                  logic.gessYouLikeList.value.itemList[index];
              //电影的item
              return GessYouLikeListItemWidget(
                coverUrl: mode.coverUrl,
                name: mode.title,
                score: mode.score,
                type:
                    '${mode.dramaType}/${mode.year}/${changeStringList(mode.areaList)}/${changeStringList(mode.plotTypeList).replaceFirst(' ', '')}',
                actor: changeStringList(mode.actorList),
              );
            },
            itemCount: logic.gessYouLikeList.value.itemList.length,
          ),
        ),
      );
    });
  }
}
