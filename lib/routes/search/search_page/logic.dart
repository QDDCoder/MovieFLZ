import 'dart:convert' as convert;

import 'package:get/get.dart';
import 'package:movie_flz/config/Global.dart';
import 'package:movie_flz/config/NetTools.dart';
import 'package:movie_flz/tools/LZStorageUtils.dart';

import 'model/MainSearchModel.dart';
import 'model/SearchKKModel.dart';

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
    } else {
      historyList[historyListkey] = null;
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

  /**
   * 清理搜索历史
   */
  Future<void> clearAllHistory() async {
    LZStorageUtils.saveModel('historyList', null);
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

      //处理数据Label
      tempModle.data.forEach((element) {
        element.searchRecommendDtos.forEach((elementIn) {
          if (elementIn.label == 'hot') {
            elementIn.label = '热';
          } else if (elementIn.label == 'new') {
            elementIn.label = '新';
          } else if (elementIn.label == 'recommend') {
            elementIn.label = '荐';
          }
        });
      });
      //更新数据
      val.data.addAll(tempModle.data);
    });
  }

  //输入搜索的关键字
  final recommandKey = ''.obs;
  updateRecommandKey({key}) {
    recommandKey.value = key;
    getRecommandKeyWordModel(key: key);
  }

  //底部的推荐的关键字
  final recommandKeyModel = SearchKKModel().obs;
  Future<void> getRecommandKeyWordModel({key}) async {
    //https://api.rr.tv/search/lenovo?keywords=%E6%88%91%E4%BB%AC
    var r = await NetTools.dio.get<String>(
      "search/lenovo?keywords=${key}",
    );

    var tempModle = SearchKKModel.fromJson(convert.jsonDecode(r.data));
    recommandKeyModel.update((val) {
      val.data = tempModle.data;
    });
  }
}
