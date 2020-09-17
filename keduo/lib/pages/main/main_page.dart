import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keduo/base/baseColor.dart';
import 'package:keduo/base/baseSize.dart';
import 'package:keduo/base/baseTextStyle.dart';
import 'package:keduo/base/httpRequest.dart';
import 'package:keduo/base/routes.dart';
import 'package:keduo/model/mainModel.dart';
import 'package:keduo/pages/main/view/adView.dart';
import 'package:keduo/pages/main/view/left_icon_button.dart';
import 'package:keduo/utils/icon_utils.dart';
import 'package:keduo/utils/toast.dart';

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  ImageProvider logo = AssetImage(IconUtils.getIconPath('ic_home_bg'));

  MainModel model = MainModel();
  void linkAction() {}

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (model.bannerLists == null) {
        requestList();
      }
    });
  }

  ///数据请求
  void requestList() {
    Toasts.showLoading(context, '请求数据...');
    HttpRequest().request(
      NetMethod.GET,
      NetUrls.homeUrl,
      params: {},
      success: (json) {
        Toasts.hideLoading(context);
        setState(() {
          model = MainModel.fromJson(json);
        });
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
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              child: Image(
                fit: BoxFit.fitHeight,
                image: logo,
                width: BaseSize.dp(375),
                height: BaseSize.dp(231),
              ),
            ),
            Container(
              height: BaseSize.dp(63),
              padding: EdgeInsets.only(
                  left: BaseSize.dp(15),
                  right: BaseSize.dp(15),
                  top: BaseSize.dp(36)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage(IconUtils.getIconPath('ic_logo')),
                    width: BaseSize.dp(105),
                    height: BaseSize.dp(14),
                  ),
                  LeftIconTextButton(
                    title: '未连接',
                    imageName: 'yijianjie',
                    sizeContent: Size(90, 40),
                    tapAction: linkAction,
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: BaseSize.dp(15),
                right: BaseSize.dp(15),
                top: BaseSize.dp(63),
              ),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    child: ClipRRect(
                      child: AdView(
                          imgList: model.bannerLists != null
                              ? model.bannerLists
                              : []),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(height: BaseSize.dp(10)),
                  getItemContainer(
                      '商品列表',
                      '商品方便查 一键去打印',
                      'ic_main_list',
                      () => Navigator.pushNamed(
                          context, RoutesName.GOODS_LIST_PAGE)),
                  SizedBox(height: BaseSize.dp(10)),
                  getItemContainer(
                      '统计分析',
                      '商品打印排行榜',
                      'ic_main_statistics',
                      () => Navigator.pushNamed(
                          context, RoutesName.GOODS_LIST_PAGE)),
                  SizedBox(height: BaseSize.dp(10)),
                  getTitleContainer(),
                  noData(),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: BaseColor.colorFFF5F5F5,
    );
  }
}

/// ****************常用服务item*************************
Widget getItemContainer(
    String title, String subTitle, String imageName, Function tapAction) {
  return InkWell(
      onTap: tapAction,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        height: BaseSize.dp(90),
        child: Card(
          shadowColor: Color.fromARGB(1, 138, 138, 138),
          child: new Row(
            children: [
              SizedBox(width: BaseSize.dp(12)),
              Image(
                fit: BoxFit.fitHeight,
                image: AssetImage(IconUtils.getIconPath(imageName)),
                width: BaseSize.dp(69),
                height: BaseSize.dp(46),
              ),
              SizedBox(width: BaseSize.dp(16)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title,
                      style: BaseTextStyle.style333333_16_bold,
                      textAlign: TextAlign.left),
                  Text(subTitle,
                      style: BaseTextStyle.style999999_13,
                      textAlign: TextAlign.left)
                ],
              ),
            ],
          ),
        ),
      ));
}

///*******************打印历史*****************************************
Widget getTitleContainer() {
  return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
          color: Colors.white,
        ),
        height: BaseSize.dp(50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            historyRich(),
            moreRich(),
          ],
        ),
      ));
}

Widget historyRich() {
  return Text.rich(
    TextSpan(
      children: <InlineSpan>[
        WidgetSpan(
          child: SizedBox(
            width: BaseSize.dp(14),
            height: BaseSize.dp(17),
            child: Text(' '),
          ),
        ),
        WidgetSpan(
          child: SizedBox(
            width: BaseSize.dp(15),
            height: BaseSize.dp(17),
            child: Image(
              image: AssetImage(
                IconUtils.getIconPath('ic_main_history'),
              ),
            ),
          ),
        ),
        TextSpan(text: ' 本月打印历史', style: BaseTextStyle.style333333_16_bold),
      ],
    ),
  );
}

Widget moreRich() {
  return Text.rich(
    TextSpan(
      children: <InlineSpan>[
        TextSpan(text: '更多 ', style: BaseTextStyle.styleFFFFD04F_14),
        WidgetSpan(
          child: SizedBox(
            width: BaseSize.dp(6),
            height: BaseSize.dp(17),
            child: Image(
              image: AssetImage(
                IconUtils.getIconPath('ic_main_next'),
              ),
            ),
          ),
        ),
        WidgetSpan(
          child: SizedBox(
            width: BaseSize.dp(14),
            height: BaseSize.dp(17),
            child: Text(' '),
          ),
        ),
      ],
    ),
  );
}

///**************************无数据********************

Widget noData() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
      color: Colors.white,
    ),
    height: BaseSize.dp(200),
    child: Align(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage(
              IconUtils.getIconPath('ic_main_no'),
            ),
            width: BaseSize.dp(82),
            height: BaseSize.dp(116),
          ),
          Text(
            '搜索不到相关结果',
            style: BaseTextStyle.style999999_14,
          )
        ],
      ),
    ),
  );
}

////ic_main_no.png
