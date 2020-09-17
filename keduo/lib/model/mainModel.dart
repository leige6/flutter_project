class MainModel {
  List<BannerLists> bannerLists;
  List<HotPrint> hotPrint;

  MainModel({this.bannerLists, this.hotPrint});

  MainModel.fromJson(Map<String, dynamic> json) {
    if (json['bannerLists'] != null) {
      bannerLists = new List<BannerLists>();
      json['bannerLists'].forEach((v) {
        bannerLists.add(new BannerLists.fromJson(v));
      });
    }
    if (json['hotPrint'] != null) {
      hotPrint = new List<HotPrint>();
      json['hotPrint'].forEach((v) {
        hotPrint.add(new HotPrint.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bannerLists != null) {
      data['bannerLists'] = this.bannerLists.map((v) => v.toJson()).toList();
    }
    if (this.hotPrint != null) {
      data['hotPrint'] = this.hotPrint.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerLists {
  String bannerImg;
  String url;

  BannerLists({this.bannerImg, this.url});

  BannerLists.fromJson(Map<String, dynamic> json) {
    bannerImg = json['banner_img'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banner_img'] = this.bannerImg;
    data['url'] = this.url;
    return data;
  }
}

class HotPrint {
  String goodsName;
  String goodsId;

  HotPrint({this.goodsName, this.goodsId});

  HotPrint.fromJson(Map<String, dynamic> json) {
    goodsName = json['goods_name'];
    goodsId = json['goods_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goods_name'] = this.goodsName;
    data['goods_id'] = this.goodsId;
    return data;
  }
}
