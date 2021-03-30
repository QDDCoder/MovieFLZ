/*
# @Time : 3/30/21 1:08 PM 
# @Author : 湛
# @File : MoreMoviesListTopTapModel.py
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
 * 顶部的信息状态
 */
class MoreMoviesListTopTapModel {
  String title = '';
  String subTitle = '';
  List<TabModel> tab = List<TabModel>();

  MoreMoviesListTopTapModel();

  MoreMoviesListTopTapModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subTitle = json['subTitle'];
    if (json['tab'] != null) {
      tab = new List<TabModel>();
      json['tab'].forEach((v) {
        tab.add(new TabModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subTitle'] = this.subTitle;
    if (this.tab != null) {
      data['tab'] = this.tab.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TabModel {
  int id;
  String name;
  String color;
  int relevanceCount;

  TabModel({this.id, this.name, this.color, this.relevanceCount});

  TabModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    relevanceCount = json['relevanceCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['color'] = this.color;
    data['relevanceCount'] = this.relevanceCount;
    return data;
  }
}
