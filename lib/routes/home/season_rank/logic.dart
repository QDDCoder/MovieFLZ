import 'dart:convert' as convert;

import 'package:get/get.dart';
import 'package:movie_flz/config/Global.dart';
import 'package:movie_flz/config/NetTools.dart';
import 'package:movie_flz/routes/home/season_rank/model/SeasonRankModel.dart';

import 'model/SeasonRankListMovieModel.dart';

class SeasonRankLogic extends GetxController {
  final topTapModel = SeasonRankTopTapModel().obs;

  List<Map> show_seanson = [
    {'num': 1, 'name': '日排行榜', 'isSelect': 1, 'range': 'T-1'},
    {'num': 2, 'name': '周排行榜', 'isSelect': 0, 'range': 'T-7'},
    {'num': 3, 'name': '月排行榜', 'isSelect': 0, 'range': 'T-30'},
    {'num': 4, 'name': '全部排行', 'isSelect': 0, 'range': 'ALL'},
  ];

  int top_select = 0;

  final top_areason_title = '日排行榜'.obs;

  update_top_select(int topSelect) {
    top_select = topSelect;
  }

  //获取顶部的tap
  Future<void> getTopTapList({sectionId}) async {
    var r = await NetTools.dio.get<String>(
      "v3plus/index/category",
    );

    //缓存
    Global.netCache.cache.clear();
    topTapModel.update((val) {
      var tempModel =
          SeasonRankTopTapModel.fromJson(convert.jsonDecode(r.data)['data']);
      //去除电影的tap
      tempModel.filmTelevsionList.removeAt(0);
      val.filmTelevsionList.addAll(tempModel.filmTelevsionList);
    });
  }

  //修改顶部的排行榜排序方式
  update_top_season_list_select(num) {
    show_seanson.forEach((element) {
      //先置为0
      element['isSelect'] = 0;
      if (element['num'] == num) {
        element['isSelect'] = 1;
        top_areason_title.value = element['name'];
      }
    });
  }
}

/**
 * 下面的List
 */
class SeasonRankListViewListLogic extends GetxController {
  int _page_number = 1;

  final listModel = SeasonRankListMovieModel().obs;

  //获取用户项目列表
  Future<SeasonRankListMovieModel> getMoviesList(
      {refresh = false, range = 'T-1', area}) async {
    // print('发起网络请求了啊-======>>>>');

    _page_number = refresh ? 1 : _page_number + 1;

    var r = await NetTools.dio.get<String>(
        'v3plus/season/topList?area=${area}&page=${_page_number}&range=${range}');

    //缓存
    Global.netCache.cache.clear();

    var tempModel =
        SeasonRankListMovieModel.fromJson(convert.jsonDecode(r.data)['data']);
    listModel.update((val) {
      if (refresh) {
        //刷新
        val.results.clear();
      }
      val.results.addAll(tempModel.results);
    });
    return tempModel;
  }
}
