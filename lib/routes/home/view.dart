import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class HomePage extends StatelessWidget {
  final HomeLogic logic = Get.put(HomeLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'.tr),
      ),
    );
  }
}
