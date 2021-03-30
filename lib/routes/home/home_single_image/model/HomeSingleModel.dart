class HomeSingleModel {
  List<HomeSingleSections> sections = List<HomeSingleSections>();

  HomeSingleModel();

  HomeSingleModel.fromJson({Map<String, dynamic> json}) {
    if (json['sections'] != null) {
      sections = new List<HomeSingleSections>();
      json['sections'].forEach((v) {
        sections.add(new HomeSingleSections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sections != null) {
      data['sections'] = this.sections.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomeSingleSections {
  int id;
  String name;
  String sectionType;
  int sequence;
  Null moreText;
  String moreTarget;
  String display;
  List<HomeSingleContent> content;
  int videoCount;
  String titleImg;

  HomeSingleSections(
      {this.id,
      this.name,
      this.sectionType,
      this.sequence,
      this.moreText,
      this.moreTarget,
      this.display,
      this.content,
      this.videoCount,
      this.titleImg});

  HomeSingleSections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sectionType = json['sectionType'];
    sequence = json['sequence'];
    moreText = json['moreText'];
    moreTarget = json['moreTarget'];
    display = json['display'];
    if (json['content'] != null) {
      content = new List<HomeSingleContent>();
      json['content'].forEach((v) {
        content.add(new HomeSingleContent.fromJson(v));
      });
    }
    videoCount = json['videoCount'];
    titleImg = json['titleImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['sectionType'] = this.sectionType;
    data['sequence'] = this.sequence;
    data['moreText'] = this.moreText;
    data['moreTarget'] = this.moreTarget;
    data['display'] = this.display;
    if (this.content != null) {
      data['content'] = this.content.map((v) => v.toJson()).toList();
    }
    data['videoCount'] = this.videoCount;
    data['titleImg'] = this.titleImg;
    return data;
  }
}

class HomeSingleContent {
  Null contentId;
  String coverUrl;
  int imageWidth;
  int imageHeight;

  HomeSingleContent(
      {this.contentId, this.coverUrl, this.imageWidth, this.imageHeight});

  HomeSingleContent.fromJson(Map<String, dynamic> json) {
    contentId = json['contentId'];
    coverUrl = json['coverUrl'];
    imageWidth = json['imageWidth'];
    imageHeight = json['imageHeight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contentId'] = this.contentId;
    data['coverUrl'] = this.coverUrl;
    data['imageWidth'] = this.imageWidth;
    data['imageHeight'] = this.imageHeight;
    return data;
  }
}
