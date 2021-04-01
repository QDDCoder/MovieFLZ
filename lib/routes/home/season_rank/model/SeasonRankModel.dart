/*
# @Time : 4/1/21 11:44 AM 
# @Author : 湛
# @File : SeasonRankModel.py
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
class SeasonRankTopTapModel {
  List<FilmTelevsionList> filmTelevsionList = List<FilmTelevsionList>();

  SeasonRankTopTapModel();

  SeasonRankTopTapModel.fromJson(Map<String, dynamic> json) {
    if (json['filmTelevsionList'] != null) {
      filmTelevsionList = new List<FilmTelevsionList>();
      json['filmTelevsionList'].forEach((v) {
        filmTelevsionList.add(new FilmTelevsionList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.filmTelevsionList != null) {
      data['filmTelevsionList'] =
          this.filmTelevsionList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FilmTelevsionList {
  String imgUrl;
  int createTime;
  String name;
  int updateTime;
  int id;
  String content;
  String enabled;
  String key;
  int seq;

  FilmTelevsionList(
      {this.imgUrl,
      this.createTime,
      this.name,
      this.updateTime,
      this.id,
      this.content,
      this.enabled,
      this.key,
      this.seq});

  FilmTelevsionList.fromJson(Map<String, dynamic> json) {
    imgUrl = json['imgUrl'];
    createTime = json['createTime'];
    name = json['name'];
    updateTime = json['updateTime'];
    id = json['id'];
    content = json['content'];
    enabled = json['enabled'];
    key = json['key'];
    seq = json['seq'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imgUrl'] = this.imgUrl;
    data['createTime'] = this.createTime;
    data['name'] = this.name;
    data['updateTime'] = this.updateTime;
    data['id'] = this.id;
    data['content'] = this.content;
    data['enabled'] = this.enabled;
    data['key'] = this.key;
    data['seq'] = this.seq;
    return data;
  }
}
