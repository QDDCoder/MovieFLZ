class ShortMovieDetailModel {
  List<ShortMovieRecommendVideoList> recommendVideoList =
      List<ShortMovieRecommendVideoList>();
  ShortMovieVideoDetailView videoDetailView;

  ShortMovieDetailModel();

  ShortMovieDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['recommendVideoList'] != null) {
      recommendVideoList = new List<ShortMovieRecommendVideoList>();
      json['recommendVideoList'].forEach((v) {
        recommendVideoList.add(new ShortMovieRecommendVideoList.fromJson(v));
      });
    }
    videoDetailView = json['videoDetailView'] != null
        ? new ShortMovieVideoDetailView.fromJson(json['videoDetailView'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recommendVideoList != null) {
      data['recommendVideoList'] =
          this.recommendVideoList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShortMovieRecommendVideoList {
  int id;
  String title;
  String cover;
  String duration;
  String brief;
  ShortMovieAuthor author;
  int viewCount;
  int danmuCount;
  int commentCount;
  String approvedTime;
  List<ShortMovieVideoFileView> videoFileView;
  int favCount;
  String requestId;
  bool favorite;
  Null durationBySec;
  String playLink;
  int createtime;
  int categoryId;
  Null categoryName;
  int leafCategoryId;
  Null leafCategoryName;
  Null createtimeStr;
  int playCount;
  List<ShortMovieTagViewList> tagViewList;
  Null categoryViewList;

  ShortMovieRecommendVideoList(
      {this.id,
      this.title,
      this.cover,
      this.duration,
      this.brief,
      this.author,
      this.viewCount,
      this.danmuCount,
      this.commentCount,
      this.approvedTime,
      this.videoFileView,
      this.favCount,
      this.requestId,
      this.favorite,
      this.durationBySec,
      this.playLink,
      this.createtime,
      this.categoryId,
      this.categoryName,
      this.leafCategoryId,
      this.leafCategoryName,
      this.createtimeStr,
      this.playCount,
      this.tagViewList,
      this.categoryViewList});

  ShortMovieRecommendVideoList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    cover = json['cover'];
    duration = json['duration'];
    brief = json['brief'];
    author = json['author'] != null
        ? new ShortMovieAuthor.fromJson(json['author'])
        : null;
    viewCount = json['viewCount'];
    danmuCount = json['danmuCount'];
    commentCount = json['commentCount'];
    approvedTime = json['approvedTime'];
    if (json['videoFileView'] != null) {
      videoFileView = new List<ShortMovieVideoFileView>();
      json['videoFileView'].forEach((v) {
        videoFileView.add(new ShortMovieVideoFileView.fromJson(v));
      });
    }
    favCount = json['favCount'];
    requestId = json['requestId'];
    favorite = json['favorite'];
    durationBySec = json['durationBySec'];
    playLink = json['playLink'];
    createtime = json['createtime'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    leafCategoryId = json['leafCategoryId'];
    leafCategoryName = json['leafCategoryName'];
    createtimeStr = json['createtimeStr'];
    playCount = json['playCount'];
    if (json['tagViewList'] != null) {
      tagViewList = new List<ShortMovieTagViewList>();
      json['tagViewList'].forEach((v) {
        tagViewList.add(new ShortMovieTagViewList.fromJson(v));
      });
    }
    categoryViewList = json['categoryViewList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['cover'] = this.cover;
    data['duration'] = this.duration;
    data['brief'] = this.brief;
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    data['viewCount'] = this.viewCount;
    data['danmuCount'] = this.danmuCount;
    data['commentCount'] = this.commentCount;
    data['approvedTime'] = this.approvedTime;
    if (this.videoFileView != null) {
      data['videoFileView'] =
          this.videoFileView.map((v) => v.toJson()).toList();
    }
    data['favCount'] = this.favCount;
    data['requestId'] = this.requestId;
    data['favorite'] = this.favorite;
    data['durationBySec'] = this.durationBySec;
    data['playLink'] = this.playLink;
    data['createtime'] = this.createtime;
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['leafCategoryId'] = this.leafCategoryId;
    data['leafCategoryName'] = this.leafCategoryName;
    data['createtimeStr'] = this.createtimeStr;
    data['playCount'] = this.playCount;
    if (this.tagViewList != null) {
      data['tagViewList'] = this.tagViewList.map((v) => v.toJson()).toList();
    }
    data['categoryViewList'] = this.categoryViewList;
    return data;
  }
}

class ShortMovieAuthor {
  int id;
  String nickName;
  String headImgUrl;
  String level;
  int score;
  String roleInfo;
  String sign;
  String intro;
  Null addGrowth;
  int videoCount;
  int seasonCount;
  bool focused;
  String certLabel;
  String certNote;

  ShortMovieAuthor(
      {this.id,
      this.nickName,
      this.headImgUrl,
      this.level,
      this.score,
      this.roleInfo,
      this.sign,
      this.intro,
      this.addGrowth,
      this.videoCount,
      this.seasonCount,
      this.focused,
      this.certLabel,
      this.certNote});

  ShortMovieAuthor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nickName = json['nickName'];
    headImgUrl = json['headImgUrl'];
    level = json['level'];
    score = json['score'];
    roleInfo = json['roleInfo'];
    sign = json['sign'];
    intro = json['intro'];
    addGrowth = json['addGrowth'];
    videoCount = json['videoCount'];
    seasonCount = json['seasonCount'];
    focused = json['focused'];
    certLabel = json['certLabel'];
    certNote = json['certNote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nickName'] = this.nickName;
    data['headImgUrl'] = this.headImgUrl;
    data['level'] = this.level;
    data['score'] = this.score;
    data['roleInfo'] = this.roleInfo;
    data['sign'] = this.sign;
    data['intro'] = this.intro;
    data['addGrowth'] = this.addGrowth;
    data['videoCount'] = this.videoCount;
    data['seasonCount'] = this.seasonCount;
    data['focused'] = this.focused;
    data['certLabel'] = this.certLabel;
    data['certNote'] = this.certNote;
    return data;
  }
}

class ShortMovieVideoFileView {
  String playQuality;
  int fileSize;

  ShortMovieVideoFileView({this.playQuality, this.fileSize});

  ShortMovieVideoFileView.fromJson(Map<String, dynamic> json) {
    playQuality = json['playQuality'];
    fileSize = json['fileSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['playQuality'] = this.playQuality;
    data['fileSize'] = this.fileSize;
    return data;
  }
}

class ShortMovieTagViewList {
  int id;
  String name;
  int times;
  Null type;

  ShortMovieTagViewList({this.id, this.name, this.times, this.type});

  ShortMovieTagViewList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    times = json['times'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['times'] = this.times;
    data['type'] = this.type;
    return data;
  }
}

class ShortMovieVideoDetailView {
  int id;
  String title;
  String brief;
  String playLink;
  int viewCount;
  int commentCount;
  String cover;
  List<ShortMovieVideoDetailViewTagList> tagList;
  int watchLevel;
  String duration;
  int rawDuration;
  int rewardCount;
  bool isFavorite;
  String type;
  String videoStatusType;
  List<ShortMovieVideoFileView> videoFileView;
  int favCount;
  Null copyrightText;
  bool selfSource;
  bool commentRestricted;
  ShortMovieAuthor author;

  ShortMovieVideoDetailView(
      {this.id,
      this.title,
      this.brief,
      this.playLink,
      this.viewCount,
      this.commentCount,
      this.cover,
      this.tagList,
      this.watchLevel,
      this.duration,
      this.rawDuration,
      this.rewardCount,
      this.isFavorite,
      this.type,
      this.videoStatusType,
      this.videoFileView,
      this.favCount,
      this.copyrightText,
      this.selfSource,
      this.commentRestricted,
      this.author});

  ShortMovieVideoDetailView.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    brief = json['brief'];
    playLink = json['playLink'];
    viewCount = json['viewCount'];
    commentCount = json['commentCount'];
    cover = json['cover'];
    if (json['tagList'] != null) {
      tagList = new List<ShortMovieVideoDetailViewTagList>();
      json['tagList'].forEach((v) {
        tagList.add(new ShortMovieVideoDetailViewTagList.fromJson(v));
      });
    }
    watchLevel = json['watchLevel'];
    duration = json['duration'];
    rawDuration = json['rawDuration'];
    rewardCount = json['rewardCount'];
    isFavorite = json['isFavorite'];
    type = json['type'];
    videoStatusType = json['videoStatusType'];
    if (json['videoFileView'] != null) {
      videoFileView = new List<ShortMovieVideoFileView>();
      json['videoFileView'].forEach((v) {
        videoFileView.add(new ShortMovieVideoFileView.fromJson(v));
      });
    }
    favCount = json['favCount'];
    copyrightText = json['copyrightText'];
    selfSource = json['selfSource'];
    commentRestricted = json['commentRestricted'];
    author = json['author'] != null
        ? new ShortMovieAuthor.fromJson(json['author'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['brief'] = this.brief;
    data['playLink'] = this.playLink;
    data['viewCount'] = this.viewCount;
    data['commentCount'] = this.commentCount;
    data['cover'] = this.cover;
    if (this.tagList != null) {
      data['tagList'] = this.tagList.map((v) => v.toJson()).toList();
    }
    data['watchLevel'] = this.watchLevel;
    data['duration'] = this.duration;
    data['rawDuration'] = this.rawDuration;
    data['rewardCount'] = this.rewardCount;
    data['isFavorite'] = this.isFavorite;
    data['type'] = this.type;
    data['videoStatusType'] = this.videoStatusType;
    if (this.videoFileView != null) {
      data['videoFileView'] =
          this.videoFileView.map((v) => v.toJson()).toList();
    }
    data['favCount'] = this.favCount;
    data['copyrightText'] = this.copyrightText;
    data['selfSource'] = this.selfSource;
    data['commentRestricted'] = this.commentRestricted;
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    return data;
  }
}

class ShortMovieVideoDetailViewTagList {
  int id;
  String name;
  int times;
  String type;

  ShortMovieVideoDetailViewTagList({this.id, this.name, this.times, this.type});

  ShortMovieVideoDetailViewTagList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    times = json['times'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['times'] = this.times;
    data['type'] = this.type;
    return data;
  }
}
