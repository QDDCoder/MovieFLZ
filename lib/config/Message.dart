/*
# @Time : 3/23/21 5:09 PM 
# @Author : 湛
# @File : Message.py
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

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_zh': {
          'home': '首页',
          'center': '我的',
          'kl': '快看',
          'setting': '设置',
          'cl': '修改语言',
          'ct': '修改主题',
          'cn': '中文',
          'us': '英文',
          'cle': '取消',
        },
        'en_US': {
          'home': 'Home',
          'center': 'Center',
          'kl': 'Look',
          'setting': 'Setting',
          'cl': 'ChangeLanguage',
          'ct': 'ChangeTheme',
          'cn': 'Chinese',
          'us': 'English',
          'cle': 'Cancle',
        },
      };
}
