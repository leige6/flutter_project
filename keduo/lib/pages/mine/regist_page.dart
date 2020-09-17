import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:keduo/base/baseColor.dart';
import 'package:keduo/base/baseSize.dart';
import 'package:keduo/base/baseTextStyle.dart';
import 'package:keduo/base/httpRequest.dart';
import 'package:keduo/utils/icon_utils.dart';
import 'package:keduo/utils/toast.dart';

class RegistPage extends StatefulWidget {
  @override
  RegistPageState createState() => RegistPageState();
}

class RegistPageState extends State<RegistPage> {
  bool stater = false;

  int seconds = 0;
  Timer _timer;
  bool isClickDisable = false; //防止点击过快导致Timer出现无法停止的问题

  TextEditingController phoneEC = new TextEditingController();
  FocusNode phoneNode = FocusNode();
  TextEditingController codeEC = new TextEditingController();
  FocusNode codeNode = FocusNode();
  TextEditingController pwEC = new TextEditingController();
  FocusNode pwNode = FocusNode();
  TextEditingController pWTEC = new TextEditingController();
  FocusNode pwtNode = FocusNode();

  void saveChage() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (phoneEC.text.isEmpty) {
      Toasts.showText('手机号不能为空');
      return;
    }
    if (codeEC.text.isEmpty) {
      Toasts.showText('验证码不能为空');
      return;
    }
    if (pwEC.text.isEmpty) {
      Toasts.showText('密码不能为空');
      return;
    }
    if (pWTEC.text.isEmpty) {
      Toasts.showText('确认密码不能为空');
      return;
    }
    Toasts.showLoading(context, '注册...');
    HttpRequest().request(
      NetMethod.POST,
      NetUrls.registerUrl,
      params: {
        "mobile": phoneEC.text,
        'verifyCode': codeEC.text,
        'new_pwd': pwEC.text,
        'new_repwd': pWTEC.text
      },
      success: (json) {
        Toasts.hideLoading(context);
        Toasts.showText('注册成功');
        print("-----44---$json");
      },
      error: (error) {
        Toasts.hideLoading(context);
        Toasts.showText(error.message);
      },
    );
  }

  ///获取验证码
  void getCodeAction() {
    if (isClickDisable == true) {
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());
    if (phoneEC.text.isEmpty) {
      Toasts.showText('手机号不能为空');
      return;
    }
    setState(() {
      startTimer();
    });
    Toasts.showLoading(context, '数据请求...');
    HttpRequest().request(
      NetMethod.POST,
      NetUrls.getVerifyCodeUrl,
      params: {"mobile": phoneEC.text},
      success: (json) {
        Toasts.hideLoading(context);
        Toasts.showText('验证码发送成功');
        print("-----44---$json");
      },
      error: (error) {
        Toasts.hideLoading(context);
        Toasts.showText(error.message);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    phoneEC.dispose();
    codeEC.dispose();
    pwEC.dispose();
    pWTEC.dispose();
    phoneNode.dispose();
    codeNode.dispose();
    pwNode.dispose();
    pwtNode.dispose();
    cancelTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        leading: IconButton(
            icon: Image.asset(IconUtils.getIconPath('fanhui')),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          '注册',
          style: TextStyle(color: BaseColor.colorFF262626, fontSize: 18),
        ),
        backgroundColor: Colors.white,
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: ListView(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16),
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(width: BaseSize.dp(15)),
                  Text('手机号', style: BaseTextStyle.style999999_15),
                  SizedBox(width: BaseSize.dp(48)),
                  Expanded(
                    child: TextField(
                      focusNode: phoneNode,
                      controller: phoneEC,
                      style: BaseTextStyle.style262626_14, //文本框内容风格
                      textInputAction: TextInputAction.next, //右下角键盘文字：下一项
                      obscureText: false, //明/密文
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11) //限制长度
                      ],
                      decoration: InputDecoration(
                        border: InputBorder.none, // 去掉下划线
                        hintText: '请输入手机号', //占位字符
                        hintStyle: BaseTextStyle.styleDCDCDC_15, //占位字符样式
                      ),
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(codeNode),
                    ),
                  )
                ],
              ),
            ),
            Divider(height: 1.0, indent: 0.0, color: BaseColor.colorFFEBEBEB),
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(width: BaseSize.dp(15)),
                  Text('验证码', style: BaseTextStyle.style999999_15),
                  SizedBox(width: BaseSize.dp(48)),
                  Expanded(
                    child: TextField(
                      focusNode: codeNode,
                      controller: codeEC,
                      style: BaseTextStyle.style262626_14, //文本框内容风格
                      textInputAction: TextInputAction.next, //右下角键盘文字：下一项
                      obscureText: false, //明/密文
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(11) //限制长度
                      ],
                      decoration: InputDecoration(
                        border: InputBorder.none, // 去掉下划线
                        hintText: '请输入验证码', //占位字符
                        hintStyle: BaseTextStyle.styleDCDCDC_15, //占位字符样式
                      ),
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(pwNode),
                    ),
                  ),
                  countdownState(seconds, getCodeAction),
                  SizedBox(width: BaseSize.dp(15)),
                ],
              ),
            ),
            Divider(height: 1.0, indent: 0.0, color: BaseColor.colorFFEBEBEB),
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(width: BaseSize.dp(15)),
                  Text('输入密码', style: BaseTextStyle.style999999_15),
                  SizedBox(width: BaseSize.dp(48)),
                  Expanded(
                    child: TextField(
                      focusNode: pwNode,
                      controller: pwEC,
                      style: BaseTextStyle.style262626_14, //文本框内容风格
                      textInputAction: TextInputAction.next, //右下角键盘文字：下一项
                      obscureText: true, //明/密文
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(11) //限制长度
                      ],
                      decoration: InputDecoration(
                        border: InputBorder.none, // 去掉下划线
                        hintText: '请输入密码', //占位字符
                        hintStyle: BaseTextStyle.styleDCDCDC_15, //占位字符样式
                      ),
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(pwtNode),
                    ),
                  )
                ],
              ),
            ),
            Divider(height: 1.0, indent: 0.0, color: BaseColor.colorFFEBEBEB),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(width: BaseSize.dp(15)),
                  Text('确认密码', style: BaseTextStyle.style999999_15),
                  SizedBox(width: BaseSize.dp(48)),
                  Expanded(
                    child: TextField(
                      focusNode: pwtNode,
                      controller: pWTEC,
                      style: BaseTextStyle.style262626_14, //文本框内容风格
                      textInputAction: TextInputAction.done, //右下角键盘文字：下一项
                      obscureText: true, //明/密文
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(11) //限制长度
                      ],
                      decoration: InputDecoration(
                        border: InputBorder.none, // 去掉下划线
                        hintText: '请输入确认密码', //占位字符
                        hintStyle: BaseTextStyle.styleDCDCDC_15, //占位字符样式
                      ),
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(FocusNode()),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: BaseSize.dp(76),
              padding:
                  EdgeInsets.only(left: BaseSize.dp(10), top: BaseSize.dp(15)),
              child: Text('密码长度6-12位字母和数字的组合 首末密码必须为大写字母',
                  style: BaseTextStyle.styleFFFF853A_12),
            ),
            loginBtn(saveChage),
          ],
        ),
      ),
      backgroundColor: BaseColor.colorFFF5F5F5,
    );
  }

  void startTimer() {
    isClickDisable = true;
    //获取当期时间
    var now = DateTime.now();
    //获取 2 分钟的时间间隔
    var twoHours = now.add(Duration(minutes: 1)).difference(now);
    //获取总秒数，2 分钟为 120 秒
    seconds = twoHours.inSeconds;

    //设置 1 秒回调一次
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      //更新界面
      setState(() {
        //秒数减一，因为一秒回调一次
        seconds--;
      });
      if (seconds == 0) {
        //倒计时秒数为0，取消定时器
        cancelTimer();
      }
    });
  }

  void cancelTimer() {
    if (_timer != null) {
      isClickDisable = false;
      _timer.cancel();
      _timer = null;
    }
  }
}

///********************登录按钮 */
Widget loginBtn(saveChage) {
  return Container(
    height: BaseSize.dp(40),
    width: double.infinity,
    padding: EdgeInsets.only(right: BaseSize.dp(35), left: BaseSize.dp(35)),
    child: RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BaseSize.dp(28)),
          side: BorderSide(color: Colors.red)),
      color: Colors.red,
      elevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      onPressed: saveChage,
      child: Text(
        '注册',
        style: BaseTextStyle.styleFFFFFF_14,
      ),
    ),
  );
}

///********************验证码按钮 */

Widget countdownState(
  int seconds,
  Function tapAction,
) {
  return Center(
    child: GestureDetector(
      onTap: () {
        tapAction();
      },
      child: seconds == 0
          ? Text(
              '获取验证码',
              style: BaseTextStyle.styleFFFFD04F_14,
            )
          : Text(
              '$seconds后重新获取',
              style: BaseTextStyle.styleFFFFD04F_14,
            ),
    ), //Text(constructTime(seconds))
  );
}
