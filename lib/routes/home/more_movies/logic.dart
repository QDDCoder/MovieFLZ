import 'dart:convert' as convert;

import 'package:get/get.dart';
import 'package:movie_flz/config/Global.dart';
import 'package:movie_flz/config/NetTools.dart';

import 'model/MoreMovieModel.dart';

class MoreMoviesLogic extends GetxController {
//https://api.rr.tv/index/series/sheet/detail?id=58311&page=1&rows=10
//'https://api.rr.tv/',
  final movieModel = MoreMovieModel().obs;

  int _page_number = 1;
  //获取用户项目列表
  Future<void> getMoreMoviesList(
      { //query参数，用于接收分页信息
      refresh = false,
      id}) async {
    _page_number = refresh ? 1 : _page_number + 1;

    var r = await NetTools.dio.get<String>(
      "index/series/sheet/detail?id=${id}&page=${_page_number}&rows=10",
    );

    //缓存
    Global.netCache.cache.clear();
    movieModel.update((val) {
      var tempModel =
          MoreMovieModel.fromJson(convert.jsonDecode(r.data)['data']);
      if (refresh) {
        //刷新
        val.content.clear();
        val.title = tempModel.title;
        val.subTitle = tempModel.subTitle;
        val.total = tempModel.total;
      }
      val.content.addAll(tempModel.content);
    });
  }
}
