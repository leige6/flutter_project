import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keduo/base/baseSize.dart';
import 'package:keduo/base/baseTextStyle.dart';
import 'package:keduo/utils/icon_utils.dart';

class BaseNoNetwork extends StatelessWidget {
  final String name;
  final String imageName;
  final Function tapAction;

  const BaseNoNetwork(
      {Key key,
      this.name = '网络不太给力',
      this.imageName = 'ic_nonetwork',
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
