/*
# @Time : 4/8/21 9:51 AM 
# @Author : 湛
# @File : SearchKKModel.py
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
class SearchKKModel {
  String msg;
  String code;
  SearchKKDataModel data = SearchKKDataModel();

  SearchKKModel();

  SearchKKModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = json['data'] != null
        ? new SearchKKDataModel.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class SearchKKDataModel {
  List<SearchTips> searchTips = List<SearchTips>();
  List<SeasonList> seasonList = List<SeasonList>();

  SearchKKDataModel();

  SearchKKDataModel.fromJson(Map<String, dynamic> json) {
    if (json['searchTips'] != null) {
      searchTips = new List<SearchTips>();
      json['searchTips'].forEach((v) {
        searchTips.add(new SearchTips.fromJson(v));
      });
    }
    if (json['seasonList'] != null) {
      seasonList = new List<SeasonList>();
      json['seasonList'].forEach((v) {
        seasonList.add(new SeasonList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.searchTips != null) {
      data['searchTips'] = this.searchTips.map((v) => v.toJson()).toList();
    }
    if (this.seasonList != null) {
      data['seasonList'] = this.seasonList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchTips {
  String title;

  SearchTips({this.title});

  SearchTips.fromJson(Map<String, dynamic> json) {
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    return data;
  }
}

class SeasonList {
  String id;
  String title;
  String cat;
  String classify;
  String cover;
  String area;
  String year;
  String score;
  String director;
  String actor;
  Null feeMode;
  String searchAfter;
  SearchTips highlights;

  SeasonList(
      {this.id,
      this.title,
      this.cat,
      this.classify,
      this.cover,
      this.area,
      this.year,
      this.score,
      this.director,
      this.actor,
      this.feeMode,
      this.searchAfter,
      this.highlights});

  SeasonList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    cat = json['cat'];
    classify = json['classify'];
    cover = json['cover'];
    area = json['area'];
    year = json['year'];
    score = json['score'];
    director = json['director'];
    actor = json['actor'];
    feeMode = json['feeMode'];
    searchAfter = json['search_after'];
    highlights = json['highlights'] != null
        ? new SearchTips.fromJson(json['highlights'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['cat'] = this.cat;
    data['classify'] = this.classify;
    data['cover'] = this.cover;
    data['area'] = this.area;
    data['year'] = this.year;
    data['score'] = this.score;
    data['director'] = this.director;
    data['actor'] = this.actor;
    data['feeMode'] = this.feeMode;
    data['search_after'] = this.searchAfter;
    if (this.highlights != null) {
      data['highlights'] = this.highlights.toJson();
    }
    return data;
  }
}
