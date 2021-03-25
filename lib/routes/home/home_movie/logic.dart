import 'dart:convert' as convert;

import 'package:get/get.dart';
import 'package:movie_flz/config/Global.dart';
import 'package:movie_flz/config/NetTools.dart';

import 'Model/HomeMovieModel.dart';

class HomeMovieLogic extends GetxController {
  final homeMovieInfo = HomeMoveModel().obs;
  //获取用户项目列表
  Future<void> getMovieInfo(
      { //query参数，用于接收分页信息
      refresh = false}) async {
    var r = await NetTools.dio.get<String>(
      "v3plus/index/channel?pageNum=1&position=CHANNEL_INDEX",
    );
    //缓存
    Global.netCache.cache.clear();
    homeMovieInfo.update((val) {
      HomeMoveModel tempModel =
          HomeMoveModel.fromJson(convert.jsonDecode(r.data)['data']);
      val.bean = tempModel.bean;
      val.bannerTop = tempModel.bannerTop;
      val.guessFavorite = tempModel.guessFavorite;
      val.sections = tempModel.sections;
    });
    //json 转 Map 转 更新
  }
}
