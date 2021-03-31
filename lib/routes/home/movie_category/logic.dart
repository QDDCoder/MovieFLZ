import 'dart:convert' as convert;
import 'dart:ffi';

import 'package:get/get.dart';
import 'package:movie_flz/config/Global.dart';
import 'package:movie_flz/config/NetTools.dart';

import 'model/MovieCategoryTopModel.dart';
import 'model/movie_category_list_model.dart';

class MovieCategoryLogic extends GetxController {
  final topCategoryModel = MovieCategoryTopModle().obs;
  final movieCategoryListModel = MovieCategoryListModle().obs;

  int _page = 1;

  //获取顶部的分类数据
  Future<void> getCategoryTopModel({ageLimit = 0}) async {
    var r = await NetTools.dio.get<String>(
      "drama/app/get_drama_filter?ageLimit=${ageLimit}",
    );
    //缓存
    Global.netCache.cache.clear();

    topCategoryModel.update((val) {
      var tempModel =
          MovieCategoryTopModle.fromJson(convert.jsonDecode(r.data));
      tempModel.data.forEach((element) {
        element.dramaFilterItemList.first.isSelect = true;
      });

      val.data.addAll(tempModel.data);
      get_select_movies();
    });
  }

  //获取底部的列表数据
  Future<void> get_select_movies({refush = true}) async {
    Map<String, dynamic> map = Map();

    //sort
    topCategoryModel.value.data.forEach((element) {
      if (element.filterType == 'sort') {
        element.dramaFilterItemList.forEach((elementIn) {
          if (elementIn.isSelect) {
            map['sort'] = elementIn.value;
          }
        });
      }
      if (element.filterType == 'dramaType') {
        element.dramaFilterItemList.forEach((elementIn) {
          if (elementIn.isSelect) {
            map['dramaType'] = elementIn.value;
          }
        });
      }
      if (element.filterType == 'area') {
        element.dramaFilterItemList.forEach((elementIn) {
          if (elementIn.isSelect) {
            map['area'] = elementIn.value;
          }
        });
      }
      if (element.filterType == 'plotType') {
        element.dramaFilterItemList.forEach((elementIn) {
          if (elementIn.isSelect) {
            map['plotType'] = elementIn.value;
          }
        });
      }
      if (element.filterType == 'year') {
        element.dramaFilterItemList.forEach((elementIn) {
          if (elementIn.isSelect) {
            map['year'] = elementIn.value;
          }
        });
      }
      if (element.filterType == 'serializedStatus') {
        element.dramaFilterItemList.forEach((elementIn) {
          if (elementIn.isSelect) {
            map['serializedStatus'] = elementIn.value;
          }
        });
      }
      if (element.filterType == 'feeMode') {
        element.dramaFilterItemList.forEach((elementIn) {
          if (elementIn.isSelect) {
            map['feeMode'] = elementIn.value;
          }
        });
      }
    });

    _page = refush ? 1 : _page++;

    map['ageLimit'] = false;
    map['rows'] = 15;
    map['page'] = _page;
    var r = await NetTools.dio.post<String>(
      'drama/app/drama_filter_search',
      data: map,
    );
    //缓存
    Global.netCache.cache.clear();
    movieCategoryListModel.update((val) {
      var tempModel =
          MovieCategoryListModle.fromJson(convert.jsonDecode(r.data));
      if (refush) {
        val.data.clear();
      }
      val.data.addAll(tempModel.data);
    });
  }

  Future<Void> update_select_index(indexW, indexIn) async {
    topCategoryModel.update((value) {
      value.data[indexW].dramaFilterItemList.forEach((element) {
        element.isSelect = false;
      });
      value.data[indexW].dramaFilterItemList[indexIn].isSelect = true;
    });
    get_select_movies(refush: true);
  }
}
