import 'dart:convert' as convert;

import 'package:get/get.dart';
import 'package:movie_flz/config/Global.dart';
import 'package:movie_flz/config/NetTools.dart';

import 'model/ShortMovieDetailModel.dart';

class ShortMoviePlayLogic extends GetxController {
  final shortMovieInfo = ShortMovieDetailModel().obs;
  //获取用户项目列表
  Future<void> getShortMovieInfo({movieId}) async {
    var r = await NetTools.dio.get<String>(
        "v3plus/video/detail?albumId=&token=rrtv-4277f839d5c35e69f81da643d8cc5ff2c95b0378&videoId=${movieId}");
    //缓存
    print('信息呢===>>>>>${r.data}');
    Global.netCache.cache.clear();
    shortMovieInfo.update((val) {
      ShortMovieDetailModel tempModel =
          ShortMovieDetailModel.fromJson(convert.jsonDecode(r.data)['data']);
      val.recommendVideoList.addAll(tempModel.recommendVideoList);
    });
    //json 转 Map 转 更新
  }
}
