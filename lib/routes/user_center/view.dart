import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class UserCenterPage extends StatelessWidget {
  final UserCenterLogic logic = Get.put(UserCenterLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人中心'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            logic.toJumpSetting();
          },
          child: Text('点击'),
        ),
      ),
    );
  }
}
