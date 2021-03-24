import 'package:get/get.dart';
import 'package:movie_flz/config/RouteConfig.dart';

class UserCenterLogic extends GetxController {
  void toJumpSetting() {
    Get.toNamed(RouteConfig.setting);
  }
}
