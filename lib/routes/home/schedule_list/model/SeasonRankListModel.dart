/*
# @Time : 4/1/21 5:08 PM 
# @Author : 湛
# @File : SeasonRankListModel.py
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
class ScheduleListModel {
  List<ScheduleListItemModel> scheduleList = List<ScheduleListItemModel>();

  ScheduleListModel();

  ScheduleListModel.fromJson(Map<String, dynamic> json) {
    if (json['scheduleList'] != null) {
      scheduleList = new List<ScheduleListItemModel>();
      json['scheduleList'].forEach((v) {
        scheduleList.add(new ScheduleListItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.scheduleList != null) {
      data['scheduleList'] = this.scheduleList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ScheduleListItemModel {
  Null seriesId;
  String type;
  int seasonId;
  String seriesName;
  String coverUrl;
  bool isStop;
  bool isFollow;
  String episode;
  String shortBrief;
  String verticalUrl;
  int updated;
  double score;
  String year;
  String cat;
  String area;
  int upInfo;
  int status;
  String title;
  String seasonCoverUrl;
  String feeMode;

  ScheduleListItemModel(
      {this.seriesId,
      this.type,
      this.seasonId,
      this.seriesName,
      this.coverUrl,
      this.isStop,
      this.isFollow,
      this.episode,
      this.shortBrief,
      this.verticalUrl,
      this.updated,
      this.score,
      this.year,
      this.cat,
      this.area,
      this.upInfo,
      this.status,
      this.title,
      this.seasonCoverUrl,
      this.feeMode});

  ScheduleListItemModel.fromJson(Map<String, dynamic> json) {
    seriesId = json['seriesId'];
    type = json['type'];
    seasonId = json['seasonId'];
    seriesName = json['seriesName'];
    coverUrl = json['coverUrl'];
    isStop = json['isStop'];
    isFollow = json['isFollow'];
    episode = json['episode'];
    shortBrief = json['shortBrief'];
    verticalUrl = json['verticalUrl'];
    updated = json['updated'];
    score = json['score'];
    year = json['year'];
    cat = json['cat'];
    area = json['area'];
    upInfo = json['upInfo'];
    status = json['status'];
    title = json['title'];
    seasonCoverUrl = json['seasonCoverUrl'];
    feeMode = json['feeMode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seriesId'] = this.seriesId;
    data['type'] = this.type;
    data['seasonId'] = this.seasonId;
    data['seriesName'] = this.seriesName;
    data['coverUrl'] = this.coverUrl;
    data['isStop'] = this.isStop;
    data['isFollow'] = this.isFollow;
    data['episode'] = this.episode;
    data['shortBrief'] = this.shortBrief;
    data['verticalUrl'] = this.verticalUrl;
    data['updated'] = this.updated;
    data['score'] = this.score;
    data['year'] = this.year;
    data['cat'] = this.cat;
    data['area'] = this.area;
    data['upInfo'] = this.upInfo;
    data['status'] = this.status;
    data['title'] = this.title;
    data['seasonCoverUrl'] = this.seasonCoverUrl;
    data['feeMode'] = this.feeMode;
    return data;
  }
}
