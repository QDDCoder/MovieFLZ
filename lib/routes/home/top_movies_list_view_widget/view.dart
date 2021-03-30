import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:get/get.dart';
import 'package:movie_flz/routes/home/gess_you_like/model/GessYouLikeModel.dart';
import 'package:movie_flz/routes/home/home_root/views/HomeMovieView.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'logic.dart';

class TopMoviesListViewWidgetPage extends StatefulWidget {
  @override
  _TopMoviesListViewWidgetPageState createState() =>
      _TopMoviesListViewWidgetPageState();
}

class _TopMoviesListViewWidgetPageState
    extends State<TopMoviesListViewWidgetPage> with TickerProviderStateMixin {
  final TopMoviesListViewWidgetLogic logic =
      Get.put(TopMoviesListViewWidgetLogic());

  final TopMoviesListViewListLogic logicList =
      Get.put(TopMoviesListViewListLogic());

  TabController _tabController;

  @override
  void initState() {
    logic.getTopTapList(sectionId: Get.arguments['sectionId']).then(
      (value) {
        _tabController = TabController(
            length: logic.topTapModel.value.tab.length, vsync: this)
          ..addListener(
            () {
              //更新选中的index
              setState(
                () {
                  logic.update_top_select(_tabController.index);
                },
              );
            },
          );
      },
    );
    // print('===>>>${}');

    super.initState();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _onRefresh() async {
    logicList
        .getMoreMoviesList(
            id: logic.topTapModel.value.tab[logic.top_select].id, refresh: true)
        .then((value) {
      _refreshController.refreshCompleted();
    });
  }

  _onLoading() async {
    logicList
        .getMoreMoviesList(
            id: logic.topTapModel.value.tab[logic.top_select].id,
            refresh: false)
        .then((value) {
      _refreshController.loadComplete();
    });

    // await logic.getMoreMoviesList(id: _seriesId, refresh: false).then((value) {
    //   if (logic.movieModel.value.total ==
    //       logic.movieModel.value.content.length) {
    //     //停止刷新
    //     _refreshController.loadNoData();
    //   } else {
    //     _refreshController.loadComplete();
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //去除ListView的顶部空白
      body: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        //创建ListView
        child: PullAndPushWidget(
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            childWidget: _build_list_widget()),
      ),
    );
  }

  _build_list_widget() {
    //listView 嵌套 主要是 顶部和list有嵌套覆盖
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return Obx(() {
          return Stack(
            children: [
              ///顶部的信息
              MoreMoviesListViewTopWidget(
                title: logic.topTapModel.value.title ?? '',
                subTitle: logic.topTapModel.value.subTitle == null
                    ? ''
                    : logic.topTapModel.value.subTitle,
                coverUrl: logicList.movieModel.value.content.length > 0
                    ? logicList.movieModel.value.content.first.coverUrl
                    : '',
                totalTitle:
                    'TOP ${logic.topTapModel.value.tab.length == 0 ? 20 : logic.topTapModel.value.tab[logic.top_select].relevanceCount}',
                backAction: () {
                  Get.back();
                },
              ),
              //中间的tapBar
              _build_center_tab(),
              Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(447)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(ScreenUtil().setWidth(10)),
                      topLeft: Radius.circular(ScreenUtil().setWidth(10))),
                  color: Colors.white,
                ),
                child: logic.topTapModel.value.tab.length == 0
                    ? Container()
                    : SizedBox(
                        width: ScreenUtil().screenWidth,
                        height: ScreenUtil().screenHeight,
                        child: TabBarView(
                          controller: _tabController,
                          children: logic.topTapModel.value.tab.map((e) {
                            return ContainerListView(
                              select_id: e.id,
                            );
                          }).toList(),
                        ),
                      ),
              ),
            ],
          );
        });
      },
    );
  }

  /**
   *创建bar
   */
  getTab() {
    return logic.topTapModel.value.tab.map((e) {
      return Tab(
        child: Text(
          e.name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }).toList();
  }

  _build_center_tab() {
    return _tabController == null
        ? Container()
        : Container(
            margin: EdgeInsets.only(top: ScreenUtil().setHeight(380)),
            height: ScreenUtil().setHeight(66),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ScreenUtil().setWidth(10)),
                topRight: Radius.circular(
                  ScreenUtil().setWidth(10),
                ),
              ),
            ),
            child: TabBar(
              indicatorColor: Colors.indigoAccent,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 3,
              isScrollable: true,
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black45,
              tabs: getTab(),
            ),
          );
  }
}

class ContainerListView extends StatefulWidget {
  final int select_id;

  const ContainerListView({Key key, this.select_id}) : super(key: key);
  @override
  _ContainerListViewState createState() => _ContainerListViewState();
}

class _ContainerListViewState extends State<ContainerListView> {
  final TopMoviesListViewListLogic logicList =
      Get.put(TopMoviesListViewListLogic());

  List<GessYouLikeItmeModel> content = List<GessYouLikeItmeModel>();

  @override
  void initState() {
    // TODO: implement initState
    logicList
        .getMoreMoviesList(id: widget.select_id, refresh: true)
        .then((value) => {content = value.content});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        itemCount: logicList.movieModel.value.content.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return GessYouLikeListItemWidget(
            model: logicList.movieModel.value.content[index],
          );
        },
      );
    });
  }
}
