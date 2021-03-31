import 'dart:convert' as convert;

import 'package:get/get.dart';
import 'package:movie_flz/config/Global.dart';
import 'package:movie_flz/config/NetTools.dart';

import 'model/MovieCategoryTopModel.dart';
import 'model/movie_category_list_model.dart';

class MovieCategoryLogic extends GetxController {
  final topCategoryModel = MovieCategoryTopModle().obs;
  final movieCategoryListModel = MovieCategoryListModle().obs;
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
    });
  }

  //获取底部的列表数据
  Future<void> get_select_movies() async {
    Map<String, dynamic> map = Map();
    map['feeMode'] = '';
    map['area'] = '';
    map['sort'] = 'hot';
    map['ageLimit'] = false;
    map['rows'] = 15;
    map['year'] = '';
    map['dramaType'] = '';
    map['plotType'] = '';
    map['page'] = 1;
    map['serializedStatus'] = '';

    var r = await NetTools.dio.post<String>(
      'drama/app/drama_filter_search',
      data: map,
    );
    //缓存
    Global.netCache.cache.clear();
    movieCategoryListModel.update((val) {
      var tempModel =
          MovieCategoryListModle.fromJson(convert.jsonDecode(r.data));
      val.data.addAll(tempModel.data);
    });
  }

  update_select_index(indexW, indexIn) {
    // topCategoryModel.value.data[indexW].dramaFilterItemList.forEach((element) {
    //   element.isSelect = false;
    // });
    topCategoryModel.update((value) {
      value.data[indexW].dramaFilterItemList.forEach((element) {
        element.isSelect = false;
      });
      value.data[indexW].dramaFilterItemList[indexIn].isSelect = true;
    });
  }
}
