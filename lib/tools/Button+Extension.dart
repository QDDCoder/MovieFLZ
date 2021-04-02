/*
# @Time : 4/2/21 11:02 AM 
# @Author : 湛
# @File : Button+Extension.py
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
/*
 *图片 + 文字按钮  icon在左 tiitle在右
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

class LZClickImageAndTitleBtn extends StatelessWidget {
  const LZClickImageAndTitleBtn(
      {Key key,
      this.image,
      this.imageSize,
      this.title,
      this.padding,
      this.fontSize,
      this.textColor,
      this.onTap,
      this.mainAxisAlignment})
      : super(key: key);
  final Widget image; //image
  final Size imageSize; //image的宽高
  final String title; //文字
  final double padding; //图片和文字之间的间距
  final double fontSize; //文字的大小
  final Color textColor; //文字的颜色
  final onTap; //执行的方法
  final MainAxisAlignment mainAxisAlignment;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: ScreenUtil().setWidth(imageSize.width),
              height: ScreenUtil().setHeight(imageSize.height),
              child: image,
            ),
            SizedBox(
              width: ScreenUtil().setWidth(padding),
            ),
            Container(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: fontSize,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/**
 * 图片 + 文字按钮  icon在右 tiitle在左
 */
class LZClickTitleAndImageBtn extends StatelessWidget {
  const LZClickTitleAndImageBtn(
      {Key key,
      this.image,
      this.imageSize,
      this.title,
      this.padding = 0,
      this.fontSize,
      this.textColor,
      this.onTap,
      this.mainAxisAlignment})
      : super(key: key);

  final Widget image; //image
  final Size imageSize; //image的宽高
  final String title; //文字
  final double padding; //图片和文字之间的间距
  final double fontSize; //文字的大小
  final Color textColor; //文字的颜色
  final MainAxisAlignment mainAxisAlignment;
  final onTap; //执行的方法

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: fontSize,
                color: textColor,
              ),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(padding),
            ),
            Container(
                alignment: Alignment.centerLeft,
                width: ScreenUtil().setWidth(imageSize.width),
                height: ScreenUtil().setHeight(imageSize.height),
                child: image),
          ],
        ),
      ),
    );
  }
}

/*
* iconbutton icon在上 文字在下
*/
class LZExamIndexIconButton extends StatelessWidget {
  const LZExamIndexIconButton({Key key, this.action, this.icon, this.title})
      : super(key: key);
  final action;
  final String icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.white.withAlpha(0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: ScreenUtil().setWidth(30),
              height: ScreenUtil().setHeight(30),
              child: Image.asset(
                icon,
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 12, bottom: 12),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 28,
                  color: Color(0xFF3B3B3B),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: action,
    );
  }
}

/*
*只有文字的button
*/

class LZTextButton extends StatelessWidget {
  const LZTextButton({
    Key key,
    this.onTap,
    this.textColor,
    this.title,
    this.width,
    this.height,
    this.backColor = Colors.transparent,
    this.fontsize = 15.0,
    this.borderColor = Colors.transparent,
    this.circular = 0.0,
    this.padding,
    this.borderWidth,
  }) : super(key: key);

  final onTap;
  final width; //整体宽
  final height; //整体高
  final backColor; //背景颜色
  final circular; //弧度
  final double borderWidth;
  final Color borderColor;
  final Color textColor;
  final String title;
  final double fontsize;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: backColor,
          border: Border.all(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(circular),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontsize,
            color: textColor,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

/*

*点击带边框按钮

*/

class LZClickLineBtn extends StatelessWidget {
  const LZClickLineBtn(
      {Key key,
      this.color,
      this.title,
      this.onTap,
      this.circular,
      this.width,
      this.backColor,
      this.height})
      : super(key: key);

  final Color color; //颜色
  final String title; //文字
  final onTap; //点击方法
  final circular; //弧度
  final width; //整体宽
  final backColor; //背景颜色
  final height; //整体高

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 24,
            color: color,
          ),
        ),
        decoration: BoxDecoration(
          color: backColor,
          border: Border.all(width: 1, color: color),
          borderRadius: BorderRadius.circular(circular),
        ),
      ),
    );
  }
}

/*
*图片的点击按钮 iconBtn
*/
class LZMyIconBtn extends StatelessWidget {
  const LZMyIconBtn({
    Key key,
    this.iconSting,
    this.onPressed,
    this.width,
    this.height,
  }) : super(key: key);

  final iconSting; //图片的地址
  final onPressed; //执行的方法
  final width; //宽
  final height; //高

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(iconSting),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
