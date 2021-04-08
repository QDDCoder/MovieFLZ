import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'config/Message.dart';
import 'config/RouteConfig.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(750, 1334),
      allowFontScaling: false,
      builder: () {
        return GestureDetector(
          onTap: () {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          },
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            //设置中英文国际化
            translations: Messages(),
            locale: Locale('en_zh', 'en_US'),
            title: 'home'.tr,
            fallbackLocale: Locale('en_zh', 'en_US'),
            theme: ThemeData(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              primarySwatch: Colors.blue,
            ),
            // home: MainPage(),
            initialRoute: RouteConfig.main,
            getPages: RouteConfig.getPages,
          ),
        );
      },
    );
  }
}
