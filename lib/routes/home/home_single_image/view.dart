import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:movie_flz/routes/home/home_root/views/HomeMovieView.dart';
import 'package:movie_flz/tools/Toast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'logic.dart';

class HomeSingleImagePage extends StatefulWidget {
  @override
  _HomeSingleImagePageState createState() => _HomeSingleImagePageState();
}

class _HomeSingleImagePageState extends State<HomeSingleImagePage> {
  final HomeSingleImageLogic logic = Get.put(HomeSingleImageLogic());

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _onRefresh() async {
    logic.getHomeSingleImage(navigationId: _navigationId).then((value) {
      _refreshController.refreshCompleted();
    });
  }

  int _navigationId;

  @override
  void initState() {
    // TODO: implement initState
    _navigationId = int.parse(Get.arguments['navigationId']);
    logic.getHomeSingleImage(navigationId: _navigationId);
    logic
        .getHomeSingleImageNavigator(navigationId: _navigationId)
        .then((value) {
      print('什么玩而已${logic.titleInfo.value}');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.indigoAccent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.indigoAccent,
          title: Text(logic.titleInfo.value),
          actions: [
            logic.ClipboardInfo.value == ''
                ? Container()
                : IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      showToast('已复制到剪切板了哟~');
                      Clipboard.setData(
                          ClipboardData(text: logic.ClipboardInfo.value));
                    },
                  )
          ],
        ),
        body: PullAndPushWidget(
          controller: _refreshController,
          onRefresh: _onRefresh,
          childWidget: ListView.builder(
            itemCount: logic.homeSingleModel.value.sections.length,
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                  imageUrl: logic.homeSingleModel.value.sections[index].content
                      .first.coverUrl);
            },
          ),
        ),
      );
    });
  }
}
