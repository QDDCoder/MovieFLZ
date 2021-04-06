import 'dart:convert' as convert;

import 'package:get/get.dart';
import 'package:movie_flz/config/Global.dart';
import 'package:movie_flz/config/NetTools.dart';

import 'model/LookMovieModel.dart';

class LookLogic extends GetxController {
//https://api.rr.tv/video/dramaList?closeRecommend=0

  final movieDatas = LookMovieModel().obs;
  //获取猜你喜欢的列白数据
  Future<void> movieDatasList({refresh = true}) async {
    var r = await NetTools.dio.get<String>(
      "video/dramaList?closeRecommend=0",
    );
    //缓存
    Global.netCache.cache.clear();
    //解析List数据 并反馈出去
    movieDatas.update((val) {
      var tempModle = LookMovieModel.fromJson(convert.jsonDecode(r.data));
      val.data.addAll(tempModle.data);
    });
  }
}
