class LookMovieModel {
  List<LookMovieItemModel> data = List<LookMovieItemModel>();

  LookMovieModel();

  LookMovieModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<LookMovieItemModel>();
      json['data'].forEach((v) {
        data.add(new LookMovieItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LookMovieItemModel {
  int id;
  String title;
  String brief;
  String playLink;
  int expiredTime;
  Author author;
  String cover;
  String verticalCover;
  int videoDuration;
  String vid;
  Null checkTitle;
  int createTime;
  int updateTime;
  String extraInfo;
  Season season;
  bool choice;
  int playCount;
  int commentCount;
  int likeCount;
  int collectCount;
  bool favorite;
  bool liked;
  String itemType;
  String recomTraceId;
  String recomTraceInfo;

  LookMovieItemModel(
      {this.id,
      this.title,
      this.brief,
      this.playLink,
      this.expiredTime,
      this.author,
      this.cover,
      this.verticalCover,
      this.videoDuration,
      this.vid,
      this.checkTitle,
      this.createTime,
      this.updateTime,
      this.extraInfo,
      this.season,
      this.choice,
      this.playCount,
      this.commentCount,
      this.likeCount,
      this.collectCount,
      this.favorite,
      this.liked,
      this.itemType,
      this.recomTraceId,
      this.recomTraceInfo});

  LookMovieItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    brief = json['brief'];
    playLink = json['playLink'];
    expiredTime = json['expiredTime'];
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    cover = json['cover'];
    verticalCover = json['verticalCover'];
    videoDuration = json['videoDuration'];
    vid = json['vid'];
    checkTitle = json['checkTitle'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    extraInfo = json['extraInfo'];
    season =
        json['season'] != null ? new Season.fromJson(json['season']) : null;
    choice = json['choice'];
    playCount = json['playCount'];
    commentCount = json['commentCount'];
    likeCount = json['likeCount'];
    collectCount = json['collectCount'];
    favorite = json['favorite'];
    liked = json['liked'];
    itemType = json['itemType'];
    recomTraceId = json['recomTraceId'];
    recomTraceInfo = json['recomTraceInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['brief'] = this.brief;
    data['playLink'] = this.playLink;
    data['expiredTime'] = this.expiredTime;
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    data['cover'] = this.cover;
    data['verticalCover'] = this.verticalCover;
    data['videoDuration'] = this.videoDuration;
    data['vid'] = this.vid;
    data['checkTitle'] = this.checkTitle;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['extraInfo'] = this.extraInfo;
    if (this.season != null) {
      data['season'] = this.season.toJson();
    }
    data['choice'] = this.choice;
    data['playCount'] = this.playCount;
    data['commentCount'] = this.commentCount;
    data['likeCount'] = this.likeCount;
    data['collectCount'] = this.collectCount;
    data['favorite'] = this.favorite;
    data['liked'] = this.liked;
    data['itemType'] = this.itemType;
    data['recomTraceId'] = this.recomTraceId;
    data['recomTraceInfo'] = this.recomTraceInfo;
    return data;
  }
}

class Author {
  int id;
  String headImgUrl;
  String nickName;
  bool focused;

  Author({this.id, this.headImgUrl, this.nickName, this.focused});

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    headImgUrl = json['headImgUrl'];
    nickName = json['nickName'];
    focused = json['focused'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['headImgUrl'] = this.headImgUrl;
    data['nickName'] = this.nickName;
    data['focused'] = this.focused;
    return data;
  }
}

class Season {
  int id;
  String seasonName;
  String cover;
  double score;
  int authorScore;
  String area;
  String category;
  bool collected;
  String intro;
  String subTitle;
  String title;
  String year;
  bool movie;

  Season(
      {this.id,
      this.seasonName,
      this.cover,
      this.score,
      this.authorScore,
      this.area,
      this.category,
      this.collected,
      this.intro,
      this.subTitle,
      this.title,
      this.year,
      this.movie});

  Season.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    seasonName = json['seasonName'];
    cover = json['cover'];
    score = json['score'];
    authorScore = json['authorScore'];
    area = json['area'];
    category = json['category'];
    collected = json['collected'];
    intro = json['intro'];
    subTitle = json['subTitle'];
    title = json['title'];
    year = json['year'];
    movie = json['movie'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seasonName'] = this.seasonName;
    data['cover'] = this.cover;
    data['score'] = this.score;
    data['authorScore'] = this.authorScore;
    data['area'] = this.area;
    data['category'] = this.category;
    data['collected'] = this.collected;
    data['intro'] = this.intro;
    data['subTitle'] = this.subTitle;
    data['title'] = this.title;
    data['year'] = this.year;
    data['movie'] = this.movie;
    return data;
  }
}
