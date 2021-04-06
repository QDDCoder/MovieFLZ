class AppConfigModel {
  List<LocalPage> localPage = List<LocalPage>();
  List<HomeBarPage> homeBarPage = List<HomeBarPage>();

  AppConfigModel();

  AppConfigModel.fromJson(Map<String, dynamic> json) {
    if (json['localPage'] != null) {
      localPage = new List<LocalPage>();
      json['localPage'].forEach((v) {
        localPage.add(new LocalPage.fromJson(v));
      });
    }
    if (json['homeBarPage'] != null) {
      homeBarPage = new List<HomeBarPage>();
      json['homeBarPage'].forEach((v) {
        homeBarPage.add(new HomeBarPage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.localPage != null) {
      data['localPage'] = this.localPage.map((v) => v.toJson()).toList();
    }
    if (this.homeBarPage != null) {
      data['homeBarPage'] = this.homeBarPage.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LocalPage {
  int pageType;
  String darkUnselImg;
  String webUrl;
  String selImg;
  String unselImg;
  String name;
  String index;
  String nativeAlias;
  String darkSelImg;
  bool isTrusted;

  LocalPage(
      {this.pageType,
      this.darkUnselImg,
      this.webUrl,
      this.selImg,
      this.unselImg,
      this.name,
      this.index,
      this.nativeAlias,
      this.darkSelImg,
      this.isTrusted});

  LocalPage.fromJson(Map<String, dynamic> json) {
    pageType = json['pageType'];
    darkUnselImg = json['darkUnselImg'];
    webUrl = json['webUrl'];
    selImg = json['selImg'];
    unselImg = json['unselImg'];
    name = json['name'];
    index = json['index'];
    nativeAlias = json['nativeAlias'];
    darkSelImg = json['darkSelImg'];
    isTrusted = json['isTrusted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageType'] = this.pageType;
    data['darkUnselImg'] = this.darkUnselImg;
    data['webUrl'] = this.webUrl;
    data['selImg'] = this.selImg;
    data['unselImg'] = this.unselImg;
    data['name'] = this.name;
    data['index'] = this.index;
    data['nativeAlias'] = this.nativeAlias;
    data['darkSelImg'] = this.darkSelImg;
    data['isTrusted'] = this.isTrusted;
    return data;
  }
}

class HomeBarPage {
  String darkSelPag;
  String selPag;
  int pageType;
  String darkUnselImg;
  String webUrl;
  String selImg;
  String unselImg;
  String name;
  int index;
  String nativeAlias;
  String darkSelImg;

  HomeBarPage(
      {this.darkSelPag,
      this.selPag,
      this.pageType,
      this.darkUnselImg,
      this.webUrl,
      this.selImg,
      this.unselImg,
      this.name,
      this.index,
      this.nativeAlias,
      this.darkSelImg});

  HomeBarPage.fromJson(Map<String, dynamic> json) {
    darkSelPag = json['darkSelPag'];
    selPag = json['selPag'];
    pageType = json['pageType'];
    darkUnselImg = json['darkUnselImg'];
    webUrl = json['webUrl'];
    selImg = json['selImg'];
    unselImg = json['unselImg'];
    name = json['name'];
    index = json['index'];
    nativeAlias = json['nativeAlias'];
    darkSelImg = json['darkSelImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['darkSelPag'] = this.darkSelPag;
    data['selPag'] = this.selPag;
    data['pageType'] = this.pageType;
    data['darkUnselImg'] = this.darkUnselImg;
    data['webUrl'] = this.webUrl;
    data['selImg'] = this.selImg;
    data['unselImg'] = this.unselImg;
    data['name'] = this.name;
    data['index'] = this.index;
    data['nativeAlias'] = this.nativeAlias;
    data['darkSelImg'] = this.darkSelImg;
    return data;
  }
}
