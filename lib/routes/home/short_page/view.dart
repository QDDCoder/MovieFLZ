import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:get/get.dart';
import 'package:movie_flz/config/RouteConfig.dart';
import 'package:movie_flz/routes/home/home_root/views/HomeMovieView.dart';
import 'package:movie_flz/tools/ColorTools.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'logic.dart';
import 'model/ShortPageModel.dart';

/**
 * 首页短视频
 */

class ShortPagePage extends StatefulWidget {
  @override
  _ShortPagePageState createState() => _ShortPagePageState();
}

class _ShortPagePageState extends State<ShortPagePage>
    with AutomaticKeepAliveClientMixin {
  final ShortPageLogic logic = Get.put(ShortPageLogic());

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    // TODO: implement initState
    logic.getShortMovieInfo(refresh: true);
    super.initState();
  }

  void _onRefresh() async {
    await logic.getShortMovieInfo(refresh: true).then((value) {
      _refreshController.refreshCompleted();
    });
  }

  void _onLoading() async {
    await logic.getShortMovieInfo(refresh: false).then((value) {
      _refreshController.loadComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        color: Color(0xFFefefef),
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20)),
        child: PullAndPushWidget(
          controller: _refreshController,
          onLoading: _onLoading,
          onRefresh: _onRefresh,
          childWidget: _build_grid_view(logic.homeMovieInfo.value.shortVideo),
        ),
      );
    });
  }

  _build_grid_view(List<ShortVideo> shortVideo) {
    return GridView.builder(
      itemCount: shortVideo.length,
      //屏蔽无限高度
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //数量
          crossAxisCount: 2,
          //横向间隔
          crossAxisSpacing: ScreenUtil().setWidth(10),
          //纵向间隔
          // mainAxisSpacing: ScreenUtil().setWidth(8),
          //宽高比
          childAspectRatio: 1.17),
      itemBuilder: (context, index) {
        return _build_short_movie_item(shortVideo[index]);
      },
    );
  }

  _build_short_movie_item(ShortVideo shortVideo) {
    return GestureDetector(
      onTap: () {
        _jump_detaill(shortVideo.content.id);
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //图片
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10)),
              child: Container(
                width: double.infinity,
                height: ScreenUtil().setHeight(154),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        shortVideo.content.cover,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.76, 0.9),
                      child: Text(
                        shortVideo.content.videoDurationStr,
                        style: TextStyle(
                            color: hexToColor('#f4f4f4'), fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(8)),
              child: Text(
                shortVideo.content.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /**
   * 跳转到详情页
   */
  void _jump_detaill(int id) {
    Get.toNamed(RouteConfig.short_movie_play, arguments: {'movieId': id});
  }
}
