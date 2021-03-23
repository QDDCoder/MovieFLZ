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
        'en_US': {
          'home': 'home',
          'center': 'center',
        },
        'en_zh': {
          'home': '首页',
          'center': '用户中心',
        }
      };
}
