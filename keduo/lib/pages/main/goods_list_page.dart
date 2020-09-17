import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keduo/base/baseColor.dart';
import 'package:keduo/base/baseNoData.dart';
import 'package:keduo/base/baseNoNetwork.dart';
import 'package:keduo/base/baseSize.dart';
import 'package:keduo/base/baseTextStyle.dart';
import 'package:keduo/base/httpRequest.dart';
import 'package:keduo/base/routes.dart';
import 'package:keduo/model/goodsModel.dart';
import 'package:keduo/utils/icon_utils.dart';
import 'package:keduo/utils/toast.dart';

class GoodsListPage extends StatefulWidget {
  @override
  GoodsListPageState createState() => GoodsListPageState();
}

class GoodsListPageState extends State<GoodsListPage> {
  ///数据源
  GoodsModel model = GoodsModel();
  List<Lists> dataSource = List();

  ///分页 默认为1
  int page = 1;

  ///1:监听滚动实现上啦加载更多
  ScrollController _scrollController = ScrollController();

  ///监听是否在请求中
  bool isPerformingRequest = false;

  ///没有数据
  bool isNoDate = false;

  ///没有更多数据
  bool isNoMoreDate = false;

  ///网络错误
  bool isNoNetWork = false;

  void linkAction() {}

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestList();
    });

    ///3:开始监听
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 20) {
        print('滑动到了最底部');
        getMoreData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();

    ///4:销毁监听
  }

  ///数据请求
  void requestList() {
    Toasts.showLoading(context, '请求数据...');
    HttpRequest().request(
      NetMethod.GET,
      NetUrls.goodsListUrl,
      params: {
        'page': page.toString(),
        'limit': '30',
        'keywords': '',
      },
      success: (json) {
        Toasts.hideLoading(context);
        setState(() {
          isPerformingRequest = false;
          model = GoodsModel.fromJson(json);
          dataSource.addAll(model.lists);
          if (dataSource.length == 0) {
            isNoDate = true;
          } else {
            isNoDate = false;
          }
          if (dataSource.length != 0 && model.lists.length < 30) {
            isNoMoreDate = true;
          } else {
            isNoMoreDate = false;
          }
        });
      },
      error: (error) {
        isPerformingRequest = false;
        Toasts.hideLoading(context);
        Toasts.showText(error.message);
        if (dataSource.length == 0) {
          setState(() {
            isNoNetWork = true;
          });
        }
      },
    );
  }

  ///下拉刷新
  Future<Null> onRefresh() async {
    page = 1;
    requestList();
    return;
  }

  ///上拉加载更多
  Future<Null> getMoreData() async {
    if (!isPerformingRequest) {
      isPerformingRequest = true;
      ++page;
      requestList();
    }
    return;
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
        actions: <Widget>[
          IconButton(
              icon: Image.asset(IconUtils.getIconPath('ic_edit_search')),
              onPressed: () =>
                  Navigator.pushNamed(context, RoutesName.GOODS_SEARCH_PAGE))
        ],
        title: Text(
          '商品列表',
          style: TextStyle(color: BaseColor.colorFF262626, fontSize: 18),
        ),
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: Container(
          padding: isNoDate == true || isNoNetWork == true
              ? null
              : EdgeInsets.all(BaseSize.dp(16)),
          child: dataSource.length == 0
              ? isNoDate == false
                  ? isNoNetWork == false ? Text("") : BaseNoNetwork()
                  : BaseNoData()
              : ListView.separated(
                  itemBuilder: (context, i) {
                    return goodsCell(context, dataSource[i], linkAction);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(height: 15),
                  itemCount: dataSource.length,
                  controller: _scrollController, //2:绑定关系
                ),
        ),
      ),
      backgroundColor: BaseColor.colorFFF5F5F5,
    );
  }
}

Widget goodsCell(BuildContext context, Lists model, Function linkAction) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, RoutesName.GOODS_DETAIL_PAGE,
          arguments: model);
    },
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
              Container(
                width: BaseSize.dp(200),
                padding: EdgeInsets.only(
                    left: BaseSize.dp(12), top: BaseSize.dp(12)),
                child: Text(
                  model.goodsName,
                  style: BaseTextStyle.style333333_16_bold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    right: BaseSize.dp(12), top: BaseSize.dp(12)),
                child: Text('¥${model.shopPrice}/瓶',
                    style: BaseTextStyle.style333333_16_bold),
              ),
            ],
          ),
          Container(
            padding:
                EdgeInsets.only(left: BaseSize.dp(12), top: BaseSize.dp(4)),
            child: Text('编码：' + model.goodsBarCode,
                style: BaseTextStyle.style999999_12),
          ),
          Container(
            padding: EdgeInsets.only(
                left: BaseSize.dp(12),
                top: BaseSize.dp(1),
                bottom: BaseSize.dp(11)),
            child: Text('条码：' + model.goodsCode,
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
  return InkWell(
    onTap: () {
      print('哈哈哈');
    },
    child: Container(
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
    ),
  );
}
