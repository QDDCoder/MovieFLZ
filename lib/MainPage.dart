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
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_flz/routes/home/view.dart';
import 'package:movie_flz/routes/look/view.dart';
import 'package:movie_flz/routes/user_center/view.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //页面信息
  final pages = [HomePage(), LookPage(), UserCenterPage()];
  //当前的页面
  int _current_select = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_current_select],
      bottomNavigationBar: _buildBottomNavigator(),
    );
  }

  //底部的组件
  _buildBottomNavigator() {
    return BottomNavigationBar(
      //选择的保存位置
      currentIndex: _current_select,
      //点击事件
      onTap: bottomClick,
      // 底部导航
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('home'.tr)),
        BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('kl'.tr)),
        BottomNavigationBarItem(
            icon: Icon(Icons.person), title: Text('center'.tr)),
      ],
    );
  }

  //底部按钮的点击
  bottomClick(int index) {
    setState(() {
      _current_select = index;
    });
  }
}
