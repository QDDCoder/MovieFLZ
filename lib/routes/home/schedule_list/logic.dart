import 'dart:convert' as convert;

import 'package:get/get.dart';
import 'package:movie_flz/config/Global.dart';
import 'package:movie_flz/config/NetTools.dart';

import 'model/SeasonRankListModel.dart';

class ScheduleListLogic extends GetxController {
  //https://api.rr.tv/schedule/listV2

  final listModel = SeasonRankListModel().obs;

  Future<void> getMoviesList({refresh = false, date, type = ''}) async {
    var r = await NetTools.dio.get<String>(
        'schedule/listV2?date=${date}&type=${type}&userId=${86456186}');

    //缓存
    Global.netCache.cache.clear();

    var tempModel =
        SeasonRankListModel.fromJson(convert.jsonDecode(r.data)['data']);

    listModel.update((val) {
      val.scheduleList.clear();
      val.scheduleList.addAll(tempModel.scheduleList);
    });

    print('数据呢=>>>>>${tempModel.scheduleList}');
  }
}
