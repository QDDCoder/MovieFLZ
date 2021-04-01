import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:get/get.dart';
import 'package:movie_flz/routes/home/gess_you_like/model/GessYouLikeModel.dart';
import 'package:movie_flz/routes/home/home_root/views/HomeMovieView.dart';
import 'package:movie_flz/tools/Sheet.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'logic.dart';
import 'model/SeasonRankListMovieModel.dart';

/**
 * 排行榜
 */

class SeasonRankPage extends StatefulWidget {
  @override
  _SeasonRankPageState createState() => _SeasonRankPageState();
}

class _SeasonRankPageState extends State<SeasonRankPage>
    with TickerProviderStateMixin {
  final SeasonRankLogic logicSeason = Get.put(SeasonRankLogic());

  final SeasonRankListViewListLogic logicListSeason =
      Get.put(SeasonRankListViewListLogic());

  TabController _tabController;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  ScrollController _scrollController = ScrollController();

  double _scoll_offset = 0.0;

  @override
  void initState() {
    //获取顶部的tap
    logicSeason.getTopTapList().then((value) {
      _tabController = TabController(
          length: logicSeason.topTapModel.value.filmTelevsionList.length,
          vsync: this)
        ..addListener(
          () {
            //更新选中的index
            setState(
              () {
                logicSeason.update_top_select(_tabController.index);
              },
            );
          },
        );
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
   * 下拉刷新
   */
  _onRefresh() async {
    _then_top_season_refush_data(refush: true).then((value) {
      if (value.isEnd) {
        _refreshController.loadNoData();
      }
      _refreshController.refreshCompleted();
    });
  }

  /**
   * 上拉加载更多
   */
  _onLoading() async {
    _then_top_season_refush_data(refush: false).then((value) {
      if (value.isEnd) {
        _refreshController.loadNoData();
      }
      _refreshController.loadComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () {
          return logicSeason.topTapModel.value.filmTelevsionList.length > 0
              ? DefaultTabController(
                  length:
                      logicSeason.topTapModel.value.filmTelevsionList.length,
                  child: NestedScrollView(
                    controller: _scrollController,
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverOverlapAbsorber(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                          //SliverAppBar
                          sliver: _build_SliverAppBar(),
                        ),
                      ];
                    },
                    //scroll_body
                    body: _build_scroll_body_view(),
                  ),
                )
              : Container();
        },
      ),
    );
  }

  SliverAppBar _build_SliverAppBar() {
    return SliverAppBar(
      //为true则appbar不消失，在下拉时会多划出一段距离SliverAppBar才开始滚动
      pinned: true,
      //最大扩展高度
      expandedHeight: ScreenUtil().setHeight(370),
      primary: true,
      title: Text(
        '风云榜',
        style: TextStyle(
            color: Colors.black45.withOpacity(_scoll_offset > 100 ? 1 : 0)),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(
          color: (_scoll_offset > 100) ? Colors.black45 : Colors.white),
      flexibleSpace: _build_flexible_space_bar(),
      bottom: _build_no_inkwell_bar(),
      actions: [
        Visibility(
          visible: _scoll_offset > 100,
          child: IconButton(
              icon: Icon(Icons.thumbs_up_down),
              onPressed: () {
                //底部的选择框
                _show_bottom_change_action().then((value) {
                  if (value != null && value >= 1) {
                    //状态更新保存
                    logicSeason.update_top_season_list_select(value);
                    //发起网络请求
                    _then_top_season_refush_data();
                  }
                });
              }),
        )
      ],
    );
  }

  //顶部的扩展内容区域
  _build_flexible_space_bar() {
    return FlexibleSpaceBar(
      collapseMode: CollapseMode.pin,
      background: Stack(
        children: [
          Obx(() {
            //顶部的背景图
            return _build_top_bg();
          }),
          //排行榜切换
          _build_season_change(),
          //tabbar的背景view
          _build_tabbar_bg_view(),
        ],
      ),
    );
  }

  //中间的TabBarView嵌套ListView
  _build_scroll_body_view() {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(196)),
      child: TabBarView(
        controller: _tabController,
        children: logicSeason.topTapModel.value.filmTelevsionList.map((e) {
          return Builder(builder: (context) {
            //上下拉组件
            return PullAndPushWidget(
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              childWidget: CustomScrollView(
                key: PageStorageKey<String>(e.name),
                slivers: [
                  //列表
                  TopSeasonlistViewBody(),
                ],
              ),
            );
          });
        }).toList(),
      ),
    );
  }

  /**
   *创建bar
   */
  getTab() {
    return logicSeason.topTapModel.value.filmTelevsionList.map((e) {
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

  Widget _build_top_bg() {
    return MoreMoviesListViewTopWidget(
      hidden_tool_bar: true,
      title: '',
      subTitle: '',
      coverUrl: logicSeason.topTapModel.value.filmTelevsionList.length > 0
          ? logicSeason.topTapModel.value
              .filmTelevsionList[logicSeason.top_select].imgUrl
          : '',
      totalTitle: '',
      backAction: () {
        Get.back();
      },
    );
  }

  _build_tabbar_bg_view() {
    return Align(
      alignment: Alignment(0, 1),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              ScreenUtil().setWidth(10),
            ),
            topRight: Radius.circular(
              ScreenUtil().setWidth(10),
            ),
          ),
        ),
        height: 48,
      ),
    );
  }

  //顶部的切换按钮
  _build_season_change() {
    return Obx(() {
      return Align(
        alignment: Alignment(-0.94, 0.46),
        child: Container(
          height: ScreenUtil().setHeight(28),
          width: ScreenUtil().setWidth(160),
          child: LZClickImageAndTitleBtn(
            mainAxisAlignment: MainAxisAlignment.center,
            image: Icon(
              Icons.thumbs_up_down,
              color: Colors.white70,
              size: ScreenUtil().setWidth(28),
            ),
            imageSize: Size(38, 38),
            title: logicSeason.top_areason_title.value,
            padding: ScreenUtil().setWidth(10),
            fontSize: 15,
            textColor: Colors.white70,
            onTap: () {
              _show_bottom_change_action().then((value) {
                if (value != null && value >= 1) {
                  //状态更新保存
                  logicSeason.update_top_season_list_select(value);
                  //发起网络请求
                  _then_top_season_refush_data();
                }
              });
            },
          ),
        ),
      );
    });
  }

  /**
   * 切换过排行榜方式之后刷新数据
   */

  Future<SeasonRankListMovieModel> _then_top_season_refush_data(
      {refush = true}) {
    //获取area
    var area = logicSeason
        .topTapModel.value.filmTelevsionList[logicSeason.top_select].key;
    //获取range
    var range = '';
    logicSeason.show_seanson.forEach((element) {
      if (element['isSelect'] == 1) {
        range = element['range'];
      }
    });
    return logicListSeason.getMoviesList(
        refresh: refush, range: range, area: area);
  }

  /**
   * 顶部的排行榜方式
   */
  Future<int> _show_bottom_change_action() {
    return showCustomBottomSheet(
      context: context,
      title: '',
      cancelTitle: '取消',
      children: logicSeason.show_seanson.map((e) {
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

  /**
   * 不点点击水波纹的TabBar
   */
  _build_no_inkwell_bar() {
    return PreferredSize(
      preferredSize: Size(0, ScreenUtil().setHeight(40)),
      child: Container(
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
            indicatorColor: Colors.indigoAccent,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3,
            isScrollable: true,
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black45,
            //Tab的集合
            tabs: getTab(),
          ),
        ),
      ),
    );
  }
}

/**
 * 底部的ListView
 */
class TopSeasonlistViewBody extends StatefulWidget {
  @override
  _TopSeasonlistViewBodyState createState() => _TopSeasonlistViewBodyState();
}

class _TopSeasonlistViewBodyState extends State<TopSeasonlistViewBody> {
  List<GessYouLikeItmeModel> content = List<GessYouLikeItmeModel>();

  final SeasonRankListViewListLogic logicListSeason =
      Get.put(SeasonRankListViewListLogic());

  final SeasonRankLogic logicSeason = Get.put(SeasonRankLogic());

  @override
  void initState() {
    // TODO: implement initState
    _then_top_season_refush_data();

    super.initState();
  }

  _then_top_season_refush_data() {
    //获取area
    var area = logicSeason
        .topTapModel.value.filmTelevsionList[logicSeason.top_select].key;
    //获取range
    logicSeason.show_seanson.forEach((element) {
      if (element['isSelect'] == 1) {
        logicListSeason.getMoviesList(
            refresh: true, range: element['range'], area: area);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SliverFixedExtentList(
        itemExtent: ScreenUtil().setHeight(186),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            SeasonRankListMovieItemModel model =
                logicListSeason.listModel.value.results[index];
            return Container(
              color: Colors.white,
              child: GessYouLikeListItemWidget(
                coverUrl: model.cover,
                name: model.title,
                score: model.score,
                type:
                    '${model.dramaType}/${model.year}/${model.area}/${model.cat}',
                actor: model.actor,
              ),
            );
          },
          childCount: logicListSeason.listModel.value.results.length,
        ),
      );
    });
  }
}
