class TemplateModel {
  int total;
  int limit;
  int pageCount;
  int page;
  List<Lists> lists;

  TemplateModel(
      {this.total, this.limit, this.pageCount, this.page, this.lists});

  TemplateModel.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class Lists {
  int storeTemplateId;
  String templateImg;
  String templateName;
  int storeId;
  int isDefault;

  Lists(
      {this.storeTemplateId,
      this.templateImg,
      this.templateName,
      this.storeId,
      this.isDefault});

  Lists.fromJson(Map<String, dynamic> json) {
    storeTemplateId = json['store_template_id'];
    templateImg = json['template_img'];
    templateName = json['template_name'];
    storeId = json['store_id'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['store_template_id'] = this.storeTemplateId;
    data['template_img'] = this.templateImg;
    data['template_name'] = this.templateName;
    data['store_id'] = this.storeId;
    data['is_default'] = this.isDefault;
    return data;
  }
}
