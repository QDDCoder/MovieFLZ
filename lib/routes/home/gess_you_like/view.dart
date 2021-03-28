import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_flz/routes/home/views/HomeMovieView.dart';

import 'logic.dart';

class GessYouLikePage extends StatefulWidget {
  @override
  _GessYouLikePageState createState() => _GessYouLikePageState();
}

class _GessYouLikePageState extends State<GessYouLikePage> {
  final GessYouLikeLogic logic = Get.put(GessYouLikeLogic());

  @override
  void initState() {
    // TODO: implement initState
    logic.getGessYouLikeList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Color(0xFFefefef),
        appBar: AppBar(
          title: Text('猜你喜欢'),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            //电影的item
            return GessYouLikeListItemWidget(
              model: logic.gessYouLikeList.value.itemList[index],
            );
          },
          itemCount: logic.gessYouLikeList.value.itemList.length,
        ),
      );
    });
  }
}
