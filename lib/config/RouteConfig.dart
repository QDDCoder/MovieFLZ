/*
# @Time : 3/24/21 9:24 AM 
# @Author : 湛
# @File : RouteConfig.py
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
import 'package:get/get.dart';
import 'package:movie_flz/routes/home/gess_you_like/view.dart';
import 'package:movie_flz/routes/home/home_list_card_view/view.dart';
import 'package:movie_flz/routes/home/home_root/view.dart';
import 'package:movie_flz/routes/home/home_single_image/view.dart';
import 'package:movie_flz/routes/home/more_movies/view.dart';
import 'package:movie_flz/routes/home/movie_category/view.dart';
import 'package:movie_flz/routes/home/season_rank/view.dart';
import 'package:movie_flz/routes/home/top_movies_list_view_widget/view.dart';
import 'package:movie_flz/routes/look/view.dart';
import 'package:movie_flz/routes/user_center/setting/view.dart';
import 'package:movie_flz/routes/user_center/view.dart';

import '../MainPage.dart';

class RouteConfig {
  ///主页面
  static final String main = "/";

  ///home
  static final String home = "/home";

  ///look
  static final String look = "/look";

  ///我的
  static final String me = "/me";

  ///设置
  static final String setting = "/me/setting";

  ///猜你喜欢
  static final String ges_you_like = '/home/GessYouLikePage';

  ///查看更多
  static final String look_more_movies = '/home/LookMoreMovies';

  ///卡片的查看更多
  static final String list_card_more = '/home/ListCardMore';

  ///榜单的ListView
  static final String top_movies_list = '/home/TopMoviesList';

  ///首页的单图片
  static final String single_image = '/home/singleImage';

  ///首页的影视分类
  static final String category_movie = '/home/allCategory';

  ///首页排行榜
  static final String season_rank = '/home/seasonRank';

  ///别名映射页面
  static final List<GetPage> getPages = [
    GetPage(name: main, page: () => MainPage()),
    GetPage(name: home, page: () => HomePage()),
    GetPage(name: look, page: () => LookPage()),
    GetPage(name: me, page: () => UserCenterPage()),
    GetPage(name: setting, page: () => SettingPage()),
    GetPage(name: ges_you_like, page: () => GessYouLikePage()),
    GetPage(name: look_more_movies, page: () => MoreMoviesPage()),
    GetPage(name: list_card_more, page: () => HomeListCardViewPage()),
    GetPage(name: top_movies_list, page: () => TopMoviesListViewWidgetPage()),
    GetPage(name: single_image, page: () => HomeSingleImagePage()),
    GetPage(name: category_movie, page: () => MovieCategoryPage()),
    GetPage(name: season_rank, page: () => SeasonRankPage()),
  ];
}
