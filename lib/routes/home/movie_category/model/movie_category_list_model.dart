/*
# @Time : 3/31/21 5:20 PM 
# @Author : 湛
# @File : movie_category_list_model.py
# @Desc : ==============================================
# 打工赚不了几个钱,但打工能让你没时间花钱。
#      ┌─┐       ┌─┐
#   ┌──┘ ┴───────┘ ┴──┐
#   │       ───       │
#   │  ─┬┘       └┬─  │
#   │       ─┴─       │
#   └───┐         ┌───┘
#       │         │
#       │         └──────────────┐
#       │                        ├─┐
#       │                        ┌─┘
#       └─┐  ┐  ┌───────┬──┐  ┌──┘
#         │ ─┤ ─┤       │ ─┤ ─┤
#         └──┴──┘       └──┴──┘
#                神兽保佑
#               代码无BUG!
# ======================================================
*/
import 'package:movie_flz/routes/home/home_movie/Model/HomeMovieModel.dart';

class MovieCategoryListModle {
  List<SectionContents> data = List<SectionContents>();

  MovieCategoryListModle();

  MovieCategoryListModle.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<SectionContents>();
      json['data'].forEach((v) {
        data.add(new SectionContents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
