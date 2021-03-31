class HomeMoveModel {
  List<BannerTop> bannerTop = List<BannerTop>();
  GuessFavorite guessFavorite;
  bool isEnd;
  Bean bean;
  List<Sections> sections = List<Sections>();

  HomeMoveModel();

  HomeMoveModel.fromJson(Map<String, dynamic> json) {
    if (json['bannerTop'] != null) {
      bannerTop = new List<BannerTop>();
      json['bannerTop'].forEach((v) {
        bannerTop.add(new BannerTop.fromJson(v));
      });
    }
    guessFavorite = json['guessFavorite'] != null
        ? new GuessFavorite.fromJson(json['guessFavorite'])
        : null;
    isEnd = json['isEnd'];
    bean = json['bean'] != null ? new Bean.fromJson(json['bean']) : null;
    if (json['sections'] != null) {
      sections = new List<Sections>();
      json['sections'].forEach((v) {
        sections.add(new Sections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bannerTop != null) {
      data['bannerTop'] = this.bannerTop.map((v) => v.toJson()).toList();
    }
    if (this.guessFavorite != null) {
      data['guessFavorite'] = this.guessFavorite.toJson();
    }
    data['isEnd'] = this.isEnd;
    if (this.bean != null) {
      data['bean'] = this.bean.toJson();
    }
    if (this.sections != null) {
      data['sections'] = this.sections.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerTop {
  int id;
  String name;
  String title;
  String imgUrl;
  String targetUrl;
  String type;
  int sequence;
  String redirectUrl;

  BannerTop(
      {this.id,
      this.name,
      this.title,
      this.imgUrl,
      this.targetUrl,
      this.type,
      this.sequence,
      this.redirectUrl});

  BannerTop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    imgUrl = json['imgUrl'];
    targetUrl = json['targetUrl'];
    type = json['type'];
    sequence = json['sequence'];
    redirectUrl = json['redirectUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['title'] = this.title;
    data['imgUrl'] = this.imgUrl;
    data['targetUrl'] = this.targetUrl;
    data['type'] = this.type;
    data['sequence'] = this.sequence;
    data['redirectUrl'] = this.redirectUrl;
    return data;
  }
}

class GuessFavorite {
  int id;
  String display;
  String moreText;
  String name;
  int position;
  Null sectionType;
  int sequence;
  String targetId;
  String targetType;
  String displayTitle;
  List<SectionContents> sectionContents;

  GuessFavorite(
      {this.id,
      this.display,
      this.moreText,
      this.name,
      this.position,
      this.sectionType,
      this.sequence,
      this.targetId,
      this.targetType,
      this.displayTitle,
      this.sectionContents});

  GuessFavorite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    display = json['display'];
    moreText = json['moreText'];
    name = json['name'];
    position = json['position'];
    sectionType = json['sectionType'];
    sequence = json['sequence'];
    targetId = json['targetId'];
    targetType = json['targetType'];
    displayTitle = json['displayTitle'];
    if (json['sectionContents'] != null) {
      sectionContents = new List<SectionContents>();
      json['sectionContents'].forEach((v) {
        sectionContents.add(new SectionContents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['display'] = this.display;
    data['moreText'] = this.moreText;
    data['name'] = this.name;
    data['position'] = this.position;
    data['sectionType'] = this.sectionType;
    data['sequence'] = this.sequence;
    data['targetId'] = this.targetId;
    data['targetType'] = this.targetType;
    data['displayTitle'] = this.displayTitle;
    if (this.sectionContents != null) {
      data['sectionContents'] =
          this.sectionContents.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bean {
  int id;
  String display;
  String moreText;
  String name;
  int position;
  String sectionType;
  int sequence;
  String targetId;
  String targetType;
  String displayTitle;
  List<SectionContents> sectionContents;

  Bean(
      {this.id,
      this.display,
      this.moreText,
      this.name,
      this.position,
      this.sectionType,
      this.sequence,
      this.targetId,
      this.targetType,
      this.displayTitle,
      this.sectionContents});

  Bean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    display = json['display'];
    moreText = json['moreText'];
    name = json['name'];
    position = json['position'];
    sectionType = json['sectionType'];
    sequence = json['sequence'];
    targetId = json['targetId'];
    targetType = json['targetType'];
    displayTitle = json['displayTitle'];
    if (json['sectionContents'] != null) {
      sectionContents = new List<SectionContents>();
      json['sectionContents'].forEach((v) {
        sectionContents.add(new SectionContents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['display'] = this.display;
    data['moreText'] = this.moreText;
    data['name'] = this.name;
    data['position'] = this.position;
    data['sectionType'] = this.sectionType;
    data['sequence'] = this.sequence;
    data['targetId'] = this.targetId;
    data['targetType'] = this.targetType;
    data['displayTitle'] = this.displayTitle;
    if (this.sectionContents != null) {
      data['sectionContents'] =
          this.sectionContents.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sections {
  int id;
  String display;
  String moreText;
  String name;
  int position;
  String sectionType;
  int sequence;
  String targetId;
  Null targetType;
  String displayTitle;
  List<SectionContents> sectionContents;

  Sections(
      {this.id,
      this.display,
      this.moreText,
      this.name,
      this.position,
      this.sectionType,
      this.sequence,
      this.targetId,
      this.targetType,
      this.displayTitle,
      this.sectionContents});

  Sections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    display = json['display'];
    moreText = json['moreText'];
    name = json['name'];
    position = json['position'];
    sectionType = json['sectionType'];
    sequence = json['sequence'];
    targetId = json['targetId'];
    targetType = json['targetType'];
    displayTitle = json['displayTitle'];
    if (json['sectionContents'] != null) {
      sectionContents = new List<SectionContents>();
      json['sectionContents'].forEach((v) {
        sectionContents.add(new SectionContents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['display'] = this.display;
    data['moreText'] = this.moreText;
    data['name'] = this.name;
    data['position'] = this.position;
    data['sectionType'] = this.sectionType;
    data['sequence'] = this.sequence;
    data['targetId'] = this.targetId;
    data['targetType'] = this.targetType;
    data['displayTitle'] = this.displayTitle;
    if (this.sectionContents != null) {
      data['sectionContents'] =
          this.sectionContents.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SectionContents {
  int dramaId;
  String title;
  String icon;
  String subTitle;
  String coverUrl;
  String dramaType;
  double score;
  String feeMode;
  bool favorite;
  int id;
  int positionId;
  Null categoryId;
  String positionName;
  String imageUrl;
  String imageWidth;
  String imageHeight;
  String targetUrl;
  String failUrl;
  String targetTypeNew;
  int sequence;
  int adId;
  String redirectUrl;
  String advid;
  String monitorUrl;
  String sdktype;
  Null pid;
  int orderNum;
  int seriesId;
  int sectionId;
  String targetId;
  int relevanceCount;
  String color;

  List<Series> series;

  SectionContents(
      {this.dramaId,
      this.title,
      this.subTitle,
      this.coverUrl,
      this.dramaType,
      this.score,
      this.feeMode,
      this.favorite,
      this.id,
      this.positionId,
      this.categoryId,
      this.positionName,
      this.imageUrl,
      this.imageWidth,
      this.imageHeight,
      this.targetUrl,
      this.failUrl,
      this.targetTypeNew,
      this.sequence,
      this.adId,
      this.redirectUrl,
      this.advid,
      this.monitorUrl,
      this.sdktype,
      this.pid,
      this.orderNum,
      this.seriesId,
      this.sectionId,
      this.targetId,
      this.relevanceCount,
      this.color,
      this.series,
      this.icon});

  SectionContents.fromJson(Map<String, dynamic> json) {
    dramaId = json['dramaId'];
    title = json['title'];
    icon = json['icon'];
    subTitle = json['subTitle'];
    coverUrl = json['coverUrl'];
    dramaType = json['dramaType'];
    score = double.parse('${json['score'] ?? 0.0}');
    feeMode = json['feeMode'];
    favorite = json['favorite'];
    id = json['id'];
    positionId = json['positionId'];
    categoryId = json['categoryId'];
    positionName = json['positionName'];
    imageUrl = json['imageUrl'];
    imageWidth = json['imageWidth'];
    imageHeight = json['imageHeight'];
    targetUrl = json['targetUrl'];
    failUrl = json['failUrl'];
    targetTypeNew = json['targetTypeNew'];
    sequence = json['sequence'];
    adId = json['adId'];
    redirectUrl = json['redirectUrl'];
    advid = json['advid'];
    monitorUrl = json['monitorUrl'];
    sdktype = json['sdktype'];
    pid = json['pid'];
    orderNum = json['orderNum'];
    seriesId = json['seriesId'];
    sectionId = json['sectionId'];
    targetId = json['targetId'];
    relevanceCount = json['relevanceCount'];
    color = json['color'];

    if (json['series'] != null) {
      series = new List<Series>();
      json['series'].forEach((v) {
        series.add(new Series.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dramaId'] = this.dramaId;
    data['title'] = this.title;
    data['icon'] = this.icon;
    data['subTitle'] = this.subTitle;
    data['coverUrl'] = this.coverUrl;
    data['dramaType'] = this.dramaType;
    data['score'] = this.score;
    data['feeMode'] = this.feeMode;
    data['favorite'] = this.favorite;
    data['id'] = this.id;
    data['positionId'] = this.positionId;
    data['categoryId'] = this.categoryId;
    data['positionName'] = this.positionName;
    data['imageUrl'] = this.imageUrl;
    data['imageWidth'] = this.imageWidth;
    data['imageHeight'] = this.imageHeight;
    data['targetUrl'] = this.targetUrl;
    data['failUrl'] = this.failUrl;
    data['targetTypeNew'] = this.targetTypeNew;
    data['sequence'] = this.sequence;
    data['adId'] = this.adId;
    data['redirectUrl'] = this.redirectUrl;
    data['advid'] = this.advid;
    data['monitorUrl'] = this.monitorUrl;
    data['sdktype'] = this.sdktype;
    data['pid'] = this.pid;
    data['orderNum'] = this.orderNum;
    data['seriesId'] = this.seriesId;
    data['sectionId'] = this.sectionId;
    data['targetId'] = this.targetId;
    data['relevanceCount'] = this.relevanceCount;
    data['color'] = this.color;

    if (this.series != null) {
      data['series'] = this.series.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Series {
  int dramaId;
  String title;
  String subTitle;
  String coverUrl;
  String dramaType;
  double score;
  String feeMode;
  Null favorite;

  Series(
      {this.dramaId,
      this.title,
      this.subTitle,
      this.coverUrl,
      this.dramaType,
      this.score,
      this.feeMode,
      this.favorite});

  Series.fromJson(Map<String, dynamic> json) {
    dramaId = json['dramaId'];
    title = json['title'];
    subTitle = json['subTitle'];
    coverUrl = json['coverUrl'];
    dramaType = json['dramaType'];
    score = json['score'];
    feeMode = json['feeMode'];
    favorite = json['favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dramaId'] = this.dramaId;
    data['title'] = this.title;
    data['subTitle'] = this.subTitle;
    data['coverUrl'] = this.coverUrl;
    data['dramaType'] = this.dramaType;
    data['score'] = this.score;
    data['feeMode'] = this.feeMode;
    data['favorite'] = this.favorite;
    return data;
  }
}
