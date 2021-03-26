import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class GessYouLikePage extends StatelessWidget {
  final GessYouLikeLogic logic = Get.put(GessYouLikeLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('猜你喜欢'),
      ),
      body: Center(
        child: Text('猜你喜欢'),
      ),
    );
  }
}
