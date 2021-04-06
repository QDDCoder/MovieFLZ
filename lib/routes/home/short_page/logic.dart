import 'dart:convert' as convert;

import 'package:get/get.dart';
import 'package:movie_flz/config/Global.dart';
import 'package:movie_flz/config/NetTools.dart';

import 'model/ShortPageModel.dart';

class ShortPageLogic extends GetxController {
  final homeMovieInfo = ShortPageModel().obs;
  int _page_number = 1;
  //获取用户项目列表
  Future<void> getShortMovieInfo({refresh = true}) async {
    _page_number = refresh ? 1 : _page_number + 1;

    var r = await NetTools.dio.get<String>(
      "app/v4/index/shortVideo?adPage=${_page_number}&purelyFromBigData=0&videoPage=${_page_number}",
    );
    //缓存
    Global.netCache.cache.clear();
    homeMovieInfo.update((val) {
      ShortPageModel tempModel =
          ShortPageModel.fromJson(convert.jsonDecode(r.data)['data']);
      if (refresh) {
        val.shortVideo.clear();
        val.banner.clear();
      }
      val.shortVideo.addAll(tempModel.shortVideo);
      val.banner.addAll(tempModel.banner);
    });
    //json 转 Map 转 更新
  }
}
