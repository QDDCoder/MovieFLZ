/*
# @Time : 3/29/21 10:59 AM 
# @Author : 湛
# @File : MoreMovieModel.py
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

import 'package:movie_flz/routes/home/gess_you_like/model/GessYouLikeModel.dart';

class MoreMovieModel {
  int id = 0;
  String title = '';
  String subTitle = '';
  String color = '';
  int relevanceCount = 0;
  List<GessYouLikeItmeModel> content = List<GessYouLikeItmeModel>();
  bool isEnd = false;
  int currentPage = 0;
  int total = 0;
  bool favorite = false;

  MoreMovieModel();

  MoreMovieModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subTitle = json['subTitle'];
    color = json['color'];
    relevanceCount = json['relevanceCount'];
    if (json['content'] != null) {
      content = new List<GessYouLikeItmeModel>();
      json['content'].forEach((v) {
        content.add(new GessYouLikeItmeModel.fromJson(v));
      });
    }
    isEnd = json['isEnd'];
    currentPage = json['currentPage'];
    total = json['total'];
    favorite = json['favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['subTitle'] = this.subTitle;
    data['color'] = this.color;
    data['relevanceCount'] = this.relevanceCount;
    if (this.content != null) {
      data['content'] = this.content.map((v) => v.toJson()).toList();
    }
    data['isEnd'] = this.isEnd;
    data['currentPage'] = this.currentPage;
    data['total'] = this.total;
    data['favorite'] = this.favorite;
    return data;
  }
}
