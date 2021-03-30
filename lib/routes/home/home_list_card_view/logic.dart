import 'dart:convert' as convert;

import 'package:get/get.dart';
import 'package:movie_flz/config/Global.dart';
import 'package:movie_flz/config/NetTools.dart';

import 'model/ListCardViewModel.dart';

class HomeListCardViewLogic extends GetxController {
  final movieModel = ListCardViewModel().obs;

  int _page_number = 1;

  //获取用户项目列表
  Future<void> getMoreMoviesList(
      { //query参数，用于接收分页信息
      refresh = false,
      sectionId}) async {
    _page_number = refresh ? 1 : _page_number + 1;

    var r = await NetTools.dio.get<String>(
      "index/series/sheet/list?page=${_page_number}&rows=20&sectionId=${sectionId}",
    );

    //缓存
    Global.netCache.cache.clear();

    movieModel.update((val) {
      var tempModel =
          ListCardViewModel.fromJson(json: convert.jsonDecode(r.data));
      if (refresh) {
        //刷新
        val.itemList.clear();
      }
      val.itemList.addAll(tempModel.itemList);
    });
  }
}
