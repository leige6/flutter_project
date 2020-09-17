import 'package:flutter/material.dart';
import 'package:keduo/base/baseColor.dart';
import 'package:keduo/base/baseSize.dart';
import 'package:keduo/utils/icon_utils.dart';

class ImageButtonWidget extends StatelessWidget {
  final String imageName;
  final String title;
  final Color textColor;
  final TextStyle textStyle;
  final Size sizeContent;
  final MainAxisAlignment mainAxisAlignment;
  final Function tapAction;

  const ImageButtonWidget({
    Key key,
    @required this.imageName,
    @required this.title,
    this.textColor = BaseColor.colorFFF5F5F5,
    @required this.textStyle,
    @required this.sizeContent,
    @required this.mainAxisAlignment,
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
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(IconUtils.getIconPath(imageName)),
            SizedBox(width: BaseSize.dp(6)),
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
