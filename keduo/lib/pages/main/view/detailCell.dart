import 'package:flutter/material.dart';
import 'package:keduo/base/baseColor.dart';
import 'package:keduo/base/baseSize.dart';
import 'package:keduo/base/baseTextStyle.dart';

class DetailCell extends StatelessWidget {
  final String title;
  final String content;

  const DetailCell({
    this.title,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: BaseSize.dp(50),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: BaseSize.dp(96),
                padding: EdgeInsets.only(
                    left: BaseSize.dp(12), top: BaseSize.dp(15)),
                child: Text(
                  title,
                  style: BaseTextStyle.style999999_14,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: BaseSize.dp(15)),
                  child: Text(
                    content,
                    maxLines: 1,
                    style: BaseTextStyle.style333333_14,
                  ),
                ),
              )
            ],
          ),
          Divider(height: 1.0, indent: 0.0, color: BaseColor.colorFFEBEBEB),
        ],
      ),
    );
  }
}
