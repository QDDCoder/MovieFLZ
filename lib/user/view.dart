import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';
import 'state.dart';

class UserPage extends StatelessWidget {
  final UserLogic logic = Get.put(UserLogic());
  final UserState state = Get.find<UserLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}