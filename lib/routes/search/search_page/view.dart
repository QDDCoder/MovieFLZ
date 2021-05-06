import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie_flz/tools/Toast.dart';

import 'logic.dart';
import 'model/MainSearchModel.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  final SearchPageLogic logic = Get.put(SearchPageLogic());
  final FocusNode focusNode = FocusNode();
  TextEditingController _textEditingController = TextEditingController();

  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    logic.getSearchList();
    logic.getMainSearchModel().then((value) {
      tabController = TabController(
          length: logic.mainSearchModel.value.data.length, vsync: this);
    });

    _textEditingController.addListener(() {
      // print('输入框输入的内容=====>>>${_textEditingController.text}');
      logic.updateRecommandKey(key: _textEditingController.text);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            //顶部的广告的
            _build_bg_view(),

            _build_back_button(),

            _build_search_input_view(),
          ],
        ),
      );
    });
  }

  _build_back_button() {
    return Align(
      alignment: Alignment(-0.86, -0.8),
      child: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: CircleAvatar(
          child: Icon(
            Icons.arrow_back_ios_sharp,
            size: ScreenUtil().setWidth(32),
          ),
        ),
      ),
    );
  }

  _build_bg_view() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //顶部的背景广告
        _build_top_bg_view(),
        logic.recommandKey.value == ""
            ? _build_recommand_key_widget()
            : _build_recommand_search_list(),
      ],
    );
  }

  //搜索内容为空时的底部信息
  _build_recommand_key_widget() {
    return Column(
      children: [
        //搜索历史的头部
        logic.historyList[logic.historyListkey] == null
            ? Container()
            : _build_search_history_title(),
        //历史搜索
        logic.historyList[logic.historyListkey] == null
            ? Container()
            : _build_search_history(),
        //搜索推荐列表
        _build_search_tap_widget(),
        Divider(),
        //创建底部的tabView
        _build_tab_view(),
      ],
    );
  }

  /**
   * 推荐搜索
   */
  _build_recommand_search_list() {
    var totalLength = logic.recommandKeyModel.value.data.searchTips.length +
        logic.recommandKeyModel.value.data.seasonList.length;
    return Expanded(
        child: Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(50)),
      // height: ScreenUtil().setHeight(200),
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: Obx(() {
          return ListView(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:
                      logic.recommandKeyModel.value.data.seasonList.length,
                  itemBuilder: (context, index) {
                    var model =
                        logic.recommandKeyModel.value.data.seasonList[index];
                    return Container(
                      height: ScreenUtil().setHeight(120),
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                ScreenUtil().setWidth(18)),
                            child: Container(
                              height: ScreenUtil().setHeight(100),
                              width: ScreenUtil().setWidth(90),
                              child: Image.network(
                                logic.recommandKeyModel.value.data
                                    .seasonList[index].cover,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: ScreenUtil().setWidth(20),
                                top: ScreenUtil().setHeight(4)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '${model.score}/${model.classify}/${model.year}/${model.area}/${model.cat}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 13),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(6)),
                                  child: Text(
                                    model.actor,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:
                      logic.recommandKeyModel.value.data.searchTips.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _textEditingController.text = logic.recommandKeyModel
                            .value.data.searchTips[index].title;
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin:
                            EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                        height: ScreenUtil().setHeight(64),
                        child: Text(
                          logic.recommandKeyModel.value.data.searchTips[index]
                              .title,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  }),
            ],
          );
        }),
      ),
    ));
  }

  _build_top_bg_view() {
    return Container(
      height: ScreenUtil().setHeight(390),
      color: Colors.blue,
    );
  }

  _build_search_history_title() {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20)),
        margin: EdgeInsets.only(
          top: ScreenUtil().setHeight(53),
        ),
        // color: Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '搜索历史',
              // textAlign: ,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            GestureDetector(
              onTap: () {
                logic.clearAllHistory();
              },
              child: Icon(
                Icons.delete_outline_sharp,
                color: Colors.black26,
              ),
            ),
          ],
        ));
  }

  _build_search_history() {
    return Container(
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20)),
      width: ScreenUtil().screenWidth - ScreenUtil().setWidth(40),
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: ScreenUtil().setWidth(20),
        runSpacing: -6,
        children: List.generate(
          logic.historyList[logic.historyListkey] == null
              ? 0
              : logic.historyList[logic.historyListkey][logic.historyListInkey]
                  .length,
          (index) {
            return InkWell(
              onTap: () {
                // _controller.text = searchValue;
              },
              child: Chip(
                backgroundColor: Colors.black12.withOpacity(0.06),
                label: Text(
                  logic.historyList[logic.historyListkey]
                      [logic.historyListInkey][index],
                  style: TextStyle(color: Colors.black45),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _build_search_input_view() {
    return Align(
      alignment: Alignment(0, -0.45),
      child: Container(
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
        height: ScreenUtil().setHeight(80),
        margin: EdgeInsets.only(
            left: ScreenUtil().setWidth(40), right: ScreenUtil().setWidth(40)),
        decoration: BoxDecoration(
          boxShadow: [
            //阴影
            BoxShadow(
              color: Colors.black12.withOpacity(0.06), //底色,阴影颜色
              offset: Offset(0, 3), //阴影位置,从什么位置开始
              blurRadius: 4, // 阴影模糊层度
              spreadRadius: 1, //阴影模糊大小
            )
          ],
          borderRadius: BorderRadius.circular(
            ScreenUtil().setHeight(40),
          ),
          color: Colors.white,
        ),
        child: Row(
          children: [
            //左侧的搜索图标
            Icon(
              Icons.search,
              color: Colors.black38,
            ),
            //中间的输入框
            Expanded(
              child: TextField(
                focusNode: focusNode,
                controller: _textEditingController,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  // labelText: '请输入你的姓名',
                  hintText: "用户名或邮箱",
                  border: InputBorder.none,
                ),
                onSubmitted: (val) {
                  if (_textEditingController.text == '') {
                    showToast('输入内容不能为空');
                  } else {
                    logic.saveSearchList(
                        serachInfo: _textEditingController.text);
                  }
                },
              ),
            ),
            //右侧的close图标
            GestureDetector(
              onTap: () {
                _textEditingController.text = '';
              },
              child: Icon(
                Icons.clear,
                color: Colors.black38,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///建立搜索的推荐
  _build_search_tap_widget() {
    return logic.mainSearchModel.value.data.length == 0
        ? Container()
        : Container(
            margin: EdgeInsets.only(top: ScreenUtil().setHeight(46)),
            height: ScreenUtil().setHeight(50),
            // color: Colors.white,
            child: Theme(
              data: ThemeData(
                //默认显示的背景颜色
                backgroundColor: Colors.transparent,
                //点击的背景高亮颜色
                highlightColor: Colors.transparent,
                //点击水波纹颜色
                splashColor: Colors.transparent,
                textSelectionColor: Colors.black,
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 1,
                indicatorColor: Colors.transparent,
                labelStyle:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                unselectedLabelStyle: TextStyle(fontSize: 16),
                labelColor: Colors.black,
                isScrollable: true,
                controller: tabController,
                tabs: getTab(),
              ),
            ),
          );
  }

  getTab() {
    return logic.mainSearchModel.value.data
        .map((e) => Tab(
              child: Text(
                e.hotRecommend,
              ),
            ))
        .toList();
  }

  _build_tab_view() {
    return (logic.mainSearchModel.value.data.length == 0)
        ? Container()
        : Container(
            margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(0),
              left: ScreenUtil().setWidth(20),
              right: ScreenUtil().setWidth(20),
            ),
            height: ScreenUtil().setHeight(500),
            child: TabBarView(
              controller: tabController,
              children: logic.mainSearchModel.value.data.map((e) {
                return _build_search_tj_grid_view(e);
              }).toList(),
            ),
          );
  }

  Widget _build_search_tj_grid_view(MainSearchModelListData data) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.searchRecommendDtos.length,
        //屏蔽无限高度
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //数量
          crossAxisCount: 2,
          //横向间隔
          crossAxisSpacing: ScreenUtil().setWidth(10),
          //纵向间隔
          mainAxisSpacing: ScreenUtil().setWidth(8),
          //宽高比
          childAspectRatio: 4.2,
        ),
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(4), top: ScreenUtil().setHeight(4)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //排名头部
                Container(
                  margin: EdgeInsets.only(
                      left: ScreenUtil().setWidth(10),
                      top: ScreenUtil().setHeight(2),
                      right: ScreenUtil().setWidth(10)),
                  child: Text(
                    '${data.searchRecommendDtos[index].orderNum}',
                    style: TextStyle(
                        color: data.searchRecommendDtos[index].orderNum <= 3
                            ? Colors.redAccent
                            : Colors.black26,
                        fontSize: 16),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //名字和标识
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin:
                              EdgeInsets.only(top: ScreenUtil().setHeight(2)),
                          child: Text(
                            data.searchRecommendDtos[index].title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 16, height: 1.1),
                          ),
                        ),
                        data.searchRecommendDtos[index].label == ''
                            ? Container()
                            : Container(
                                margin: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(6),
                                    top: ScreenUtil().setHeight(4)),
                                padding: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(5),
                                    right: ScreenUtil().setWidth(5),
                                    bottom: ScreenUtil().setHeight(2)),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      ScreenUtil().setWidth(4)),
                                  color: Colors.redAccent,
                                ),
                                child: Text(
                                  data.searchRecommendDtos[index].label,
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white),
                                ),
                              ),
                      ],
                    ),
                    //底部的subtittle
                    Text(
                      data.searchRecommendDtos[index].subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: Colors.black26),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
