/*
# @Time : 3/31/21 3:02 PM 
# @Author : 湛
# @File : MovieCategoryTopModel.py
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

/**
 * 顶部的筛选model
 */
class MovieCategoryTopModle {
  List<MovieCategoryTopData> data = List<MovieCategoryTopData>();

  MovieCategoryTopModle();

  MovieCategoryTopModle.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<MovieCategoryTopData>();
      json['data'].forEach((v) {
        data.add(new MovieCategoryTopData.fromJson(v));
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

class MovieCategoryTopData {
  String filterType;
  List<DramaFilterItemList> dramaFilterItemList;

  MovieCategoryTopData({this.filterType, this.dramaFilterItemList});

  MovieCategoryTopData.fromJson(Map<String, dynamic> json) {
    filterType = json['filterType'];
    if (json['dramaFilterItemList'] != null) {
      dramaFilterItemList = new List<DramaFilterItemList>();
      json['dramaFilterItemList'].forEach((v) {
        dramaFilterItemList.add(new DramaFilterItemList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filterType'] = this.filterType;
    if (this.dramaFilterItemList != null) {
      data['dramaFilterItemList'] =
          this.dramaFilterItemList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DramaFilterItemList {
  String displayName;
  String value;
  bool isSelect = false;

  DramaFilterItemList({this.displayName, this.value});

  DramaFilterItemList.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayName'] = this.displayName;
    data['value'] = this.value;
    return data;
  }
}
