///json转换辅助工厂，把json转换为T
class ModelFactory {
  static T generateOBJ<T>(json) {
    if (json == null) {
      return null;
    } else {
      return json as T;
    }
  }
}

///数据基类 返回的数据结构为{"code":0,"message":"","data":{}}
class BaseModel<T> {
  String msg;
  int code;
  T data;
  BaseModel({this.code, this.msg, this.data});

  factory BaseModel.fromJson(json) {
    return BaseModel(
      code: json["code"],
      msg: json["msg"],
      data: ModelFactory.generateOBJ<T>(json["data"]),
    );
  }
}

///数据基类 返回的数据结构为{"code":0,"message":"","data":[]}
class BaseListModel<T> {
  String msg;
  int code;
  List<T> data;
  BaseListModel({this.code, this.msg, this.data});

  factory BaseListModel.fromJson(json) {
    List<T> mData = new List<T>();
    if (json["data"] != null) {
      (json["data"] as List).forEach((element) {
        mData.add(ModelFactory.generateOBJ<T>(element));
      });
    }
    return BaseListModel(
      code: json["code"],
      msg: json["msg"],
      data: mData,
    );
  }
}

/// 请求报错基类 {"code":0,"message":"","timestamp":1234566547}
class ErrorModel {
  int code;
  String message;
  int timestamp;
  ErrorModel({this.code, this.message, this.timestamp});
}
