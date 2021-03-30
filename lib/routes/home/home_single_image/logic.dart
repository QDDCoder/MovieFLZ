import 'dart:convert' as convert;

import 'package:get/get.dart';
import 'package:movie_flz/config/Global.dart';
import 'package:movie_flz/config/NetTools.dart';

import 'model/HomeSingleModel.dart';

class HomeSingleImageLogic extends GetxController {
  final homeSingleModel = HomeSingleModel().obs;

  final titleInfo = ''.obs;
  final ClipboardInfo = ''.obs;
  //获取日报的信息头
  Future<void> getHomeSingleImageNavigator({navigationId}) async {
    var r = await NetTools.dio.get<String>(
      "v3plus/index/navigation/summary?navigationId=${navigationId}",
    );
    //缓存
    Global.netCache.cache.clear();
    var response = convert.jsonDecode(r.data)['data']['navigation'];
    //解析List数据 并反馈出去
    titleInfo.value = response['title'];
    ClipboardInfo.value = response['shareLink'];
  }

  //获取番茄日报信息
  Future<void> getHomeSingleImage({navigationId}) async {
    var r = await NetTools.dio.get<String>(
      "v3plus/index/navigation/detail?navigationId=${navigationId}",
    );
    //缓存
    Global.netCache.cache.clear();
    //解析List数据 并反馈出去
    homeSingleModel.update((val) {
      var tempModle =
          HomeSingleModel.fromJson(json: convert.jsonDecode(r.data)['data']);
      val.sections.clear();
      val.sections.addAll(tempModle.sections);
    });
  }
}
