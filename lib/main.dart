import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config/Message.dart';
import 'config/RouteConfig.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //设置中英文国际化
      translations: Messages(),
      locale: Locale('en_zh', 'en_US'),
      title: 'home'.tr,
      fallbackLocale: Locale('en_zh', 'en_US'),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MainPage(),
      initialRoute: RouteConfig.main,
      getPages: RouteConfig.getPages,
    );
  }
}
