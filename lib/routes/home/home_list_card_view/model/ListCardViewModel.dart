/*
# @Time : 3/30/21 9:23 AM 
# @Author : 湛
# @File : ListCardViewModel.py
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
class ListCardViewModel {
  List<SectionContentModel> itemList = List<SectionContentModel>();
  ListCardViewModel();
  ListCardViewModel.fromJson({Map<String, dynamic> json}) {
    if (json['data'] != null) {
      json['data'].forEach((v) {
        itemList.add(SectionContentModel.fromJson(v));
      });
    }
  }
}

class SectionContentModel {
  int id;
  String title;
  String subTitle;
  bool enable;
  String color;
  int relevanceCount;
  List<Content> content;

  SectionContentModel(
      {this.id,
      this.title,
      this.subTitle,
      this.enable,
      this.color,
      this.relevanceCount,
      this.content});

  SectionContentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subTitle = json['subTitle'];
    enable = json['enable'];
    color = json['color'];
    relevanceCount = json['relevanceCount'];
    if (json['content'] != null) {
      content = new List<Content>();
      json['content'].forEach((v) {
        content.add(new Content.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['subTitle'] = this.subTitle;
    data['enable'] = this.enable;
    data['color'] = this.color;
    data['relevanceCount'] = this.relevanceCount;
    if (this.content != null) {
      data['content'] = this.content.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Content {
  int dramaId;
  String coverUrl;
  String title;
  String dramaType;
  String feeMode;

  Content(
      {this.dramaId, this.coverUrl, this.title, this.dramaType, this.feeMode});

  Content.fromJson(Map<String, dynamic> json) {
    dramaId = json['dramaId'];
    coverUrl = json['coverUrl'];
    title = json['title'];
    dramaType = json['dramaType'];
    feeMode = json['feeMode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dramaId'] = this.dramaId;
    data['coverUrl'] = this.coverUrl;
    data['title'] = this.title;
    data['dramaType'] = this.dramaType;
    data['feeMode'] = this.feeMode;
    return data;
  }
}
