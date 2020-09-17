import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keduo/base/baseColor.dart';
import 'package:keduo/base/baseSize.dart';
import 'package:keduo/base/baseTextStyle.dart';
import 'package:keduo/base/httpRequest.dart';
import 'package:keduo/base/routes.dart';
import 'package:keduo/model/userInfo.dart';
import 'package:keduo/utils/icon_utils.dart';
import 'package:keduo/utils/spUtil.dart';
import 'package:keduo/utils/toast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

////TODO 测试环境账号：13554428565 a123456    keduoqq0002/A123456   keduoq0001/A123456 蓝湖账号 ：trade@jc-ai.com OeT9ZkMfsPxBflIx
///4.可多后台测试环境  http://keduo.y.jc-test.cn/Admin    账号/密码：admin/admin123
///注意：各位在后台登录超管账号的时候，门店列表中，用户名tset0190和test0189的门店账号不要误删了

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController userEC = new TextEditingController();
  FocusNode userNode = FocusNode();
  TextEditingController pWEC = new TextEditingController();
  FocusNode pwNode = FocusNode();

  ///TODO1 注册通知
  TextValueAvaliableNotifier mTextAvaliableChangeNotifier =
      TextValueAvaliableNotifier();

  void saveChage() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (userEC.text.isEmpty) {
      print('用户名不能为空');
      return;
    }
    if (pWEC.text.isEmpty) {
      print('密码不能为空');
      return;
    }
    Toasts.showLoading(context, '登录中...');
    HttpRequest().request(
      NetMethod.POST,
      NetUrls.loginUrl,
      params: {"account": userEC.text, "password": pWEC.text},
      success: (json) {
        UserInfo userModel = UserInfo.fromJson(json);
        Future<bool> flag = setLocalData(userModel);
        flag.then((value) {
          Toasts.hideLoading(context);
          Toasts.showText("登录成功");
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.ROOT_PAGE, (route) => false);
          Navigator.pushNamedAndRemoveUntil(
              context, RoutesName.ROOT_PAGE, (route) => false);
        });
        print("-----44---${userModel.token}");
      },
      error: (error) {
        print("--------$error");
        Toasts.hideLoading(context);
        Toasts.showText(error.message);
      },
    );
  }

  Future<bool> setLocalData(UserInfo userModel) async {
    SharedPreferences prfs = await SharedPreferences.getInstance();
    prfs.setBool(StorageKeys.loginKey, true);
    prfs.setString(StorageKeys.tokenKey, userModel.token);
    prfs.setString(StorageKeys.userNameKey, userModel.username);
    return true;
  }

  @override
  void initState() {
    super.initState();
    userEC.addListener(() {
      if (userEC.text.length > 0) {
        if (!mTextAvaliableChangeNotifier.isTextValueAvaliable()) {
          mTextAvaliableChangeNotifier.setTextValueAvaliable1(true);
        }
      } else {
        if (mTextAvaliableChangeNotifier.isTextValueAvaliable()) {
          mTextAvaliableChangeNotifier.setTextValueAvaliable1(false);
        }
      }
    });
    pWEC.addListener(() {
      if (pWEC.text.length > 0) {
        if (!mTextAvaliableChangeNotifier.isTextValueAvaliable2()) {
          mTextAvaliableChangeNotifier.setTextValueAvaliable2(true);
        }
      } else {
        if (mTextAvaliableChangeNotifier.isTextValueAvaliable2()) {
          mTextAvaliableChangeNotifier.setTextValueAvaliable2(false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    BaseSize.getInstance().init(context);
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              child: Image(
                fit: BoxFit.fitHeight,
                image: AssetImage(IconUtils.getIconPath('ic_login_bg')),
                width: BaseSize.dp(375),
                height: BaseSize.dp(290),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: BaseSize.dp(27)),
              child: Text(
                '欢迎登录',
                style: BaseTextStyle.styleFFFFFF_18,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: BaseSize.dp(104)),
              child: Image.asset(IconUtils.getIconPath('ic_logo')),
            ),

            ///TODO2用ChangeNotifierProvider来订阅注册的通知
            ChangeNotifierProvider<TextValueAvaliableNotifier>.value(
              value: mTextAvaliableChangeNotifier,
              child: Positioned(
                top: BaseSize.dp(182),
                left: BaseSize.dp(16),
                right: BaseSize.dp(16),
                child: Container(
                  height: BaseSize.dp(300),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: BaseSize.dp(30)),

                      ///TODO3 接收通知UI做出相应调整
                      Consumer<TextValueAvaliableNotifier>(
                        builder: (context, textValueAvaliableNotifier, child) {
                          return changePWBuild(
                            context,
                            'ic_login_user',
                            '请输入用户名',
                            mTextAvaliableChangeNotifier.isTextValueAvaliable(),
                            false,
                            userNode,
                            pwNode,
                            userEC,
                          );
                        },
                      ),
                      SizedBox(height: BaseSize.dp(12)),
                      Consumer<TextValueAvaliableNotifier>(
                        builder: (context, textValueAvaliableNotifier, child) {
                          return changePWBuild(
                            context,
                            'ic_login_pass',
                            '请输入密码',
                            mTextAvaliableChangeNotifier.isTextValueAvaliable(),
                            true,
                            pwNode,
                            FocusNode(),
                            pWEC,
                          );
                        },
                      ),
                      getRich(),
                      SizedBox(height: BaseSize.dp(12)),
                      loginBtn(saveChage),
                      SizedBox(height: BaseSize.dp(12)),
                      registerBtn(context)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: BaseColor.colorFFF9F6F6,
    );
  }

  @override
  void dispose() {
    super.dispose();
    userEC.dispose();
    pWEC.dispose();
  }

  ///修改密码
  Widget changePWBuild(
    BuildContext context,
    String imageName, //左图
    String hintText, //占位字符
    bool show, //是否显示删除按钮
    bool obscureText, //明/密文
    FocusNode focusNode, //当前焦点
    FocusNode nextFocusNode, //下一个焦点
    TextEditingController _textEditingController, //控制器
  ) {
    return Container(
      //color: BaseColor.colorFFF5F5F5,
      height: BaseSize.dp(40),
      padding: EdgeInsets.only(left: BaseSize.dp(35), right: BaseSize.dp(35)),
      child: TextField(
        focusNode: focusNode,
        controller: _textEditingController,
        style: BaseTextStyle.style262626_14, //文本框内容风格
        textInputAction: TextInputAction.next, //右下角键盘文字：下一项
        obscureText: obscureText, //明/密文
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(16) //限制长度
        ],
        onEditingComplete: () =>
            FocusScope.of(context).requestFocus(nextFocusNode),
        decoration: InputDecoration(
            prefixIcon:
                Image(image: AssetImage(IconUtils.getIconPath(imageName))),
            prefixIconConstraints: BoxConstraints(
              //设置prefixIcon左对齐
              minWidth: 25,
              minHeight: 25,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ), //获取焦点时下划线颜色
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ), //失去焦点时下划线颜色
            hintText: hintText, //占位字符
            hintStyle: BaseTextStyle.styleD9D9D9_14, //占位字符样式
            suffixIcon: show
                ? IconButton(
                    icon: ImageIcon(
                        AssetImage(IconUtils.getIconPath('quxiaoshuru'))),
                    onPressed: () {
                      WidgetsBinding.instance.addPostFrameCallback(
                          (_) => _textEditingController.clear());
                    })
                : null),
        onChanged: (value) {
          ///TODO4 使用Provider.of来更新数据
          Provider.of<TextValueAvaliableNotifier>(context, listen: false)
              .setTextValueAvaliable1(value.length > 0);
        },
      ),
    );
  }
}

Widget getRich() {
  return Container(
      height: BaseSize.dp(40),
      width: double.infinity,
      padding: EdgeInsets.only(top: BaseSize.dp(12), left: BaseSize.dp(35)),
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
            text: "查看",
            style: TextStyle(
                color: BaseColor.colorFF999999, fontSize: BaseSize.sp(12)),
            children: [
              TextSpan(
                  text: "《用户协议》、",
                  style: TextStyle(
                    color: BaseColor.colorFFFFD04F,
                    fontSize: BaseSize.sp(12),
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {}),
              TextSpan(
                  text: "《隐私政策》",
                  style: TextStyle(
                      color: BaseColor.colorFFFFD04F,
                      fontSize: BaseSize.sp(12)),
                  recognizer: TapGestureRecognizer()..onTap = () {}),
            ]),
      ));
}

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
        '登录',
        style: BaseTextStyle.styleFFFFFF_14,
      ),
    ),
  );
}

Widget registerBtn(BuildContext context) {
  return Container(
    height: BaseSize.dp(40),
    width: double.infinity,
    padding: EdgeInsets.only(right: BaseSize.dp(35), left: BaseSize.dp(35)),
    child: RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BaseSize.dp(28)),
          side: BorderSide(color: Colors.red)),
      color: Colors.white,
      elevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      onPressed: () {
        Navigator.pushNamed(context, RoutesName.REGIST_PAGE);
      },
      child: Text(
        '注册',
        style: BaseTextStyle.style999999_14,
      ),
    ),
  );
}

///1:定义一个ChangeNotifier，来负责数据的变化通知
class TextValueAvaliableNotifier extends ChangeNotifier {
  bool _textValueAvaliable1 = false;
  bool _textValueAvaliable2 = false;
  bool _textvalueAvaliable3 = false;

  bool isTextValueAvaliable() => _textValueAvaliable1;

  void setTextValueAvaliable1(bool result) {
    _textValueAvaliable1 = result;
    notifyListeners();
  }

  bool isTextValueAvaliable2() => _textValueAvaliable2;

  void setTextValueAvaliable2(bool result) {
    _textValueAvaliable2 = result;
    notifyListeners();
  }

  bool isTextValueAvaliable3() => _textvalueAvaliable3;

  void setTextValueAvaliable3(bool result) {
    _textvalueAvaliable3 = result;
    notifyListeners();
  }
}
