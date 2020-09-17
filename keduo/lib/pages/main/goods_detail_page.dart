import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:keduo/base/baseColor.dart';
import 'package:keduo/model/goodsModel.dart';
import 'package:keduo/pages/main/view/detailCell.dart';
import 'package:keduo/utils/icon_utils.dart';

class GoodsDetailPage extends StatefulWidget {
  final Lists goodModel;
  GoodsDetailPage({this.goodModel});

  @override
  GoodsDetailPageState createState() => GoodsDetailPageState();
}

class GoodsDetailPageState extends State<GoodsDetailPage> {
  Map<String, List> elementsTitle = {
    '商品信息': ['商品编码', '商品条码', '商品名称', '类别名称', '计量单位'],
    '规格信息': ['规格数量', '包装规格', '规格说明'],
    '其它信息': ['品牌', '等级', '促销时间'],
  };

  Map<String, List> elementsContent;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        elementsContent = {
          '商品信息': [
            widget.goodModel.goodsCode,
            widget.goodModel.goodsBarCode,
            widget.goodModel.goodsName,
            widget.goodModel.categoryName,
            widget.goodModel.goodsUnit
          ],
          '规格信息': [
            widget.goodModel.attr[0].attrValue,
            widget.goodModel.attr[1].attrValue,
            widget.goodModel.attr[2].attrValue,
          ],
          '其它信息': [
            widget.goodModel.brand,
            widget.goodModel.grade,
            widget.goodModel.promoteStartDate
          ],
        };
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        leading: IconButton(
            icon: Image.asset(IconUtils.getIconPath('fanhui')),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          '商品详情',
          style: TextStyle(color: BaseColor.colorFF262626, fontSize: 18),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: GroupListView(
          sectionsCount: elementsTitle.keys.toList().length,
          countOfItemInSection: (int section) {
            return elementsTitle.values.toList()[section].length;
          },
          groupHeaderBuilder: (BuildContext context, int section) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Text(
                elementsTitle.keys.toList()[section],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            );
          },
          itemBuilder: (BuildContext context, IndexPath index) {
            String title =
                elementsTitle.values.toList()[index.section][index.index];
            String content =
                elementsContent.values.toList()[index.section][index.index];
            return Container(
              child: DetailCell(
                title: title,
                content: content,
              ),
            );
          },
        ),
      ),
      backgroundColor: BaseColor.colorFFF5F5F5,
    );
  }
}
/**DetailCell(
                elementsTitle.values.toList()[index.section][index.index],
                elementsContent.values.toList()[index.section][index.index]) */
