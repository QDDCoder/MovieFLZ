/*
# @Time : 4/29/21 1:06 PM 
# @Author : 湛
# @File : MovieCommentModel.py
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
class MovieCommentModel {
  List<MovieCommentContent> content = List<MovieCommentContent>();
  int total;
  bool end;
  int currentPage;
  bool isEnd;

  MovieCommentModel();

  MovieCommentModel.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = new List<MovieCommentContent>();
      json['content'].forEach((v) {
        content.add(new MovieCommentContent.fromJson(v));
      });
    }
    total = json['total'];
    end = json['end'];
    currentPage = json['currentPage'];
    isEnd = json['isEnd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['end'] = this.end;
    data['currentPage'] = this.currentPage;
    data['isEnd'] = this.isEnd;
    return data;
  }
}

class MovieCommentContent {
  int id;
  int createTime;
  int updateTime;
  String createTimeStr;
  String type;
  int typeId;
  int authorId;
  MovieCommentAuthor author;
  String content;
  List<String> images;
  Null reply2Id;
  Null reply2User;
  bool liked;
  List<MovieCommentReplies> replies;
  int floor;
  int likeCount;
  int realLikeCount;
  int replyCount;
  bool featured;
  bool deleted;
  bool hot;

  MovieCommentContent(
      {this.id,
      this.createTime,
      this.updateTime,
      this.createTimeStr,
      this.type,
      this.typeId,
      this.authorId,
      this.author,
      this.content,
      this.images,
      this.reply2Id,
      this.reply2User,
      this.liked,
      this.replies,
      this.floor,
      this.likeCount,
      this.realLikeCount,
      this.replyCount,
      this.featured,
      this.deleted,
      this.hot});

  MovieCommentContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    createTimeStr = json['createTimeStr'];
    type = json['type'];
    typeId = json['typeId'];
    authorId = json['authorId'];
    author = json['author'] != null
        ? new MovieCommentAuthor.fromJson(json['author'])
        : null;
    content = json['content'];
    if (json['images'] != null) {
      images = new List<String>();
      json['images'].forEach((v) {
        images.add(v);
      });
    }
    reply2Id = json['reply2Id'];
    reply2User = json['reply2User'];
    liked = json['liked'];
    if (json['replies'] != null) {
      replies = new List<MovieCommentReplies>();
      json['replies'].forEach((v) {
        replies.add(new MovieCommentReplies.fromJson(v));
      });
    }
    floor = json['floor'];
    likeCount = json['likeCount'];
    realLikeCount = json['realLikeCount'];
    replyCount = json['replyCount'];
    featured = json['featured'];
    deleted = json['deleted'];
    hot = json['hot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['createTimeStr'] = this.createTimeStr;
    data['type'] = this.type;
    data['typeId'] = this.typeId;
    data['authorId'] = this.authorId;
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    data['content'] = this.content;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v).toList();
    }
    data['reply2Id'] = this.reply2Id;
    data['reply2User'] = this.reply2User;
    data['liked'] = this.liked;
    if (this.replies != null) {
      data['replies'] = this.replies.map((v) => v.toJson()).toList();
    }
    data['floor'] = this.floor;
    data['likeCount'] = this.likeCount;
    data['realLikeCount'] = this.realLikeCount;
    data['replyCount'] = this.replyCount;
    data['featured'] = this.featured;
    data['deleted'] = this.deleted;
    data['hot'] = this.hot;
    return data;
  }
}

class MovieCommentAuthor {
  int id;
  Null createTime;
  Null updateTime;
  String nickName;
  String headImgUrl;
  int level;
  bool isConfirmed;
  String roleInfo;
  Null certLabel;
  Null certNote;
  List<MovieCommentMedalList> medalList;

  MovieCommentAuthor(
      {this.id,
      this.createTime,
      this.updateTime,
      this.nickName,
      this.headImgUrl,
      this.level,
      this.isConfirmed,
      this.roleInfo,
      this.certLabel,
      this.certNote,
      this.medalList});

  MovieCommentAuthor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    nickName = json['nickName'];
    headImgUrl = json['headImgUrl'];
    level = json['level'];
    isConfirmed = json['isConfirmed'];
    roleInfo = json['roleInfo'];
    certLabel = json['certLabel'];
    certNote = json['certNote'];
    if (json['medalList'] != null) {
      medalList = new List<MovieCommentMedalList>();
      json['medalList'].forEach((v) {
        medalList.add(new MovieCommentMedalList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['nickName'] = this.nickName;
    data['headImgUrl'] = this.headImgUrl;
    data['level'] = this.level;
    data['isConfirmed'] = this.isConfirmed;
    data['roleInfo'] = this.roleInfo;
    data['certLabel'] = this.certLabel;
    data['certNote'] = this.certNote;
    if (this.medalList != null) {
      data['medalList'] = this.medalList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MovieCommentMedalList {
  String name;
  int endTime;
  String imgUrl;
  int id;
  bool display;

  MovieCommentMedalList(
      {this.name, this.endTime, this.imgUrl, this.id, this.display});

  MovieCommentMedalList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    endTime = json['endTime'];
    imgUrl = json['imgUrl'];
    id = json['id'];
    display = json['display'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['endTime'] = this.endTime;
    data['imgUrl'] = this.imgUrl;
    data['id'] = this.id;
    data['display'] = this.display;
    return data;
  }
}

class MovieCommentReplies {
  int id;
  int createTime;
  int updateTime;
  String createTimeStr;
  int authorId;
  String authorName;
  Null reply2UseId;
  Null reply2UserName;
  String content;
  bool liked;

  MovieCommentReplies(
      {this.id,
      this.createTime,
      this.updateTime,
      this.createTimeStr,
      this.authorId,
      this.authorName,
      this.reply2UseId,
      this.reply2UserName,
      this.content,
      this.liked});

  MovieCommentReplies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    createTimeStr = json['createTimeStr'];
    authorId = json['authorId'];
    authorName = json['authorName'];
    reply2UseId = json['reply2UseId'];
    reply2UserName = json['reply2UserName'];
    content = json['content'];
    liked = json['liked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['createTimeStr'] = this.createTimeStr;
    data['authorId'] = this.authorId;
    data['authorName'] = this.authorName;
    data['reply2UseId'] = this.reply2UseId;
    data['reply2UserName'] = this.reply2UserName;
    data['content'] = this.content;
    data['liked'] = this.liked;
    return data;
  }
}
