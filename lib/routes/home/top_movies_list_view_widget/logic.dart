import 'dart:convert' as convert;

import 'package:get/get.dart';
import 'package:movie_flz/config/Global.dart';
import 'package:movie_flz/config/NetTools.dart';
import 'package:movie_flz/routes/home/more_movies/model/MoreMovieModel.dart';

import 'model/MoreMoviesListTopTapModel.dart';

class TopMoviesListViewWidgetLogic extends GetxController {
  final topTapModel = MoreMoviesListTopTapModel().obs;
  int top_select = 0;

  update_top_select(int topSelect) {
    top_select = topSelect;
  }

  //获取顶部的tap
  Future<void> getTopTapList({sectionId}) async {
    var r = await NetTools.dio.get<String>(
      "index/series/top/detail/tab?sectionId=3177",
    );
    //缓存
    Global.netCache.cache.clear();

    topTapModel.update((val) {
      var tempModel = MoreMoviesListTopTapModel.fromJson(
          convert.jsonDecode(r.data)['data']);
      val.title = tempModel.title;
      val.subTitle = tempModel.subTitle;
      val.tab = tempModel.tab;
      print(val.title);
    });
  }
}

/**
 * 下面的List
 */
class TopMoviesListViewListLogic extends GetxController {
  int _page_number = 1;

  final movieModel = MoreMovieModel().obs;

  //获取用户项目列表
  Future<MoreMovieModel> getMoreMoviesList(
      { //query参数，用于接收分页信息
      refresh = false,
      id}) async {
    _page_number = refresh ? 1 : _page_number + 1;

    var r = await NetTools.dio.get<String>(
      'index/series/top/detail/drama?id=${id}&page=${_page_number}&rows=10',
    );

    //缓存
    Global.netCache.cache.clear();
    var tempModel = MoreMovieModel.fromJson(convert.jsonDecode(r.data)['data']);
    movieModel.update((val) {
      if (refresh) {
        //刷新
        val.content.clear();
        val.total = tempModel.total;
      }
      val.content.addAll(tempModel.content);
    });
    return tempModel;
  }
}
