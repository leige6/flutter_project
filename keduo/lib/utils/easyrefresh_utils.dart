import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class EasyrefreshUtils {
  static ClassicalHeader getHeader(_headerKey) {
    return ClassicalHeader(
      key: _headerKey,
      enableInfiniteRefresh: false,
      float: false, //顶部浮动
      refreshText: "下拉刷新",
      refreshingText: "正在刷新...",
      refreshedText: "刷新完毕",
      refreshReadyText: "松手开始刷新",
      showInfo: false,
      infoColor: Colors.black87,
      noMoreText: "暂无数据",
    );
  }

  static ClassicalFooter getFooter(_footerKey) {
    return ClassicalFooter(
      key: _footerKey,
      enableInfiniteLoad: false, //无限加载
      enableHapticFeedback: true, //震动
      loadText: "上拉加载更多",
      loadReadyText: "松开开始加载",
      loadingText: "正在加载更多...",
      loadedText: "加载完成",
      loadFailedText: "加载失败",
      showInfo: false,
      infoColor: Colors.black87,
      noMoreText: "没有更多数据",
    );
  }
}
