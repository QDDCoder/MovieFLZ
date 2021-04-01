/*
# @Time : 4/1/21 12:36 PM 
# @Author : 湛
# @File : SeasonRankListMovieModel.py
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
class SeasonRankListMovieModel {
  int total = 0;
  int currentPage = 1;
  List<SeasonRankListMovieItemModel> results =
      List<SeasonRankListMovieItemModel>();
  bool isEnd = false;

  SeasonRankListMovieModel();

  SeasonRankListMovieModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    currentPage = json['currentPage'];
    if (json['results'] != null) {
      results = new List<SeasonRankListMovieItemModel>();
      json['results'].forEach((v) {
        results.add(new SeasonRankListMovieItemModel.fromJson(v));
      });
    }
    isEnd = json['isEnd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['currentPage'] = this.currentPage;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    data['isEnd'] = this.isEnd;
    return data;
  }
}

class SeasonRankListMovieItemModel {
  int id;
  String title;
  String cover;
  String upInfo;
  String brief;
  String shortBrief;
  int expiredTime;
  int cornerMarkId;
  String year;
  String cat;
  String area;
  double score;
  bool finish;
  String status;
  int watchLevel;
  int viewCount;
  Null limitType;
  int searchStatus;
  Null cover3;
  String feeMode;
  Null isMovie;
  bool favorite;
  String actor;
  String dramaType;

  SeasonRankListMovieItemModel(
      {this.id,
      this.title,
      this.cover,
      this.upInfo,
      this.brief,
      this.shortBrief,
      this.expiredTime,
      this.cornerMarkId,
      this.year,
      this.cat,
      this.area,
      this.score,
      this.finish,
      this.status,
      this.watchLevel,
      this.viewCount,
      this.limitType,
      this.searchStatus,
      this.cover3,
      this.feeMode,
      this.isMovie,
      this.favorite,
      this.actor,
      this.dramaType});

  SeasonRankListMovieItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    cover = json['cover'];
    upInfo = json['upInfo'];
    brief = json['brief'];
    shortBrief = json['shortBrief'];
    expiredTime = json['expiredTime'];
    cornerMarkId = json['cornerMarkId'];
    year = json['year'];
    cat = json['cat'];
    area = json['area'];
    score = json['score'];
    finish = json['finish'];
    status = json['status'];
    watchLevel = json['watchLevel'];
    viewCount = json['viewCount'];
    limitType = json['limitType'];
    searchStatus = json['searchStatus'];
    cover3 = json['cover3'];
    feeMode = json['feeMode'];
    isMovie = json['isMovie'];
    favorite = json['favorite'];
    actor = json['actor'];
    dramaType = json['dramaType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['cover'] = this.cover;
    data['upInfo'] = this.upInfo;
    data['brief'] = this.brief;
    data['shortBrief'] = this.shortBrief;
    data['expiredTime'] = this.expiredTime;
    data['cornerMarkId'] = this.cornerMarkId;
    data['year'] = this.year;
    data['cat'] = this.cat;
    data['area'] = this.area;
    data['score'] = this.score;
    data['finish'] = this.finish;
    data['status'] = this.status;
    data['watchLevel'] = this.watchLevel;
    data['viewCount'] = this.viewCount;
    data['limitType'] = this.limitType;
    data['searchStatus'] = this.searchStatus;
    data['cover3'] = this.cover3;
    data['feeMode'] = this.feeMode;
    data['isMovie'] = this.isMovie;
    data['favorite'] = this.favorite;
    data['actor'] = this.actor;
    data['dramaType'] = this.dramaType;
    return data;
  }
}
