/*
# @Time : 4/7/21 5:24 PM 
# @Author : 湛
# @File : MainSearchModel.py
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
class MainSearchModel {
  String requestId = '';
  String code = '';
  String msg = '';
  List<MainSearchModelListData> data = List<MainSearchModelListData>();
  int recordsTotal = 0;

  MainSearchModel();

  MainSearchModel.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<MainSearchModelListData>();
      json['data'].forEach((v) {
        data.add(new MainSearchModelListData.fromJson(v));
      });
    }
    recordsTotal = json['recordsTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestId'] = this.requestId;
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['recordsTotal'] = this.recordsTotal;
    return data;
  }
}

class MainSearchModelListData {
  int id;
  String hotRecommend;
  String enabled;
  int orderNum;
  List<SearchRecommendDtos> searchRecommendDtos;

  MainSearchModelListData(
      {this.id,
      this.hotRecommend,
      this.enabled,
      this.orderNum,
      this.searchRecommendDtos});

  MainSearchModelListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hotRecommend = json['hotRecommend'];
    enabled = json['enabled'];
    orderNum = json['orderNum'];
    if (json['searchRecommendDtos'] != null) {
      searchRecommendDtos = new List<SearchRecommendDtos>();
      json['searchRecommendDtos'].forEach((v) {
        searchRecommendDtos.add(new SearchRecommendDtos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hotRecommend'] = this.hotRecommend;
    data['enabled'] = this.enabled;
    data['orderNum'] = this.orderNum;
    if (this.searchRecommendDtos != null) {
      data['searchRecommendDtos'] =
          this.searchRecommendDtos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchRecommendDtos {
  int id;
  String title;
  String subtitle;
  String label;
  int orderNum;
  String searchKeyword;
  int hotRecommendId;
  String createTime;
  String updateTime;

  SearchRecommendDtos(
      {this.id,
      this.title,
      this.subtitle,
      this.label,
      this.orderNum,
      this.searchKeyword,
      this.hotRecommendId,
      this.createTime,
      this.updateTime});

  SearchRecommendDtos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    label = json['label'];
    orderNum = json['orderNum'];
    searchKeyword = json['searchKeyword'];
    hotRecommendId = json['hotRecommendId'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['label'] = this.label;
    data['orderNum'] = this.orderNum;
    data['searchKeyword'] = this.searchKeyword;
    data['hotRecommendId'] = this.hotRecommendId;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    return data;
  }
}
