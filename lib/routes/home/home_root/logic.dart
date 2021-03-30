import 'dart:convert' as convert;

import 'package:get/get.dart';
import 'package:movie_flz/config/Global.dart';
import 'package:movie_flz/config/NetTools.dart';

import 'model/TopCategory.dart';

class HomeLogic extends GetxController {
  final topCategory = TopCategory().obs;
  //获取用户项目列表
  Future<void> getCategory(
      { //query参数，用于接收分页信息
      refresh = false}) async {
    var r = await NetTools.dio.get<String>(
      "v3plus/index/category",
    );
    //缓存
    Global.netCache.cache.clear();

    topCategory.update((val) {
      val.filmTelevsionList =
          TopCategory.fromJson(convert.jsonDecode(r.data)['data'])
              .filmTelevsionList;
      val.filmTelevsionList.insert(
          0,
          FilmTelevsionList(
            imgUrl: '',
            createTime: 0,
            name: '精选',
            updateTime: 0,
            id: 1,
            content: '',
            enabled: '1',
            key: '0',
            seq: 0,
          ));
    });
    //json 转 Map 转 更新
  }
}
