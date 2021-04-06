/**
 * 首页短视频的model
 */
class ShortPageModel {
  List<ShortVideo> shortVideo = List<ShortVideo>();
  List<ShortPageBanner> banner = List<ShortPageBanner>();

  ShortPageModel();

  ShortPageModel.fromJson(Map<String, dynamic> json) {
    if (json['shortVideo'] != null) {
      shortVideo = new List<ShortVideo>();
      json['shortVideo'].forEach((v) {
        shortVideo.add(new ShortVideo.fromJson(v));
      });
    }
    if (json['banner'] != null) {
      banner = new List<ShortPageBanner>();
      json['banner'].forEach((v) {
        banner.add(new ShortPageBanner.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shortVideo != null) {
      data['shortVideo'] = this.shortVideo.map((v) => v.toJson()).toList();
    }
    if (this.banner != null) {
      data['banner'] = this.banner.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShortVideo {
  String contentType;
  ShortPageContent content;

  ShortVideo({this.contentType, this.content});

  ShortVideo.fromJson(Map<String, dynamic> json) {
    contentType = json['contentType'];
    content = json['content'] != null
        ? new ShortPageContent.fromJson(json['content'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contentType'] = this.contentType;
    if (this.content != null) {
      data['content'] = this.content.toJson();
    }
    return data;
  }
}

class ShortPageContent {
  int id;
  String cover;
  String title;
  String videoDurationStr;
  Null recomTraceId;
  Null recomTraceInfo;
  String srcType;
  int sequence;
  int createTime;

  ShortPageContent(
      {this.id,
      this.cover,
      this.title,
      this.videoDurationStr,
      this.recomTraceId,
      this.recomTraceInfo,
      this.srcType,
      this.sequence,
      this.createTime});

  ShortPageContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cover = json['cover'];
    title = json['title'];
    videoDurationStr = json['videoDurationStr'];
    recomTraceId = json['recomTraceId'];
    recomTraceInfo = json['recomTraceInfo'];
    srcType = json['srcType'];
    sequence = json['sequence'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cover'] = this.cover;
    data['title'] = this.title;
    data['videoDurationStr'] = this.videoDurationStr;
    data['recomTraceId'] = this.recomTraceId;
    data['recomTraceInfo'] = this.recomTraceInfo;
    data['srcType'] = this.srcType;
    data['sequence'] = this.sequence;
    data['createTime'] = this.createTime;
    return data;
  }
}

class ShortPageBanner {
  String cover;

  ShortPageBanner({this.cover});

  ShortPageBanner.fromJson(Map<String, dynamic> json) {
    cover = json['cover'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cover'] = this.cover;
    return data;
  }
}
