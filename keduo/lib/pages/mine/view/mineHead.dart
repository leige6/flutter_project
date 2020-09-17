import 'package:flutter/material.dart';
import 'package:keduo/base/baseColor.dart';
import 'package:keduo/base/baseSize.dart';
import 'package:keduo/utils/icon_utils.dart';

class MineHead extends StatelessWidget {
  final String name;
  final String job;
  final String imageName;
  final Function tapAction;

  const MineHead(
      {Key key,
      @required this.name,
      this.imageName,
      @required this.job,
      this.tapAction})
      : assert(name != null, 'name不能为空'),
        assert(job != null, 'job不能为空');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (this.tapAction != null) {
          this.tapAction();
        }
      },
      child: Container(
          height: BaseSize.dp(126),
          padding: EdgeInsets.only(left: BaseSize.dp(16)),
          child: Row(
            children: <Widget>[
              Align(
                child: Image.asset(
                  IconUtils.getIconPath('ic_user'),
                  height: 50,
                ),
                alignment: Alignment.center,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 10, left: 14),
                    child: Text(
                      name,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: BaseColor.colorFFFFFFFF,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          job,
                          style: TextStyle(
                            color: BaseColor.colorFFFFA7A4,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
