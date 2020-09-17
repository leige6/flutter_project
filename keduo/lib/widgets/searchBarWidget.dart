import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:keduo/base/baseSize.dart';
import 'package:keduo/utils/icon_utils.dart';

class SearchBarWidget extends StatefulWidget {
  final ValueChanged<String> onchangeValue;
  final VoidCallback onEditingComplete;
  const SearchBarWidget({this.onchangeValue, this.onEditingComplete, Key key})
      : super(key: key);

  @override
  SearchBarWidgetState createState() => SearchBarWidgetState();
}

class SearchBarWidgetState extends State<SearchBarWidget> {
  ///编辑控制器
  TextEditingController _controller;

  ///是否显示删除按钮
  bool _hasDeleteIcon = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  Widget buildTextField() {
    //theme设置局部主题
    return TextField(
      controller: _controller,
      textInputAction: TextInputAction.search,
      keyboardType: TextInputType.text,
      maxLines: 1,
      decoration: InputDecoration(
        //输入框decoration属性
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 1.0),
        //设置搜索图片
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 0.0),
          child: ImageIcon(
            AssetImage(
              IconUtils.getIconPath('ic_edit_search'),
            ),
            color: Colors.black26,
          ),
        ),
        prefixIconConstraints: BoxConstraints(
          //设置搜索图片左对齐
          minWidth: 30,
          minHeight: 25,
        ),
        border: InputBorder.none, //无边框
        hintText: " 请输入商品名",
        hintStyle: new TextStyle(fontSize: BaseSize.sp(14), color: Colors.grey),
        //设置清除按钮
        suffixIcon: Container(
          padding: EdgeInsetsDirectional.only(
            start: 2.0,
            end: _hasDeleteIcon ? 0.0 : 0,
          ),
          child: _hasDeleteIcon
              ? new InkWell(
                  onTap: (() {
                    setState(() {
                      /// 保证在组件build的第一帧时才去触发取消清空内容
                      WidgetsBinding.instance
                          .addPostFrameCallback((_) => _controller.clear());
                      _hasDeleteIcon = false;
                      widget.onchangeValue('');
                    });
                  }),
                  child: Icon(
                    Icons.cancel,
                    size: 18.0,
                    color: Colors.grey,
                  ),
                )
              : new Text(''),
        ),
      ),
      onChanged: (value) {
        setState(() {
          if (value.isEmpty) {
            _hasDeleteIcon = false;
          } else {
            _hasDeleteIcon = true;
          }
          widget.onchangeValue(_controller.text);
        });
      },
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(FocusNode());
        widget.onEditingComplete();
      },
      style: new TextStyle(fontSize: 14, color: Colors.black),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //背景与圆角
      decoration: new BoxDecoration(
        border: Border.all(color: Colors.black12, width: 1.0), //边框
        color: Colors.black12,
        borderRadius:
            new BorderRadius.all(new Radius.circular(BaseSize.dp(18))),
      ),
      alignment: Alignment.center,
      height: BaseSize.dp(36),
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
      child: buildTextField(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
