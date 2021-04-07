import 'dart:convert' as convert;

import 'package:get/get.dart';
import 'package:movie_flz/config/Global.dart';
import 'package:movie_flz/config/NetTools.dart';
import 'package:movie_flz/tools/LZStorageUtils.dart';

import 'model/MainSearchModel.dart';

class SearchPageLogic extends GetxController {
  final historyList = Map<String, dynamic>().obs;

  ///搜索的推荐内容
  final mainSearchModel = MainSearchModel().obs;

  //保存数据的外层Key
  final historyListkey = 'historyList';
  //保存数据的内层的Key
  final historyListInkey = 'hList';

  //获取搜索历史
  Future<void> getSearchList() async {
    var tempModel = await LZStorageUtils.getModelWithKey('historyList');
    if (tempModel != null) {
      historyList[historyListkey] = tempModel;
    }
  }

  //保存搜索历史
  Future<void> saveSearchList({String serachInfo}) async {
    var tempModel = await LZStorageUtils.getModelWithKey('historyList');
    if (tempModel == null) {
      Map<String, List> _tempModel = Map<String, List>();
      _tempModel[historyListInkey] = [serachInfo];
      LZStorageUtils.saveModel('historyList', _tempModel);
    } else {
      List<dynamic> temp = tempModel[historyListInkey];
      temp.add(serachInfo);
      tempModel[historyListInkey] = temp;
      await LZStorageUtils.saveModel('historyList', tempModel);
    }
    getSearchList();
  }

  //搜索页的推荐内容
  Future<void> getMainSearchModel() async {
    var r = await NetTools.dio.get<String>(
      "hot/recommend/list",
    );
    //缓存
    Global.netCache.cache.clear();
    //解析List数据 并反馈出去
    mainSearchModel.update((val) {
      var tempModle = MainSearchModel.fromJson(convert.jsonDecode(r.data));

      //遍历保存位置
      var tempIndexs = [];
      for (int i = 0; i < tempModle.data.length; i++) {
        if (tempModle.data[i].enabled == '0') {
          tempIndexs.add(i);
        }
      }

      //开始删除
      if (tempIndexs.length > 0) {
        tempIndexs.forEach((element) {
          tempModle.data.removeAt(element);
        });
      }
      //更新数据
      val.data.addAll(tempModle.data);
    });
  }
}
