import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:keduo/base/baseColor.dart';
//import 'package:keduo/base/baseNoData.dart';
import 'package:keduo/base/baseSize.dart';
import 'package:keduo/base/baseTextStyle.dart';
import 'package:keduo/base/httpRequest.dart';
import 'package:keduo/model/goodsModel.dart';
import 'package:keduo/pages/main/view/left_icon_button.dart';
import 'package:keduo/utils/easyrefresh_utils.dart';
import 'package:keduo/utils/icon_utils.dart';
import 'package:keduo/utils/toast.dart';
import 'package:keduo/widgets/imageButtonWidget.dart';
import 'package:keduo/widgets/searchBarWidget.dart';
import 'package:provider/provider.dart';

class GoodsSearchPage extends StatefulWidget {
  @override
  GoodsSearchPageState createState() => GoodsSearchPageState();
}

class GoodsSearchPageState extends State<GoodsSearchPage>
    with WidgetsBindingObserver {
  ///原始数据
  GoodsModel model = GoodsModel();

  ///数组
  List<Lists> dataSource = List();

  ///分页 默认为1
  int page = 1;

  ///搜索关键字
  String keyword = '';

  /// 刷新控件
  EasyRefreshController _controller;

  ///没有更多数据
  bool noMore = false;

  ///是否全选
  bool sellectAll = false;

  ///键盘是否显示
  bool showKeyboard = false;

  ///方法
  void linkAction() {}

  ///全选
  void selectAllAction() {
    setState(() {
      sellectAll = !sellectAll;
      dataSource.forEach((item) {
        if (sellectAll) {
          item.select = true;
        } else {
          item.select = false;
        }
      });
    });
  }

  GlobalKey _headerKey = GlobalKey();
  GlobalKey _footerKey = GlobalKey();
  GlobalKey _key = new GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller = EasyRefreshController();
      //初始化键盘监听方法
      WidgetsBinding.instance.addObserver(this);
    });
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (MediaQuery.of(context).viewInsets.bottom == 0) {
          //关闭键盘
          showKeyboard = false;
        } else {
          showKeyboard = true;
          //显示键盘
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    //销毁键盘监听
    WidgetsBinding.instance.removeObserver(this);
  }

  ///数据请求 onRefresh YES 下拉刷新 NO 下拉加载更多
  void requestList(bool onRefresh) {
    Toasts.showLoading(context, '请求数据...');
    HttpRequest().request(
      NetMethod.GET,
      NetUrls.goodsListUrl,
      params: {
        'page': page.toString(),
        'limit': '300',
        'keywords': keyword,
      },
      success: (json) {
        Toasts.hideLoading(context);
        model = GoodsModel.fromJson(json);
        setState(() {
          if (onRefresh) {
            sellectAll = false;
            dataSource.clear();
            _controller.finishRefresh(success: true);
          }
          dataSource.addAll(model.lists);
          if (!onRefresh) {
            _controller.finishLoad(success: true);
          }
          if (dataSource.length == model.total) {
            noMore = true;
          } else {
            noMore = false;
          }
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
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        leading: IconButton(
            icon: Image.asset(IconUtils.getIconPath('fanhui')),
            onPressed: () => Navigator.pop(context)),
        title: SearchBarWidget(
          onchangeValue: (value) {
            keyword = value;
            print(value);
          },
          onEditingComplete: () {
            print('编辑结束');
            requestList(true);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: <Widget>[
          dataSource.length > 0
              ? Positioned(
                  top: 11,
                  left: 16,
                  child: LeftIconTextButton(
                    mainAxisAlignment: MainAxisAlignment.start,
                    textColor: Colors.black,
                    title: '全选',
                    imageName: sellectAll
                        ? 'ic_history_select'
                        : 'ic_history_unselect',
                    sizeContent: Size(90, 40),
                    tapAction: selectAllAction,
                  ),
                )
              : Text(''),
          Container(
            height: double.maxFinite,
            padding: EdgeInsets.only(
                left: BaseSize.dp(16),
                right: BaseSize.dp(16),
                top: BaseSize.dp(56)),
            child: EasyRefresh(
              controller: _controller,
              enableControlFinishLoad: false,
              enableControlFinishRefresh: false,
              child: ListView.separated(
                itemBuilder: (context, i) {
                  if (noMore) {
                    if (i == dataSource.length) {
                      return Align(
                        child: Text('没有更多数据'),
                      );
                    } else {
                      return goodsCell(dataSource[i], (model) {});
                    }
                  } else {
                    return goodsCell(dataSource[i], (model) {});
                  }
                },
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(height: 15),
                itemCount: noMore ? dataSource.length + 1 : dataSource.length,
              ),
              header: EasyrefreshUtils.getHeader(_headerKey),
              footer: EasyrefreshUtils.getFooter(_footerKey),
              key: _key,
              onRefresh: () async {
                print('下啦刷新');
                page = 1;
                requestList(true);
              },
              onLoad: !noMore
                  ? () async {
                      print('上啦刷新');
                      if (!noMore) {
                        ++page;
                        requestList(false);
                      }
                    }
                  : null,
            ),
          ),
          !showKeyboard ? bottomTool() : Text(''),
        ],
      ),
      backgroundColor: BaseColor.colorFFF5F5F5,
    );
  }

  Widget bottomTool() {
    return Container(
      height: BaseSize.dp(120),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(5.0, 5.0),
                  blurRadius: 10.0,
                  spreadRadius: 2.0),
            ],
          ),
          height: BaseSize.dp(44),
          width: BaseSize.dp(300),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                elevation: 0,
                highlightElevation: 0,
                color: Colors.white,
                splashColor: Colors.white,
                highlightColor: Colors.white,
                disabledTextColor: BaseColor.colorFFDCDCDC,
                disabledColor: Colors.white,
                onPressed: dataSource.length == 0
                    ? null
                    : () {
                        print('预览');
                      },
                child: Text('打印预览'),
              ),
              RaisedButton(
                elevation: 0,
                highlightElevation: 0,
                color: Colors.white,
                splashColor: Colors.white,
                highlightColor: Colors.white,
                disabledTextColor: BaseColor.colorFFDCDCDC,
                disabledColor: Colors.white,
                onPressed: null,
                child: Text('批量打印'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget goodsCell(Lists baseModel, Function(Lists value) selectAction) {
  return ChangeNotifierProvider<Lists>.value(
    value: baseModel,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  width: BaseSize.dp(200),
                  padding: EdgeInsets.only(
                      left: BaseSize.dp(12), top: BaseSize.dp(10)),
                  child: Consumer<Lists>(
                    builder: (context, model, child) => ImageButtonWidget(
                      imageName: model.select
                          ? 'ic_history_select'
                          : 'ic_history_unselect',
                      title: baseModel.goodsName,
                      textStyle: BaseTextStyle.style333333_16_bold,
                      sizeContent: Size(BaseSize.dp(220), BaseSize.dp(20)),
                      mainAxisAlignment: MainAxisAlignment.start,
                      tapAction: () {
                        baseModel.setSelect(!baseModel.select);
                      },
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    right: BaseSize.dp(12), top: BaseSize.dp(12)),
                child: Text('¥${baseModel.shopPrice}/瓶',
                    style: BaseTextStyle.style333333_16_bold),
              ),
            ],
          ),
          Container(
            padding:
                EdgeInsets.only(left: BaseSize.dp(12), top: BaseSize.dp(4)),
            child: Text('编码：' + baseModel.goodsBarCode,
                style: BaseTextStyle.style999999_12),
          ),
          Container(
            padding: EdgeInsets.only(
                left: BaseSize.dp(12),
                top: BaseSize.dp(1),
                bottom: BaseSize.dp(11)),
            child: Text('条码：' + baseModel.goodsCode,
                style: BaseTextStyle.style999999_12),
          ),
          Divider(height: 1.0, indent: 0.0, color: BaseColor.colorFFEBEBEB),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              imageBtn('加入待打印', 'ic_item_store'),
              imageBtn('打印标签', 'ic_item_print')
            ],
          ),
        ],
      ),
    ),
  );
}

Widget imageBtn(
  String title,
  String imageName,
) {
  return Container(
    height: BaseSize.dp(47),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image(
          image: AssetImage(IconUtils.getIconPath(imageName)),
          width: BaseSize.dp(25),
        ),
        Text(
          title,
          style: TextStyle(
              color: BaseColor.colorFFFF853A, fontSize: BaseSize.sp(12)),
        )
      ],
    ),
  );
}
