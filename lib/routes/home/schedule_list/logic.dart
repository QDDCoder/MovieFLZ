import 'dart:convert' as convert;

import 'package:get/get.dart';
import 'package:movie_flz/config/Global.dart';
import 'package:movie_flz/config/NetTools.dart';
import 'package:movie_flz/tools/DateTools.dart';

import 'model/SeasonDate.dart';
import 'model/SeasonRankListModel.dart';

class ScheduleListLogic extends GetxController {
  //https://api.rr.tv/schedule/listV2

  final dayInfos = SeasonDate().obs;

  final listModel = ScheduleListModel().obs;

  Future<void> getDays(year, month) async {
    var days = LZDateUtils.currentMonthWeekDays(year, month);
    dayInfos.update((val) {
      val.days = days;
      val.days[DateTime.now().day]['select'] = 1;
    });
  }

  //点击了日期更新选中的位置
  Future<void> updateSelect(index) async {
    dayInfos.value.days.forEach((element) {
      element['select'] = 0;
    });
    var temp = dayInfos.value.days[index];
    temp['select'] = 1;
    dayInfos.update((val) {
      val.days[index] = temp;
    });
    // print('点击了什么啊${}');
    getMoviesList(date: '2021-4-${dayInfos.value.days[index]['day']}');
  }

  Future<void> getMoviesList({refresh = false, date, type = ''}) async {
    var r = await NetTools.dio.get<String>(
        'schedule/listV2?date=${date}&type=${type}&userId=${86456186}');
    //缓存
    Global.netCache.cache.clear();
    var tempModel =
        ScheduleListModel.fromJson(convert.jsonDecode(r.data)['data']);
    listModel.update((val) {
      val.scheduleList.clear();
      val.scheduleList.addAll(tempModel.scheduleList);
    });
    print('数据呢=>>>>>${tempModel.scheduleList}');
  }
}
