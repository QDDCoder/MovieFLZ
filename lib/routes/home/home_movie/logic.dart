import 'dart:convert' as convert;

import 'package:get/get.dart';
import 'package:movie_flz/config/Global.dart';
import 'package:movie_flz/config/NetTools.dart';

import 'Model/HomeMovieModel.dart';

class HomeMovieLogic extends GetxController {
  final homeMovieInfo = HomeMoveModel().obs;

  int _page_number = 1;
  int course_index = 0;

  //获取用户项目列表
  Future<void> getMovieInfo({refresh = true, page_key}) async {
    _page_number = refresh ? 1 : _page_number + 1;
    //换一批
    course_index = refresh ? 0 : course_index;

    var r = await NetTools.dio.get<String>(
      "v3plus/index/channel?pageNum=${_page_number}&position=CHANNEL_${page_key}",
    );
    //缓存
    Global.netCache.cache.clear();
    homeMovieInfo.update((val) {
      HomeMoveModel tempModel =
          HomeMoveModel.fromJson(convert.jsonDecode(r.data)['data']);
      if (refresh) {
        val.bean = tempModel.bean;
        val.bannerTop = tempModel.bannerTop;
        val.guessFavorite = tempModel.guessFavorite;
        val.sections = tempModel.sections;
      } else {
        val.sections.addAll(tempModel.sections);
      }
    });
    //json 转 Map 转 更新
  }

  //
  test_get_video() async {
    var r = await NetTools.dio.get<String>(
      //106465 - 3119053
      //3757837
      //3800761
      "https://api.rr.tv/watch/get_video_info?quality=super&subtitle=3&videoId=151988",
    );
    print('视频信息====>>>${r.data}');
  }

  //换一批
  Future<void> refushPeoplesLook({int sectionId}) async {
    print("换一批的数据量=====>>>>${sectionId}");
    course_index++;
    var r = await NetTools.dio.get<String>(
      "section/search/change?cursor=${course_index * 6}&sectionId=${sectionId}",
    );
    //缓存
    Global.netCache.cache.clear();
    homeMovieInfo.update((val) {
      if (convert.jsonDecode(r.data)['data'] != null) {
        //解析数据
        var sectionContents = new List<SectionContents>();
        convert.jsonDecode(r.data)['data'].forEach((v) {
          sectionContents.add(new SectionContents.fromJson(v));
        });

        //数据替换
        homeMovieInfo.update((val) {
          val.sections.forEach((element) {
            if (element.sectionType == "VIDEO" &&
                element.display == "SCROLL" &&
                (element.id == sectionId)) {
              element.sectionContents = sectionContents;
            }
          });
        });
      }
    });
  }
}
