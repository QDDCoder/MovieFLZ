/*
# @Time : 4/30/21 2:28 PM 
# @Author : 湛
# @File : InputWidget.py
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
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputWidget extends StatefulWidget {
  FocusNode textFiledFocusNode = FocusNode();

  Function pushCallBack = () {};
  InputWidget({Key key}) : super(key: key);
  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  TextEditingController editingController = TextEditingController();
  bool isHidden = true;

  int textInputLength = 0;

  @override
  void initState() {
    // TODO: implement initState
    widget.textFiledFocusNode.addListener(() {
      if (widget.textFiledFocusNode.hasFocus) {
        isHidden = false;
      } else {
        isHidden = true;
      }
      setState(() {});
    });

    editingController.addListener(() {
      textInputLength = editingController.text.length;
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: isHidden,
      child: Container(
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20),
            right: ScreenUtil().setWidth(20),
            top: ScreenUtil().setHeight(14),
            bottom: ScreenUtil().setHeight(14)),
        color: Colors.red,
        height: ScreenUtil().setHeight(350),
        child: Column(
          children: [
            //输入评论
            _top_info_widget(),
            //中间的输入部分
            Expanded(
              child: _center_textfiled_input(),
            ),
            _build_bottom_info(),
          ],
        ),
      ),
    );
  }

  _top_info_widget() {
    return Row(
      children: [
        Expanded(
          child: Text(
            '写评论',
            style: TextStyle(color: Colors.black87, fontSize: 16),
          ),
        ),
        GestureDetector(
          onTap: () {
            widget.textFiledFocusNode.unfocus();
          },
          child: Container(
            child: Icon(
              Icons.close,
              color: Colors.black54,
              size: ScreenUtil().setWidth(40),
            ),
          ),
        ),
      ],
    );
  }

  _center_textfiled_input() {
    return Container(
      margin: EdgeInsets.only(
          top: ScreenUtil().setHeight(10), bottom: ScreenUtil().setHeight(10)),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(10)),
      ),
      child: TextField(
        focusNode: widget.textFiledFocusNode,
        autofocus: false,
        maxLengthEnforced: true,
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(200)
        ],
        controller: editingController,
        decoration: InputDecoration(
          isDense: true,
          contentPadding:
              EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.black54, fontSize: 14),
          hintText: "说点什么",
        ),
      ),
    );
  }

  _build_bottom_info() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //输入的数量
          Text(
            '${textInputLength}/200',
            style: TextStyle(fontSize: 12),
          ),
          //发表
          GestureDetector(
            onTap: () {
              widget.pushCallBack();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius:
                      BorderRadius.circular(ScreenUtil().setHeight(30))),
              padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(26),
                right: ScreenUtil().setWidth(26),
                top: ScreenUtil().setHeight(8),
                bottom: ScreenUtil().setHeight(8),
              ),
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
              child: Text(
                '发表',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
