import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class SettingPage extends StatelessWidget {
  final SettingLogic logic = Get.put(SettingLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('setting'.tr),
      ),
      body: ListView(
        children: [
          FlatButton(
            onPressed: () {
              //弹窗修改语言
              // logic.jumpToChangeLocal();
              logic.jumpToChangeLocal(context);
            },
            child: Text('cl'.tr),
          ),
          FlatButton(
            onPressed: () {
              //弹窗修改主题
              logic.jumpToChangeTheme(context);
            },
            child: Text('ct'.tr),
          ),
        ],
      ),
    );
  }
}
