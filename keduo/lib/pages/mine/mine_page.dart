import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keduo/base/baseColor.dart';
import 'package:keduo/base/baseSize.dart';
import 'package:keduo/base/baseTextStyle.dart';
import 'package:keduo/base/routes.dart';
import 'package:keduo/pages/mine/view/discoverCell.dart';
import 'package:keduo/pages/mine/view/mineHead.dart';
import 'package:keduo/utils/icon_utils.dart';
import 'package:keduo/utils/spUtil.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  void initState() {
    super.initState();
    print("FirstRoute: initState");
   }

  void linkActon() {
    print('打印机连接');
  }

  void printSetActon() async {
    print('打印配置');
    //Navigator.pushNamed(context, RoutesName.FAVORITES_MANAGEMENT_PAGE);
    final result =
        await Navigator.pushNamed(context, RoutesName.MINE_StENCIL_PAGE);
    print(result);
  }

  void changePWActon() {
    Navigator.pushNamed(context, RoutesName.MINE_CHANGEPW_PAGE);
  }

  void setActon() {
    print('设置');
  }

  void logoutActon() {
    SpUtil.preferences.setBool(StorageKeys.userNameKey, null);
    SpUtil.preferences.setBool(StorageKeys.loginKey, false);
    Navigator.pushNamedAndRemoveUntil(
        context, RoutesName.LOGIN_PAGE, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(alignment: Alignment.topCenter, children: <Widget>[
          Container(
            child: Image(
              fit: BoxFit.fitHeight,
              image: AssetImage(IconUtils.getIconPath('ic_mine_bg')),
              width: BaseSize.dp(375),
              height: BaseSize.dp(231),
            ),
          ),
          ListView(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 0),
            children: <Widget>[
              MineHead(
                  name: SpUtil.preferences.getString(StorageKeys.userNameKey),
                  job: '13554428565'),
              Container(
                child: ClipRRect(
                  child: DiscoverCell(
                    title: '打印机连接',
                    imageName: IconUtils.getIconPath('ic_mine_print'),
                    subTitle: '未连接',
                    tapAction: linkActon,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                decoration: BaseTextStyle.shadowBox,
              ),
              SizedBox(height: 24),
              Container(
                child: ClipRRect(
                  child: Column(
                    children: <Widget>[
                      DiscoverCell(
                        title: '打印配置',
                        imageName: IconUtils.getIconPath('ic_mine_stand'),
                        tapAction: printSetActon,
                      ),
                      Divider(
                          height: 1.0,
                          indent: 0.0,
                          color: BaseColor.colorFFEBEBEB), //分割线
                      DiscoverCell(
                        title: '修改密码',
                        imageName: IconUtils.getIconPath('ic_mine_pw'),
                        tapAction: changePWActon,
                      ),
                      Divider(
                          height: 1.0,
                          indent: 0.0,
                          color: BaseColor.colorFFEBEBEB),
                      DiscoverCell(
                        title: '设置',
                        imageName: IconUtils.getIconPath('ic_mine_set'),
                        tapAction: setActon,
                      ),
                      Divider(
                          height: 1.0,
                          indent: 0.0,
                          color: BaseColor.colorFFEBEBEB),
                      DiscoverCell(
                        title: '当前版本',
                        subTitle: '1.0.0',
                        imageName: IconUtils.getIconPath('ic_mine_version'),
                      ),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                decoration: BaseTextStyle.shadowBox,
              ),
              SizedBox(height: 24),
              Container(
                child: ClipRRect(
                  child: GestureDetector(
                    onTap: logoutActon,
                    child: Container(
                      height: 56,
                      alignment: Alignment.center,
                      color: Colors.white,
                      child: Text(
                        '退出登录',
                        style: TextStyle(
                            fontSize: 15, color: BaseColor.colorFF262626),
                      ),
                    ),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                decoration: BaseTextStyle.shadowBox,
              ),
            ],
          ),
        ]),
      ),
      backgroundColor: BaseColor.colorFFF5F5F5,
    );
  }
}
