/*
# @Time : 3/23/21 5:26 PM 
# @Author : 湛
# @File : HomePage.py
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie_flz/routes/home/home_root/view.dart';
import 'package:movie_flz/routes/look/root/view.dart';
import 'package:movie_flz/routes/user_center/view.dart';
import 'package:movie_flz/routes/vip/vip_page/view.dart';

import 'routes/home/home_root/logic.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final HomeLogic logic = Get.put(HomeLogic());

  //页面信息
  final List<Widget> pages = List<Widget>();

  PageController pageController;
  //当前的页面
  int _current_select = 0;

  ValueNotifierData vd = ValueNotifierData(false);

  @override
  void initState() {
    // TODO: implement initState

    pageController = PageController(initialPage: _current_select);

    logic.getbottomBar().then((value) {
      setState(() {
        logic.configModel.value.homeBarPage.forEach((element) {
          if (element.index == 1) {
            pages.add(HomePage());
          } else if (element.index == 2) {
            pages.add(LookPage(
              data: vd,
            ));
          } else if (element.index == 3) {
            pages.add(VipPagePage());
          } else if (element.index == 4) {
            pages.add(UserCenterPage());
          }
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return pages.length > 0
        ? Obx(() {
            return Scaffold(
              body: PageView(
                controller: pageController,
                physics: NeverScrollableScrollPhysics(), //禁止滑动
                children: pages,
              ),
              bottomNavigationBar: _buildBottomNavigator(),
            );
          })
        : Container();
  }

  //底部的组件
  _buildBottomNavigator() {
    var tempHeight = ScreenUtil().bottomBarHeight == 0
        ? ScreenUtil().setHeight(110)
        : ScreenUtil().bottomBarHeight + ScreenUtil().setHeight(40);
    return BottomAppBar(
      child: Container(
        height: tempHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: logic.configModel.value.homeBarPage.map((e) {
            return GestureDetector(
              onTap: () {
                bottomClick(e.index - 1, context);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        bottom: ScreenUtil().setHeight(4),
                        top: ScreenUtil().setHeight(4)),
                    width: ScreenUtil().setWidth(90),
                    height: ScreenUtil().setWidth(60),
                    child: Image.network(
                      (e.index == _current_select + 1) ? e.selImg : e.unselImg,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    e.name,
                    style: TextStyle(
                        color: (e.index == _current_select + 1)
                            ? Colors.blue
                            : Colors.black45),
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  //底部按钮的点击
  bottomClick(int index, context) {
    setState(() {
      _current_select = index;
      pageController.jumpToPage(index);
      if (index == 1) {
        //看看的处理
        vd.value = true;
      } else {
        vd.value = false;
      }
    });
  }
}

/**
 * 看看页面的播放或者暂停通知
 */
class PlayOrPauseNotification extends Notification {
  final bool isPlaying;
  PlayOrPauseNotification({
    @required this.isPlaying,
  });
}
