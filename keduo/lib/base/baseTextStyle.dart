import 'package:flutter/cupertino.dart';
import 'package:keduo/base/baseColor.dart';
import 'package:keduo/base/baseSize.dart';

/// @desp: 格式 颜色_字号
/// @time 2019/3/13 4:44 PM
/// @author chenyun
///
///Text widget 隶属于Material 风格下的组件，如果根节点不是Material 相关组件，则会使用默认带黄色下划线的格式。
///如果根节点是Material 容器组件，则会采用其Material风格的样式（即不带有黄色下划线）。

class BaseTextStyle {
  ///白色相关字号
  static final TextStyle styleFFFFFF_18 = TextStyle(
    decoration: TextDecoration.none,
    color: BaseColor.colorFFFFFFFF,
    fontSize: BaseSize.sp(18),
  );

  static final TextStyle styleFFFFFF_16 = TextStyle(
    decoration: TextDecoration.none,
    color: BaseColor.colorFFFFFFFF,
    fontSize: BaseSize.sp(16),
  );

  static final TextStyle styleFFFFFF_14 = TextStyle(
    decoration: TextDecoration.none,
    color: BaseColor.colorFFFFFFFF,
    fontSize: BaseSize.sp(14),
  );

  ///灰色相关字号
  static final TextStyle style999999_12 = TextStyle(
    decoration: TextDecoration.none,
    color: BaseColor.colorFF999999,
    fontSize: BaseSize.sp(12),
  );

  static final TextStyle style999999_13 = TextStyle(
    decoration: TextDecoration.none,
    color: BaseColor.colorFF999999,
    fontSize: BaseSize.sp(13),
  );

  static final TextStyle style999999_14 = TextStyle(
    decoration: TextDecoration.none,
    color: BaseColor.colorFF999999,
    fontSize: BaseSize.sp(14),
  );

  static final TextStyle style999999_15 = TextStyle(
    decoration: TextDecoration.none,
    color: BaseColor.colorFF999999,
    fontSize: BaseSize.sp(15),
  );

  static final TextStyle style262626_14 = TextStyle(
    decoration: TextDecoration.none,
    color: BaseColor.colorFF262626,
    fontSize: BaseSize.sp(14),
  );

  // ignore: non_constant_identifier_names
  static final TextStyle style262626_15_bold = TextStyle(
    decoration: TextDecoration.none,
    color: BaseColor.colorFF262626,
    fontSize: BaseSize.sp(15),
    fontWeight: FontWeight.bold,
  );

  static final TextStyle style262626_15 = TextStyle(
    decoration: TextDecoration.none,
    color: BaseColor.colorFF262626,
    fontSize: BaseSize.sp(15),
  );

  static final TextStyle style404040_16 = TextStyle(
    decoration: TextDecoration.none,
    color: BaseColor.colorFF404040,
    fontSize: BaseSize.sp(16),
  );

  static final TextStyle style000000_16 = TextStyle(
    decoration: TextDecoration.none,
    color: BaseColor.colorFF000000,
    fontSize: BaseSize.sp(16),
  );

  static final TextStyle styleD9D9D9_14 = TextStyle(
    decoration: TextDecoration.none,
    color: BaseColor.colorFFD9D9D9,
    fontSize: BaseSize.sp(14),
  );

  static final TextStyle styleDCDCDC_15 = TextStyle(
    decoration: TextDecoration.none,
    color: BaseColor.colorFFDCDCDC,
    fontSize: BaseSize.sp(14),
  );

  static final TextStyle style595959_16 = TextStyle(
    decoration: TextDecoration.none,
    color: BaseColor.colorFF595959,
    fontSize: BaseSize.sp(16),
  );

  static final TextStyle style595959_14 = TextStyle(
    decoration: TextDecoration.none,
    color: BaseColor.colorFF595959,
    fontSize: BaseSize.sp(14),
  );

  static final TextStyle style333333_14 = TextStyle(
    decoration: TextDecoration.none,
    color: BaseColor.colorFF333333,
    fontSize: BaseSize.sp(14),
  );

  static final TextStyle style333333_15 = TextStyle(
    decoration: TextDecoration.none,
    color: BaseColor.colorFF333333,
    fontSize: BaseSize.sp(15),
  );

  static final TextStyle styleFFFFD04F_14 = TextStyle(
    decoration: TextDecoration.none,
    color: BaseColor.colorFFFFD04F,
    fontSize: BaseSize.sp(14),
  );

  static final TextStyle styleFFFF853A_12 = TextStyle(
    decoration: TextDecoration.none,
    color: BaseColor.colorFFFF853A,
    fontSize: BaseSize.sp(12),
  );

  // ignore: non_constant_identifier_names
  static final TextStyle style333333_16_bold = TextStyle(
    decoration: TextDecoration.none,
    color: BaseColor.colorFF333333,
    fontSize: BaseSize.sp(16),
    fontWeight: FontWeight.bold,
  );

  ///带阴影圆角
  static final BoxDecoration shadowBox = BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    boxShadow: [
      BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.05), //阴影颜色
        blurRadius: 25.0, //阴影范围
        spreadRadius: 8.0, //阴影浓度
      )
    ],
  );
}
