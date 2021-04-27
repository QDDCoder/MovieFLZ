/*
# @Time : 4/16/21 4:10 PM 
# @Author : 湛
# @File : WebJumpView.py
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
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebJumpPage extends StatefulWidget {
  @override
  _WebJumpPageState createState() => _WebJumpPageState();
}

class _WebJumpPageState extends State<WebJumpPage> {
  String _initUrl = '';
  String _initTittle = '';
  @override
  void initState() {
    // TODO: implement initState
    _initUrl = Get.arguments['initUrl'];
    _initTittle = Get.arguments['initTittle'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            _initTittle,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: WebView(
          initialUrl: _initUrl,
        ));
  }
}
