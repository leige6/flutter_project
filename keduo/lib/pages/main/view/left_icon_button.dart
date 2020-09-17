import 'package:flutter/material.dart';
import 'package:keduo/base/baseColor.dart';
import 'package:keduo/base/baseSize.dart';
import 'package:keduo/utils/icon_utils.dart';

class LeftIconTextButton extends StatelessWidget {
  final String imageName;
  final String title;
  final Size sizeContent;
  final Function tapAction;
  final Color textColor;
  final MainAxisAlignment mainAxisAlignment;

  const LeftIconTextButton({
    Key key,
    @required this.title,
    @required this.imageName,
    @required this.sizeContent,
    this.textColor,
    this.mainAxisAlignment,
    this.tapAction,
  })  : assert(title != null, 'title不能为空'),
        assert(imageName != null, 'imageName不能为空');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (this.tapAction != null) {
            this.tapAction();
          }
        },
        child: Container(
          width: sizeContent.width,
          height: sizeContent.height,
          child: Row(
            mainAxisAlignment: mainAxisAlignment == null
                ? MainAxisAlignment.end
                : mainAxisAlignment,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(IconUtils.getIconPath(imageName)),
              SizedBox(width: BaseSize.dp(6)),
              Text(
                title,
                style: TextStyle(
                    color:
                        textColor != null ? textColor : BaseColor.colorFFF5F5F5,
                    fontSize: 16),
              )
            ],
          ),
        ));
  }
}
