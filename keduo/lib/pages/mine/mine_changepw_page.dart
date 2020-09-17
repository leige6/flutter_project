import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keduo/base/baseAppBar.dart';
import 'package:keduo/base/baseColor.dart';
import 'package:keduo/base/baseSize.dart';
import 'package:keduo/base/baseTextStyle.dart';
import 'package:keduo/base/httpRequest.dart';
import 'package:keduo/utils/icon_utils.dart';
import 'package:keduo/utils/toast.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';

class MineChangePWPage extends StatefulWidget {
  @override
  MineChangePWPageState createState() => MineChangePWPageState();
}

class MineChangePWPageState extends State<MineChangePWPage> {
  TextEditingController oldPWEC = new TextEditingController();
  FocusNode oldNode = FocusNode();
  TextEditingController newPWEC = new TextEditingController();
  FocusNode newpwNode = FocusNode();
  TextEditingController twoPWEC = new TextEditingController();
  FocusNode twoPWNode = FocusNode();

  ///TODO1 注册通知
  TextValueAvaliableNotifier mTextAvaliableChangeNotifier =
      TextValueAvaliableNotifier();

  @override
  void initState() {
    super.initState();
    oldPWEC.addListener(() {
      if (oldPWEC.text.length > 0) {
        if (!mTextAvaliableChangeNotifier.isTextValueAvaliable()) {
          mTextAvaliableChangeNotifier.setTextValueAvaliable1(true);
        }
      } else {
        if (mTextAvaliableChangeNotifier.isTextValueAvaliable()) {
          mTextAvaliableChangeNotifier.setTextValueAvaliable1(false);
        }
      }
    });
    newPWEC.addListener(() {
      if (newPWEC.text.length > 0) {
        if (!mTextAvaliableChangeNotifier.isTextValueAvaliable2()) {
          mTextAvaliableChangeNotifier.setTextValueAvaliable2(true);
        }
      } else {
        if (mTextAvaliableChangeNotifier.isTextValueAvaliable2()) {
          mTextAvaliableChangeNotifier.setTextValueAvaliable2(false);
        }
      }
    });
    twoPWEC.addListener(() {
      if (twoPWEC.text.length > 0) {
        if (!mTextAvaliableChangeNotifier.isTextValueAvaliable3()) {
          mTextAvaliableChangeNotifier.setTextValueAvaliable3(true);
        }
      } else {
        if (mTextAvaliableChangeNotifier.isTextValueAvaliable3()) {
          mTextAvaliableChangeNotifier.setTextValueAvaliable3(false);
        }
      }
    });
  }

  void saveChage() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (oldPWEC.text.isEmpty) {
      Toasts.showText('旧密码不能为空');
      return;
    }
    if (newPWEC.text.isEmpty) {
      Toasts.showText('新密码不能为空');
      return;
    }
    if (twoPWEC.text.isEmpty) {
      Toasts.showText('二次密码不能为空');
      return;
    }
    Toasts.showLoading(context, '修改密码...');
    HttpRequest().request(
      NetMethod.POST,
      NetUrls.changePasswordUrl,
      params: {
        "old_pwd": oldPWEC.text,
        "new_pwd": newPWEC.text,
        "new_repwd": twoPWEC.text
      },
      success: (json) {
        Toasts.hideLoading(context);
        Toasts.showText('修改成功');
      },
      error: (error) {
        Toasts.hideLoading(context);
        Toasts.showText(error.message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(title: '修改密码', leading: widget),
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),

              ///TODO2用ChangeNotifierProvider来订阅注册的通知
              child: ChangeNotifierProvider<TextValueAvaliableNotifier>.value(
                value: mTextAvaliableChangeNotifier,
                child: Column(
                  children: <Widget>[
                    ///TODO2 接收通知UI做出相应调整
                    Consumer<TextValueAvaliableNotifier>(
                        builder: (context, textValueAvaliableNotifier, child) {
                      return changePWBuild(
                        context,
                        '旧密码：',
                        mTextAvaliableChangeNotifier.isTextValueAvaliable(),
                        oldNode,
                        newpwNode,
                        oldPWEC,
                      );
                    }),
                    Divider(
                        height: 1.0,
                        indent: 0.0,
                        color: BaseColor.colorFFEBEBEB),
                    Consumer<TextValueAvaliableNotifier>(
                        builder: (context, textValueAvaliableNotifier, child) {
                      return changePWBuild(
                        context,
                        '设置新密码：',
                        mTextAvaliableChangeNotifier.isTextValueAvaliable2(),
                        newpwNode,
                        twoPWNode,
                        newPWEC,
                      );
                    }),
                    Divider(
                        height: 1.0,
                        indent: 0.0,
                        color: BaseColor.colorFFEBEBEB),
                    Consumer<TextValueAvaliableNotifier>(
                        builder: (context, textValueAvaliableNotifier, child) {
                      return changePWBuild(
                        context,
                        '确认新密码：',
                        mTextAvaliableChangeNotifier.isTextValueAvaliable3(),
                        twoPWNode,
                        FocusNode(),
                        twoPWEC,
                      );
                    }),
                    SizedBox(height: 40),
                    Container(
                      height: 48,
                      width: BaseSize.screenWidth - 76,
                      child: FlatButton(
                        color: BaseColor.colorFFEB5424,
                        onPressed: saveChage,
                        child: Text(
                          '确定',
                          style: BaseTextStyle.styleFFFFFF_16,
                        ),
                        shape: RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(48)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: BaseColor.colorFFF5F5F5,
    );
  }

  ///修改密码
  Widget changePWBuild(
    BuildContext context,
    String name,
    bool show,
    FocusNode focusNode,
    FocusNode nextFocusNode,
    TextEditingController _textEditingController,
  ) {
    return Container(
      color: BaseColor.colorFFFFFFFF,
      height: 56,
      padding: EdgeInsets.only(left: 16, right: 0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 100,
            child: Text(
              name,
              style: BaseTextStyle.style999999_14,
            ),
          ),
          Expanded(
            child: TextField(
              focusNode: focusNode,
              controller: _textEditingController,
              style: BaseTextStyle.style262626_14, //文本框内容风格
              textInputAction: TextInputAction.next, //右下角键盘文字：下一项
              obscureText: true, //明/密文
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(16) //限制长度
              ],
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(nextFocusNode),
              decoration: InputDecoration(
                  border: InputBorder.none, // 去掉下划线
                  hintText: '请填写', //占位字符
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
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    oldPWEC.dispose();
    newPWEC.dispose();
    twoPWEC.dispose();
    oldNode.dispose();
    newpwNode.dispose();
    twoPWNode.dispose();
  }
}
