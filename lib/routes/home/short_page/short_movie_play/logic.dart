import 'dart:convert' as convert;

import 'package:get/get.dart';
import 'package:movie_flz/config/Global.dart';
import 'package:movie_flz/config/NetTools.dart';

import 'model/MovieCommentModel.dart';
import 'model/ShortMovieDetailModel.dart';
import 'model/ShortWatchModel.dart';

class ShortMoviePlayLogic extends GetxController {
  final clickmore = false.obs;
  final isFullScreen = false.obs;
  final shortMovieInfo = ShortMovieDetailModel().obs;

  final shortWatchModel = ShortWatchModel().obs;

  final movieCommentModel = MovieCommentModel().obs;

  int _page_number = 0;

  //获取短视频详情
  Future<void> getShortMovieInfo({movieId}) async {
    var r = await NetTools.dio.get<String>(
        "v3plus/video/detail?albumId=&token=rrtv-4277f839d5c35e69f81da643d8cc5ff2c95b0378&videoId=${movieId}");
    //缓存
    Global.netCache.cache.clear();
    shortMovieInfo.update((val) {
      ShortMovieDetailModel tempModel =
          ShortMovieDetailModel.fromJson(convert.jsonDecode(r.data)['data']);

      val.recommendVideoList.addAll(tempModel.recommendVideoList);
      val.videoDetailView = tempModel.videoDetailView;
    });
    //json 转 Map 转 更新
  }

  //获取短视频播放详情
  Future<void> getShortWatchMovieInfo({movieId}) async {
    var r = await NetTools.dio.get<String>(
        "watch/get_video_info?quality=super&subtitle=3&videoId=${movieId}");
    //缓存
    print('信息呢===>>>>>${r.data}');
    Global.netCache.cache.clear();
    shortWatchModel.update((val) {
      ShortWatchModel tempModel =
          ShortWatchModel.fromJson(convert.jsonDecode(r.data)['data']);
      val.m3u8 = tempModel.m3u8;
    });
    //json 转 Map 转 更新
  }

  Future<void> getMovieCommentInfos({movieId}) async {
    _page_number = _page_number + 1;

    var data = {
      'authorId': '',
      'order': 'DESC',
      'page': _page_number,
      'rows': 10,
      'type': 'VIDEO',
      'typeId': movieId,
    };
    //"authorId=&order=DESC&page=1&rows=10&sort=&type=VIDEO&typeId=3847385"
    var r = await NetTools.dio
        .post<String>("v3plus/comment/list", queryParameters: data);
    //缓存
    Global.netCache.cache.clear();
    movieCommentModel.update((val) {
      MovieCommentModel tempModel =
          MovieCommentModel.fromJson(convert.jsonDecode(r.data)['data']);
      val.total = tempModel.total;
      val.end = tempModel.end;
      val.currentPage = tempModel.currentPage;
      val.isEnd = tempModel.isEnd;
      val.content.addAll(tempModel.content);
    });
  }

  //回复评论
  Future<void> replay_comment(String content, String parentId, String reply2Id,
      String type, String typeId) async {
    //https://api.rr.tv/v3plus/comment/create
    var data = {
      'content': content,
      'parentId': parentId,
      'reply2Id': reply2Id,
      'type': type,
      'typeId': typeId,
    };
    //
    var r = await NetTools.dio
        .post<String>("v3plus/comment/create", queryParameters: data);
    if (r.statusCode == 200) {
      //缓存
      Global.netCache.cache.clear();
      movieCommentModel.update((val) {
        MovieCommentContent tempModel =
            MovieCommentContent.fromJson(convert.jsonDecode(r.data)['data']);
        movieCommentModel.value.content.insert(0, tempModel);
      });
    } else {
      //弹出错误信息
    }
    return;
  }

  //点击喜欢收藏
  Future<void> liked_reply(int clickIndex) async {
    //https://api.rr.tv/like/add
    var postUrl = 'like/add';
    if (movieCommentModel.value.content[clickIndex].liked) {
      postUrl = 'like/del';
    } else {
      postUrl = 'like/add';
    }
    var data = {
      'commentId': movieCommentModel.value.content[clickIndex].id,
      'token': 'rrtv-ae2ab2685b576252335861a93fa304f7b24eb81c',
    };
    //
    var r = await NetTools.dio.post<String>(postUrl, queryParameters: data);
    if (r.statusCode == 200) {
      //缓存
      Global.netCache.cache.clear();
      movieCommentModel.value.content[clickIndex].liked =
          !movieCommentModel.value.content[clickIndex].liked;
      movieCommentModel.value.content[clickIndex].liked
          ? movieCommentModel.value.content[clickIndex].likeCount++
          : movieCommentModel.value.content[clickIndex].likeCount--;
    } else {
      //弹出错误信息
    }
    return;
  }

  //是否点击的更多
  Future<void> changeClickMore() {
    clickmore.value = !clickmore.value;
  }

  //是否点击全屏
  Future<void> changeFullScreen() {
    isFullScreen.value = !isFullScreen.value;
  }
}
