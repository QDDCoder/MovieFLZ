class GessYouLikeModel {
  List<GessYouLikeItmeModel> itemList = List<GessYouLikeItmeModel>();

  GessYouLikeModel();
  GessYouLikeModel.fromJson({Map<String, dynamic> json}) {
    if (json['data'] != null) {
      json['data'].forEach((v) {
        itemList.add(GessYouLikeItmeModel.fromJson(v));
      });
    }
  }
}

class GessYouLikeItmeModel {
  int dramaId;
  String title;
  String subTitle;
  String coverUrl;
  String year;
  List<String> areaList;
  List<String> plotTypeList;
  String dramaType;
  double score;
  List<String> actorList;
  List<String> directorList;
  String feeMode;
  String itemType;
  String recomTraceId;
  String recomTraceInfo;
  bool favorite;

  GessYouLikeItmeModel(
      {this.dramaId,
      this.title,
      this.subTitle,
      this.coverUrl,
      this.year,
      this.areaList,
      this.plotTypeList,
      this.dramaType,
      this.score,
      this.actorList,
      this.directorList,
      this.feeMode,
      this.itemType,
      this.recomTraceId,
      this.recomTraceInfo,
      this.favorite});

  GessYouLikeItmeModel.fromJson(Map<String, dynamic> json) {
    dramaId = json['dramaId'];
    title = json['title'];
    subTitle = json['subTitle'];
    coverUrl = json['coverUrl'];
    year = '${json['year']}';
    areaList = json['areaList'].cast<String>();
    plotTypeList = json['plotTypeList'].cast<String>();
    dramaType = json['dramaType'];
    score = json['score'];
    actorList = json['actorList'].cast<String>();
    directorList = json['directorList'].cast<String>();
    feeMode = json['feeMode'];
    itemType = json['itemType'];
    recomTraceId = json['recomTraceId'];
    recomTraceInfo = json['recomTraceInfo'];
    favorite = json['favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dramaId'] = this.dramaId;
    data['title'] = this.title;
    data['subTitle'] = this.subTitle;
    data['coverUrl'] = this.coverUrl;
    data['year'] = this.year;
    data['areaList'] = this.areaList;
    data['plotTypeList'] = this.plotTypeList;
    data['dramaType'] = this.dramaType;
    data['score'] = this.score;
    data['actorList'] = this.actorList;
    data['directorList'] = this.directorList;
    data['feeMode'] = this.feeMode;
    data['itemType'] = this.itemType;
    data['recomTraceId'] = this.recomTraceId;
    data['recomTraceInfo'] = this.recomTraceInfo;
    data['favorite'] = this.favorite;
    return data;
  }
}
