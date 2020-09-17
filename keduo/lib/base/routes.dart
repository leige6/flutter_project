import 'package:flutter/material.dart';
import 'package:keduo/base/tabbarController.dart';
import 'package:keduo/pages/assistant/assistant_page.dart';
import 'package:keduo/pages/main/goods_detail_page.dart';
import 'package:keduo/pages/main/goods_list_page.dart';
import 'package:keduo/pages/main/goods_search_page.dart';
import 'package:keduo/pages/main/main_page.dart';
import 'package:keduo/pages/mine/login_page.dart';
import 'package:keduo/pages/mine/mine_changepw_page.dart';
import 'package:keduo/pages/mine/mine_page.dart';
import 'package:keduo/pages/mine/mine_stencil_page.dart';
import 'package:keduo/pages/mine/regist_page.dart';

class RoutesName {
  static const String ROOT_PAGE = '/tabbarController';
  static const String LOGIN_PAGE = '/login_page';
  static const String REGIST_PAGE = '/regist_page';
  static const String MAIN_PAGE = '/main_page';
  static const String ASSISTANT_PAGE = '/assistant_page';
  static const String MINE_PAGE = '/mine_page';
  static const String MINE_STORE_DETAIL_PAGE = '/mine_store_detail_page';
  static const String DEVICE_CONNECT_PAGE = '/device_connect';
  static const String DEVICE_SEARCH_PAGE = '/device_search';
  static const String MINE_STORE_EDIT_PAGE = '/mine_store_edit_page';
  static const String MINE_SET_PAGE = '/mine_set_page';
  static const String GOODS_EDIT_PAGE = '/goods_edit_page';
  static const String NORMAL_GOODS_EDIT_PAGE = '/normal_goods_edit_page';
  static const String GOODS_LIST_PAGE = '/goods_list_page';
  static const String NORMAL_GOODS_LIST_PAGE = '/normal_goods_list_page';
  static const String MINE_CHANGEPW_PAGE = '/mine_schangepw_page';
  static const String MINE_PROROCOL_PAGE = '/mine_protocol_page';
  static const String STORE_LIST_PAGE = '/store_list__page';
  static const String GOODS_SEARCH_PAGE = '/goods_search_page';
  static const String STORE_SEARCH_PAGE = '/store_search_page';
  static const String GOODS_DETAIL_PAGE = '/goods_detail_page';
  static const String FAVORITES_MANAGEMENT_PAGE = '/favorites_management_page';
  static const String MINE_HISTORY_PAGE = '/mine_history_page';
  static const String MINE_StENCIL_PAGE = '/mine_stencil_page';
  static const String DEVICE_CONNECT_IOS_PAGE = '/device_connect_ios_page';
}

// 配置路由表
final routes = {
  RoutesName.ROOT_PAGE: (context) => TabbarController(),
  RoutesName.LOGIN_PAGE: (context) => LoginPage(),
  RoutesName.REGIST_PAGE: (context) => RegistPage(),
  RoutesName.MAIN_PAGE: (context) => MainPage(),
  RoutesName.ASSISTANT_PAGE: (context) => AssistantPage(),
  RoutesName.MINE_PAGE: (context) => MinePage(),
  RoutesName.MINE_StENCIL_PAGE: (context) => MineStencilPage(),
  RoutesName.MINE_CHANGEPW_PAGE: (context) => MineChangePWPage(),
  RoutesName.GOODS_LIST_PAGE: (context) => GoodsListPage(),
  RoutesName.GOODS_SEARCH_PAGE: (context, {arguments}) => GoodsSearchPage(),
  RoutesName.GOODS_DETAIL_PAGE: (context, {arguments}) => GoodsDetailPage(
        goodModel: arguments,
      ),
  /*
  RoutesName.MINE_STORE_DETAIL_PAGE: (context, {arguments}) =>
      StoreDetailPage(parameter: arguments),
  RoutesName.DEVICE_CONNECT_PAGE: (context) => DeviceConnectPage(),
  RoutesName.DEVICE_SEARCH_PAGE: (context) => DeviceSearchPage(),
  RoutesName.MINE_STORE_EDIT_PAGE: (context, {arguments}) =>
      StoreEditPage(parameter: arguments),
  RoutesName.MINE_SET_PAGE: (context) => MineSetPage(),
  RoutesName.GOODS_LIST_PAGE: (context, {arguments}) =>
      TobaccoListPage(goodsPermission: arguments),
  RoutesName.NORMAL_GOODS_LIST_PAGE: (context, {arguments}) =>
      NormalGoodsListPage(goodsPermission: arguments),
  RoutesName.GOODS_EDIT_PAGE: (context, {arguments}) =>
      GoodsEditPage(title: arguments['title'], mode: arguments['mode']),
  RoutesName.NORMAL_GOODS_EDIT_PAGE: (context, {arguments}) =>
      NormalGoodsEditPage(title: arguments['title'], mode: arguments['mode']),
  
  RoutesName.MINE_PROROCOL_PAGE: (context, {arguments}) =>
      MineProtocolPage(title: arguments),
  RoutesName.STORE_LIST_PAGE: (context) => StoreListPage(),
  RoutesName.GOODS_SEARCH_PAGE: (context, {arguments}) => GoodsSearchPage(
      initText: arguments['init_text'] ?? '', hintText: arguments['hint_text']),
  RoutesName.STORE_SEARCH_PAGE: (context) => StoreSearchPage(),
  RoutesName.GOODS_DETAIL_PAGE: (context, {arguments}) =>
      GoodsDetailPage(isTobacco: arguments),
  RoutesName.FAVORITES_MANAGEMENT_PAGE: (context) => FavoritesManagementPage(),
  RoutesName.MINE_HISTORY_PAGE: (context) => MineHistoryPage(),
  
  RoutesName.DEVICE_CONNECT_IOS_PAGE: (context) => DeviceConnectIosPage(),*/
};

class UnknownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('跳转错误'),
        centerTitle: true,
      ),
    );
  }
}

// 路由拦截（固定写法）
Route onGenerateRoute(RouteSettings settings) {
  final String name = settings.name;
  final Function pageBuilder = routes[name];
  if (pageBuilder != null) {
    if (settings.arguments != null) {
      // 如果透传了参数
      return MaterialPageRoute(
          builder: (context) =>
              pageBuilder(context, arguments: settings.arguments));
    } else {
      // 没有透传参数
      return MaterialPageRoute(builder: (context) => pageBuilder(context));
    }
  }
  return MaterialPageRoute(builder: (context) => UnknownPage());
}
