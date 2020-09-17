import 'package:flutter/material.dart';

class GoodsModel {
  int total;
  int limit;
  int pageCount;
  int page;
  List<Lists> lists;
  int waitPrintCount;

  GoodsModel(
      {this.total,
      this.limit,
      this.pageCount,
      this.page,
      this.lists,
      this.waitPrintCount});

  GoodsModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    limit = json['limit'];
    pageCount = json['page_count'];
    page = json['page'];
    if (json['list'] != null) {
      lists = new List<Lists>();
      json['list'].forEach((v) {
        lists.add(new Lists.fromJson(v));
      });
    }
    waitPrintCount = json['waitPrintCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['limit'] = this.limit;
    data['page_count'] = this.pageCount;
    data['page'] = this.page;
    if (this.lists != null) {
      data['list'] = this.lists.map((v) => v.toJson()).toList();
    }
    data['waitPrintCount'] = this.waitPrintCount;
    return data;
  }
}

class Lists with ChangeNotifier {
  String code;
  String storeCode;
  String goodsName;
  String goodsBarCode;
  String goodsCode;
  String origin;
  String brand;
  String grade;
  String categoryName;
  int storeId;
  int storeGoodsId;
  String shopPrice;
  String goodsUnit;
  int isPromote;
  String memberPrice;
  String promotePrice;
  String promoteStartDate;
  String promoteEndDate;
  List<Attr> attr;
  int whetherToPrint;
  bool select;

  Lists(
      {this.code,
      this.storeCode,
      this.goodsName,
      this.goodsBarCode,
      this.goodsCode,
      this.origin,
      this.brand,
      this.grade,
      this.categoryName,
      this.storeId,
      this.storeGoodsId,
      this.shopPrice,
      this.goodsUnit,
      this.isPromote,
      this.memberPrice,
      this.promotePrice,
      this.promoteStartDate,
      this.promoteEndDate,
      this.attr,
      this.whetherToPrint,
      this.select});

  Lists.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    storeCode = json['store_code'];
    goodsName = json['goods_name'];
    goodsBarCode = json['goods_bar_code'];
    goodsCode = json['goods_code'];
    origin = json['origin'];
    brand = json['brand'];
    grade = json['grade'];
    categoryName = json['category_name'];
    storeId = json['store_id'];
    storeGoodsId = json['store_goods_id'];
    shopPrice = json['shop_price'];
    goodsUnit = json['goods_unit'];
    isPromote = json['is_promote'];
    memberPrice = json['member_price'];
    promotePrice = json['promote_price'];
    promoteStartDate = json['promote_start_date'];
    promoteEndDate = json['promote_end_date'];
    if (json['attr'] != null) {
      attr = new List<Attr>();
      json['attr'].forEach((v) {
        attr.add(new Attr.fromJson(v));
      });
    }
    select = false;
    whetherToPrint = json['whether_to_print'];
  }

  bool isSelect() => select;

  void setSelect(bool select) {
    this.select = select;
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['store_code'] = this.storeCode;
    data['goods_name'] = this.goodsName;
    data['goods_bar_code'] = this.goodsBarCode;
    data['goods_code'] = this.goodsCode;
    data['origin'] = this.origin;
    data['brand'] = this.brand;
    data['grade'] = this.grade;
    data['category_name'] = this.categoryName;
    data['store_id'] = this.storeId;
    data['store_goods_id'] = this.storeGoodsId;
    data['shop_price'] = this.shopPrice;
    data['goods_unit'] = this.goodsUnit;
    data['is_promote'] = this.isPromote;
    data['member_price'] = this.memberPrice;
    data['promote_price'] = this.promotePrice;
    data['promote_start_date'] = this.promoteStartDate;
    data['promote_end_date'] = this.promoteEndDate;
    if (this.attr != null) {
      data['attr'] = this.attr.map((v) => v.toJson()).toList();
    }
    data['whether_to_print'] = this.whetherToPrint;
    return data;
  }
}

class Attr {
  String attrName;
  String attrValue;

  Attr({this.attrName, this.attrValue});

  Attr.fromJson(Map<String, dynamic> json) {
    attrName = json['attr_name'] == null ? '' : json['attr_name'];
    attrValue = json['attr_value'] == null ? '' : json['attr_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attr_name'] = this.attrName;
    data['attr_value'] = this.attrValue;
    return data;
  }
}
