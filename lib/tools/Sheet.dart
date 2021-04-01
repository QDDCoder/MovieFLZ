/*
# @Time : 3/24/21 9:53 AM 
# @Author : 湛
# @File : Sheet.py
# @Desc : ==============================================
# 打工赚不了几个钱,但打工能让你没时间花钱。
#      ┌─┐       ┌─┐
#   ┌──┘ ┴───────┘ ┴──┐
#   │       ───       │
#   │  ─┬┘       └┬─  │
#   │       ─┴─       │
#   └───┐         ┌───┘
#       │         │
#       │         └──────────────┐
#       │                        ├─┐
#       │                        ┌─┘
#       └─┐  ┐  ┌───────┬──┐  ┌──┘
#         │ ─┤ ─┤       │ ─┤ ─┤
#         └──┴──┘       └──┴──┘
#                神兽保佑
#               代码无BUG!
# ======================================================
*/
import 'package:flutter/material.dart';

// 弹出底部sheet
Future<int> showCustomBottomSheet({
  @required BuildContext context,
  double radiusSize = 5.0, // 默认圆角为5
  double paddingSize = 10.0, // 默认左右间距为10
  String title = '', // 标题
  double titleFontSize = 14, // 标题字体大小
  Color titleColor = Colors.red, // 标题默认颜色
  String cancelTitle = '取消',
  double cancelHeight = 45,
  double cancelFontSize = 15,
  Color cancelTextColor = Colors.black,
  List<Widget> children = const <Widget>[],
}) {
  assert(context != null);
  return showModalBottomSheet<int>(
    context: context,
    backgroundColor: Color(0x00ffffff), // 背景色设置为无色
    elevation: 0, // 透明度
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () {
          Navigator.pop(context, -1);
        },
        child: Container(
            // 设置颜色后点击事件才有效
            alignment: Alignment.bottomCenter,
            color: Color(0x00ffffff),
            padding: EdgeInsets.fromLTRB(paddingSize, 0, paddingSize,
                MediaQuery.of(context).padding.bottom),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                title != ''
                    ? GestureDetector(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          constraints: BoxConstraints(
                            minHeight: 45,
                          ),
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: titleColor, fontSize: titleFontSize),
                          ),
                        ),
                      )
                    : Container(),
                Column(children: children),
                Container(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context, 0);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.all(Radius.circular(radiusSize))),
                    alignment: Alignment.center,
                    height: cancelHeight,
                    child: Text(
                      cancelTitle,
                      style: TextStyle(
                          color: cancelTextColor, fontSize: cancelFontSize),
                    ),
                  ),
                ),
              ],
            )),
      );
    },
  );
}

/// 添加时候的item
Widget actionItem({
  @required BuildContext context,
  @required int index,
  @required String title,
  Color color = Colors.black,
  Color backgroundColor = Colors.white,
  double radiusSize = 5.0, // 默认圆角为5
  bool isLastOne = false, // 是否为最后一个，最后一个如果有圆角的话需要增加底部圆角
  double height = 45,
  double fontSize = 15,
}) {
  assert(context != null);
  assert(title != null);
  assert(index > 0);
  return GestureDetector(
      onTap: () {
        Navigator.pop(context, index);
      },
      child: Column(
        children: <Widget>[
          /// 分割线
          Divider(
            height: 0.5,
            color: Color(0xffeeeeee),
          ),
          Container(
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: isLastOne
                    ? BorderRadius.only(
                        bottomLeft: Radius.circular(radiusSize),
                        bottomRight: Radius.circular(radiusSize))
                    : BorderRadius.all(Radius.circular(0))),
            alignment: Alignment.center,
            height: height,
            child: Text(
              title,
              style: TextStyle(color: color, fontSize: fontSize),
            ),
          )
        ],
      ));
}
