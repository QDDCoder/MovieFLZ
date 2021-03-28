import 'dart:convert' as convert;

import 'package:get/get.dart';
import 'package:movie_flz/config/Global.dart';
import 'package:movie_flz/config/NetTools.dart';
import 'package:movie_flz/routes/home/gess_you_like/model/GessYouLikeModel.dart';

class GessYouLikeLogic extends GetxController {
  final gessYouLikeList = GessYouLikeModel().obs;

  //获取猜你喜欢的列白数据
  Future<void> getGessYouLikeList() async {
    var r = await NetTools.dio.get<String>(
      "drama/app/guess_user_like?isRecByUser=1",
    );
    //缓存
    Global.netCache.cache.clear();
    //解析List数据 并反馈出去
    gessYouLikeList.update((val) {
      var tempModle =
          GessYouLikeModel.fromJson(json: convert.jsonDecode(r.data));
      val.itemList.addAll(tempModle.itemList);
      print(val.itemList);
    });
  }
}
