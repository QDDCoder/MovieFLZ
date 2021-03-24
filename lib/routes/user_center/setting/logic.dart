import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_flz/config/Global.dart';
import 'package:movie_flz/tools/Sheet.dart';

class SettingLogic extends GetxController {
  void jumpToChangeLocal(BuildContext context) async {
    int index1 = await showPayActionSheets(
        context: context, title: 'cl'.tr, cancle_title: 'cle'.tr);

    if (index1 == 1) {
      //选择了中文
      var locale = Locale('en_zh', 'en_US');
      Get.updateLocale(locale);
    } else if (index1 == 2) {
      //选择了英文
      var locale = Locale('en_US', 'en_zh');
      Get.updateLocale(locale);
    }
  }

  /// 具体使用方式
  Future<int> showPayActionSheets(
      {@required BuildContext context,
      @required String title,
      @required String cancle_title}) {
    return showCustomBottomSheet(
        context: context,
        title: title,
        cancelTitle: cancle_title,
        children: [
          actionItem(context: context, index: 1, title: 'cn'.tr),
          actionItem(
              context: context, index: 2, title: 'us'.tr, isLastOne: true),
        ]);
  }

  /*修改主题
  * */
  void jumpToChangeTheme(BuildContext context) async {
    showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 400,
          child: Column(
            children: [
              //头部标识
              _buildTitle(),
              //主题的body
              _buildThemeBody(),
            ],
          ),
        );
      },
    );
  }

  _buildTitle() {
    return Container(
      alignment: Alignment.center,
      height: 80,
      child: Text(
        '修改主题',
        style: TextStyle(
            color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 18),
      ),
    );
  }

  _buildThemeBody() {
    return Expanded(
      child: ListView.builder(
        itemCount: Global.themes.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: Container(
              height: 56,
              color: Global.themes[index],
            ),
            onTap: () {
              Get.changeTheme(ThemeData(primarySwatch: Global.themes[index]));
              Navigator.of(context).pop();
              //对外返回点击的位置
              //Navigator.of(context).pop(index);
            },
          );
        },
      ),
    );
  }
}
