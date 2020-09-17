import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keduo/base/baseTextStyle.dart';

class Toasts {
  ///提示吐司
  static showToast(String content) {
    Fluttertoast.showToast(
        msg: content,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static bool isShow = false;

  ///登录中...
  static showLoading(BuildContext context, String msg) {
    if (!isShow) {
      isShow = true;
      showGeneralDialog(
          context: context,
          barrierDismissible: false, // 是否能通过点击空白处关闭
          transitionDuration: const Duration(milliseconds: 150), // 动画时长
          pageBuilder: (BuildContext context, Animation animation,
              Animation secondaryAnimation) {
            return new Center(
              child: new SizedBox(
                width: 120.0,
                height: 120.0,
                child: new Container(
                  decoration: ShapeDecoration(
                    color: Colors.black54,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                  ),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Theme(
                        data: ThemeData(
                          cupertinoOverrideTheme: CupertinoThemeData(
                            brightness: Brightness.dark,
                          ),
                        ),
                        child: CupertinoActivityIndicator(
                          radius: 14,
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                        ),
                        child: new Text(
                          msg,
                          style: BaseTextStyle.styleFFFFFF_14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).then((value) {
        isShow = false;
      });
    }
  }

  ///登录成功
  static hideLoading(BuildContext context) {
    if (isShow) {
      Navigator.of(context).pop();
    }
  }

  static showText(String text) {
    Fluttertoast.showToast(
        msg: text,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  static cancelLoading() {
    Fluttertoast.cancel();
  }
}
