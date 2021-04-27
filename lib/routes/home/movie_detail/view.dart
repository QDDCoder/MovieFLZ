import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

/**
 * 电影详情页
 */
class MovieDetailPage extends StatefulWidget {
  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  final MovieDetailLogic logic = Get.put(MovieDetailLogic());
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
