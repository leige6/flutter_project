import 'package:flutter/material.dart';
import 'package:keduo/utils/icon_utils.dart';
import 'baseColor.dart';

class BaseAppBar extends StatefulWidget implements PreferredSizeWidget {
  final title;
  final List<Widget> actions;
  final Widget leading;
  final PreferredSizeWidget bottom;

  const BaseAppBar({
    Key key,
    this.bottom,
    this.title,
    this.actions,
    this.leading,
  }) : super(key: key);

  @override
  _BaseAppBarState createState() => _BaseAppBarState();

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0));
}

class _BaseAppBarState extends State<BaseAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        brightness: Brightness.light,
        leading: widget.leading != null
            ? IconButton(
                icon: Image.asset(IconUtils.getIconPath('fanhui')),
                onPressed: () => Navigator.pop(context))
            : null,
        title: Text(widget.title,
            style: TextStyle(color: BaseColor.colorFF262626, fontSize: 18)),
        backgroundColor: Colors.white,
        actions: widget.actions);
  }
}
