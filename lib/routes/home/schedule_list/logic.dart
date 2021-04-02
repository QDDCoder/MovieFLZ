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

  //列表展示的形式
  final displayType = 0.obs;

  //排期的类型
  List<Map> chedule_seanson = [
    {'num': 1, 'name': '综合', 'isSelect': 1, 'type': ''},
    {'num': 2, 'name': '美剧', 'isSelect': 0, 'type': '美剧'},
    {'num': 3, 'name': '日剧', 'isSelect': 0, 'type': '日剧'},
    {'num': 4, 'name': '韩剧', 'isSelect': 0, 'type': '韩剧'},
    {'num': 5, 'name': '泰剧', 'isSelect': 0, 'type': '泰剧'},
  ];

  //排期的日期数据
  List<Map> chedule_days = [
    {
      'num': 1,
      'month': DateTime(DateTime.now().year, DateTime.now().month, 0).month,
      'year': DateTime(DateTime.now().year, DateTime.now().month, 0).year,
      'isSelect': 0
    },
    {
      'num': 2,
      'month': DateTime(DateTime.now().year, DateTime.now().month + 1, 0).month,
      'year': DateTime(DateTime.now().year, DateTime.now().month, 0).year,
      'isSelect': 1
    },
    {
      'num': 3,
      'month': DateTime(DateTime.now().year, DateTime.now().month + 2, 0).month,
      'year': DateTime(DateTime.now().year, DateTime.now().month, 0).year,
      'isSelect': 0
    },
  ];

  //排期的类型tittle
  final top_chedule_title = '综合'.obs;

  //当前的月份
  final current_month = DateTime.now().month.obs;

  //修改当前的月份
  changeCurrentMonth(num) {
    //更新月份
    chedule_days.forEach((element) {
      element['isSelect'] = 0;
      if (element['num'] == num) {
        element['isSelect'] = 1;
        current_month.value = element['month'];
      }
    });

    //更新天数
    var days = LZDateUtils.currentMonthWeekDays(
        chedule_days[num - 1]['year'], chedule_days[num - 1]['month']);
    dayInfos.update((val) {
      val.days = days;
      if (chedule_days[num - 1]['month'] == DateTime.now().month) {
        val.days[DateTime.now().day - 1]['select'] = 1;
      } else {
        val.days[0]['select'] = 1;
      }
    });
  }

  //更新列表的展示形式
  Future<void> changeDisplayType() async {
    displayType.value = (displayType.value == 0) ? 1 : 0;
  }

  //修改顶部的排行榜排序方式
  update_top_season_list_select(num) {
    chedule_seanson.forEach((element) {
      //先置为0
      element['isSelect'] = 0;
      if (element['num'] == num) {
        element['isSelect'] = 1;
        top_chedule_title.value = element['name'];
      }
    });
  }

  //获取日期的数据model
  Future<void> getDays(year, month) async {
    var days = LZDateUtils.currentMonthWeekDays(year, month);
    dayInfos.update((val) {
      val.days = days;
      val.days[DateTime.now().day - 1]['select'] = 1;
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
