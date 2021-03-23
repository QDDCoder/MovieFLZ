/*
# @Time : 3/22/21 11:19 AM 
# @Author : 湛
# @File : profile.py
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

import 'CacheConfig.dart';

class Profile {
  String token;
  int theme;
  CacheConfig cache;
  String lastLogin;
  String locale;

  Profile({this.token, this.theme, this.cache, this.lastLogin, this.locale});

  Profile.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    theme = json['theme'];
    cache = CacheConfig.fromJson(json['cache']);
    lastLogin = json['lastLogin'];
    locale = json['locale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['theme'] = this.theme;
    data['cache'] = this.cache.toJson();
    data['lastLogin'] = this.lastLogin;
    data['locale'] = this.locale;
    return data;
  }
}
