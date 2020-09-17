import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keduo/base/baseSize.dart';
import 'package:keduo/base/baseTextStyle.dart';
import 'package:keduo/utils/icon_utils.dart';

class BaseNoData extends StatelessWidget {
  final String name;
  final String imageName;
  final Function tapAction;

  const BaseNoData(
      {Key key,
      this.name = '暂无相关数据',
      this.imageName = 'ic_main_no',
      this.tapAction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (this.tapAction != null) {
          this.tapAction();
        }
      },
      child: Container(
        color: Colors.white,
        child: Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage(
                  IconUtils.getIconPath(imageName),
                ),
                width: BaseSize.dp(82),
                height: BaseSize.dp(116),
              ),
              Text(
                name,
                style: BaseTextStyle.style999999_14,
              )
            ],
          ),
        ),
      ),
    );
  }
}
