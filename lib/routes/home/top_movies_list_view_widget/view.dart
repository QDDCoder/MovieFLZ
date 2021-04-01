import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:get/get.dart';
import 'package:movie_flz/routes/home/gess_you_like/model/GessYouLikeModel.dart';
import 'package:movie_flz/routes/home/home_root/views/HomeMovieView.dart';
import 'package:movie_flz/tools/StringTools.dart';
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
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  ScrollController _scrollController = ScrollController();

  double _scoll_offset = 0.0;

  @override
  void initState() {
    //获取顶部的tap
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

    //监听Scrol
    _scrollController.addListener(() {
      setState(() {
        _scoll_offset = _scrollController.offset;
      });
    });

    super.initState();
  }

  _onRefresh() async {
    logicList
        .getMoreMoviesList(
            id: logic.topTapModel.value.tab[logic.top_select].id, refresh: true)
        .then((value) {
      if (logicList.movieModel.value.isEnd) {
        _refreshController.loadNoData();
      }
      _refreshController.refreshCompleted();
    });
  }

  _onLoading() async {
    logicList
        .getMoreMoviesList(
            id: logic.topTapModel.value.tab[logic.top_select].id,
            refresh: false)
        .then((value) {
      if (logicList.movieModel.value.isEnd) {
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
          return logic.topTapModel.value.tab.length > 0
              ? DefaultTabController(
                  length: logic.topTapModel.value.tab.length,
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
        logic.topTapModel.value.title,
        style: TextStyle(
            color: Colors.black45.withOpacity(_scoll_offset > 100 ? 1 : 0)),
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(
          color: (_scoll_offset > 100) ? Colors.black45 : Colors.white),
      actions: [
        //右侧分享按钮
        IconButton(
            icon: Icon(
              Icons.share,
            ),
            onPressed: () {}),
      ],
      flexibleSpace: _build_flexible_space_bar(),
      bottom: _build_no_inkwell_bar(),
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
        children: logic.topTapModel.value.tab.map((e) {
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
                  ToplistViewBody(
                    select_id: e.id,
                  ),
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

  Widget _build_top_bg() {
    return MoreMoviesListViewTopWidget(
      hidden_tool_bar: true,
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
class ToplistViewBody extends StatefulWidget {
  final int select_id;

  const ToplistViewBody({Key key, this.select_id}) : super(key: key);

  @override
  _ToplistViewBodyState createState() => _ToplistViewBodyState();
}

class _ToplistViewBodyState extends State<ToplistViewBody> {
  List<GessYouLikeItmeModel> content = List<GessYouLikeItmeModel>();

  final TopMoviesListViewListLogic logicList =
      Get.put(TopMoviesListViewListLogic());

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
      return SliverFixedExtentList(
        itemExtent: ScreenUtil().setHeight(186),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            GessYouLikeItmeModel mode =
                logicList.movieModel.value.content[index];
            //电影的item
            return Container(
                color: Colors.white,
                child: GessYouLikeListItemWidget(
                  coverUrl: mode.coverUrl,
                  name: mode.title,
                  score: mode.score,
                  type:
                      '${mode.dramaType}/${mode.year}/${changeStringList(mode.areaList)}/${changeStringList(mode.plotTypeList).replaceFirst(' ', '')}',
                  actor: changeStringList(mode.actorList),
                ));
          },
          childCount: logicList.movieModel.value.content.length,
        ),
      );
    });
  }
}
