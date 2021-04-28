/*
# @Time : 4/28/21 3:02 PM 
# @Author : 湛
# @File : ShortWatchModel.py
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
class ShortWatchModel {
  M3u8 m3u8;

  ShortWatchModel();

  ShortWatchModel.fromJson(Map<String, dynamic> json) {
    m3u8 = json['m3u8'] != null ? new M3u8.fromJson(json['m3u8']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.m3u8 != null) {
      data['m3u8'] = this.m3u8.toJson();
    }
    return data;
  }
}

class M3u8 {
  Null urlId;
  String webUrl;
  Null parserStatus;
  String url;
  String currentQuality;
  List<String> qualityArr;
  String parserType;
  String source;
  bool selfSource;
  String size;
  String needreferer;
  String header;
  String duration;
  bool useDL;
  int cacheSize;
  int openingLength;
  bool externalAds;
  bool commentRestricted;
  String parseTime;
  int startingLength;

  M3u8(
      {this.urlId,
      this.webUrl,
      this.parserStatus,
      this.url,
      this.currentQuality,
      this.qualityArr,
      this.parserType,
      this.source,
      this.selfSource,
      this.size,
      this.needreferer,
      this.header,
      this.duration,
      this.useDL,
      this.cacheSize,
      this.openingLength,
      this.externalAds,
      this.commentRestricted,
      this.parseTime,
      this.startingLength});

  M3u8.fromJson(Map<String, dynamic> json) {
    urlId = json['urlId'];
    webUrl = json['webUrl'];
    parserStatus = json['parserStatus'];
    url = json['url'];
    currentQuality = json['currentQuality'];
    qualityArr = json['qualityArr'].cast<String>();
    parserType = json['parserType'];
    source = json['source'];
    selfSource = json['selfSource'];
    size = json['size'];
    needreferer = json['needreferer'];
    header = json['header'];
    duration = json['duration'];
    useDL = json['useDL'];
    cacheSize = json['cacheSize'];
    openingLength = json['openingLength'];
    externalAds = json['externalAds'];
    commentRestricted = json['commentRestricted'];
    parseTime = json['parseTime'];
    startingLength = json['startingLength'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['urlId'] = this.urlId;
    data['webUrl'] = this.webUrl;
    data['parserStatus'] = this.parserStatus;
    data['url'] = this.url;
    data['currentQuality'] = this.currentQuality;
    data['qualityArr'] = this.qualityArr;
    data['parserType'] = this.parserType;
    data['source'] = this.source;
    data['selfSource'] = this.selfSource;
    data['size'] = this.size;
    data['needreferer'] = this.needreferer;
    data['header'] = this.header;
    data['duration'] = this.duration;
    data['useDL'] = this.useDL;
    data['cacheSize'] = this.cacheSize;
    data['openingLength'] = this.openingLength;
    data['externalAds'] = this.externalAds;
    data['commentRestricted'] = this.commentRestricted;
    data['parseTime'] = this.parseTime;
    data['startingLength'] = this.startingLength;
    return data;
  }
}
