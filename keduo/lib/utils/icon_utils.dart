import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///import 'package:flutter_svg/svg.dart';

class IconUtils {
  static ImageProvider getAssetImage(String name, {String format: 'png'}) {
    return AssetImage(getImgPath(name, format: format));
  }

  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static ImageProvider getAssetIcon(String name, {String format: 'png'}) {
    return AssetImage(getIconPath(name, format: format));
  }

  static String getIconPath(String name, {String format: 'png'}) {
    return 'assets/images/icons/$name.$format';
  }

  // static Widget getIconSvg(String name){
  //   return SvgPicture.asset(
  //     getSvgPath(name),
  //   );
  // }

  static String getSvgPath(String name, {String format: 'svg'}) {
    return 'assets/images/$name.$format';
  }
}
