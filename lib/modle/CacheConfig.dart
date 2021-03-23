/*
# @Time : 3/22/21 11:21 AM 
# @Author : 湛
# @File : cacheConfig.py
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
class CacheConfig {
  bool enable;
  int maxAge;
  int maxCount;

  CacheConfig({this.enable, this.maxAge, this.maxCount});

  CacheConfig.fromJson(Map<String, dynamic> json) {
    enable = json['enable'];
    maxAge = json['maxAge'];
    maxCount = json['maxCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enable'] = this.enable;
    data['maxAge'] = this.maxAge;
    data['maxCount'] = this.maxCount;
    return data;
  }
}
