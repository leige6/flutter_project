import 'package:flutter/material.dart';
import 'package:keduo/base/baseColor.dart';
import 'package:keduo/utils/icon_utils.dart';

class DiscoverCell extends StatelessWidget {
  final String title;
  final String subTitle;
  final String imageName;
  final String subImageName;
  final Function tapAction;

  const DiscoverCell({
    Key key,
    @required this.title,
    this.subTitle,
    @required this.imageName,
    this.subImageName,
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
        padding: EdgeInsets.only(left: 12, top: 14, right: 12, bottom: 14),
        color: Colors.white,
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Image(
                    image: AssetImage(imageName), //添加安全判断
                  ),
                  Container(
                    child: Text(
                      title,
                      style: TextStyle(
                          fontSize: 15, color: BaseColor.colorFF262626),
                    ),
                    margin: EdgeInsets.only(left: 11),
                  ),
                ],
              ),
            ), //left
            Container(
              child: Row(
                children: <Widget>[
                  Text(
                    subTitle != null ? subTitle : '',
                    style:
                        TextStyle(fontSize: 15, color: BaseColor.colorFF999999),
                  ), //子标题
                  SizedBox(
                    width: 8,
                  ),
                  subImageName != null
                      ? Image(
                          image: AssetImage(subImageName),
                        )
                      : Container(), //子图标
                  Image(
                    image: AssetImage(IconUtils.getIconPath('ic_mine_next')),
                    height: 13,
                  )
                ],
              ),
            ), //right
          ],
        ),
      ),
    );
  }
}
