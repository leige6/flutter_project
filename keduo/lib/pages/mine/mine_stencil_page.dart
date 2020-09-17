import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keduo/base/baseColor.dart';
import 'package:keduo/base/baseSize.dart';
import 'package:keduo/base/baseTextStyle.dart';
import 'package:keduo/base/httpRequest.dart';
import 'package:keduo/model/templateModel.dart';
import 'package:keduo/utils/icon_utils.dart';
import 'package:keduo/utils/toast.dart';

///参考 https://www.imooc.com/article/300411
class MineStencilPage extends StatefulWidget {
  @override
  MineStencilPageState createState() => MineStencilPageState();
}

//使用with SingleTickerProviderStateMixin 防止页面被回收
class MineStencilPageState extends State<MineStencilPage>
    with SingleTickerProviderStateMixin {
  ///数据模型
  TemplateModel model = TemplateModel();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestListData();
    });
  }

  ///请求模版列表
  void requestListData() {
    Toasts.showLoading(context, '请求数据...');
    HttpRequest().request(
      NetMethod.GET,
      NetUrls.templatelistUrl,
      params: {"page": '1', "limit": '30'},
      success: (json) {
        Toasts.hideLoading(context);
        setState(() {
          model = TemplateModel.fromJson(json);
        });
      },
      error: (error) {
        Toasts.hideLoading(context);
        Toasts.showText(error.message);
      },
    );
  }

  ///设置默认模版
  void requestDefault(int templateID) {
    Toasts.showLoading(context, '请求数据...');
    HttpRequest().request(
      NetMethod.POST,
      NetUrls.templateSetDefaultUrl,
      params: {"store_template_id": templateID},
      success: (json) {
        Toasts.hideLoading(context);
        requestListData();
      },
      error: (error) {
        Toasts.hideLoading(context);
        Toasts.showText(error.message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        leading: IconButton(
            icon: Image.asset(IconUtils.getIconPath('fanhui')),
            onPressed: () => Navigator.pop(context, '从新页面返回数据给上一个页面')),
        title: Text(
          '打印配置',
          style: TextStyle(color: BaseColor.colorFF262626, fontSize: 18),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: model.lists == null
            ? Text(" ")
            : ListView.separated(
                itemBuilder: (context, i) {
                  return InkWell(
                    child: _cellEdit(model.lists[i]),
                    onTap: () {
                      setState(() {
                        Lists listsModel = model.lists[i];
                        requestDefault(listsModel.storeTemplateId);
                      });
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(height: 24),
                itemCount: model.lists.length),
        padding: EdgeInsets.only(
            left: BaseSize.sp(16),
            right: BaseSize.sp(16),
            top: BaseSize.sp(16),
            bottom: BaseSize.sp(16)),
      ),
      backgroundColor: BaseColor.colorFFF5F5F5,
    );
  }

  _cellEdit(Lists listsModel) => Container(
        height: 242,
        decoration: listsModel.isDefault == 1
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: BaseColor.colorFF03B798,
              )
            : null,
        child: Card(
          elevation: 5.0, //设置阴影
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))), //设置圆角
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: BaseColor.colorFFFAFAFA,
                ),
                height: 186,
                child: Align(
                  child: Image.network(listsModel.templateImg,
                      fit: BoxFit.fitHeight),
                  alignment: Alignment.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: BaseSize.dp(16),
                  top: BaseSize.dp(17),
                ),
                child: Text(
                  listsModel.templateName,
                  style: BaseTextStyle.style595959_14,
                ),
              ),
            ],
          ),
        ),
      );
}
