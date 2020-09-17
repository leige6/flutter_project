import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:keduo/base/baseModel.dart';
import 'package:keduo/utils/spUtil.dart';
import 'dart:developer' as developer;

///https://segmentfault.com/a/1190000021537855

class NetUrls {
  static final baseUrl = "http://keduo.y.jc-test.cn/";
  static final loginUrl = "client/Login"; //登录接口
  static final getVerifyCodeUrl = "client/getVerifyCode"; //获取验证码
  static final registerUrl = "client/register/user"; //注册
  static final changePasswordUrl = "client/user/changePassword"; //修改密码接口
  static final templatelistUrl = "client/template/lists"; //模版列表
  static final templateSetDefaultUrl = "client/template/setDefault"; //设置默认模版
  static final homeUrl = "client/home/lists"; //首页接口
  static final goodsListUrl = "client/goods/lists"; //商品列表接口

}

enum NetMethod { GET, POST, DELETE, PUT }

const NetMethodValue = {
  NetMethod.GET: "get",
  NetMethod.POST: "post",
  NetMethod.DELETE: "delete",
  NetMethod.PUT: "put"
};

class HttpRequest {
  ///单利
  static final HttpRequest _shard = HttpRequest._internal();
  factory HttpRequest() => _shard;
  Dio dio;
  HttpRequest._internal() {
    if (dio == null) {
      /// 基类请求配置，还可以使用Options单次请求配置，RequestOptions实际请求配置对多个域名发起请求
      BaseOptions options = BaseOptions(
        baseUrl: NetUrls.baseUrl, // 访问url
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json, // 接收响应数据的格式
        receiveDataWhenStatusError: false,
        connectTimeout: 30000, // 连接超时时间
        receiveTimeout: 3000, // 响应流收到数据的间隔
      );
      dio = Dio(options);
    }
  }

  ErrorModel createErrorModel(DioError error) {
    switch (error.type) {
      case DioErrorType.CANCEL:
        {
          return ErrorModel(code: -1, message: "请求已被取消，请重新请求");
        }
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        {
          return ErrorModel(code: -1, message: "网络连接超时，请检查网络设置");
        }
        break;
      case DioErrorType.SEND_TIMEOUT:
        {
          return ErrorModel(code: -1, message: "网络连接超时，请检查网络设置");
        }
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        {
          return ErrorModel(code: -1, message: "服务器异常，请稍后重试！");
        }
        break;
      case DioErrorType.DEFAULT:
        {
          return ErrorModel(code: -1, message: "网络异常，请稍后重试！");
        }
        break;
      case DioErrorType.RESPONSE:
        {
          try {
            int errorCode = error.response.statusCode;
            String errMsg = error.response.statusMessage;
            return ErrorModel(code: errorCode, message: errMsg);
          } on Exception catch (_) {
            return ErrorModel(code: -1, message: "未知错误");
          }
        }
        break;
      default:
        {
          return ErrorModel(code: -1, message: error.message);
        }
    }
  }

  Future request<T>(
    NetMethod method,
    String path, {
    Map<String, dynamic> params,
    Function(T) success,
    Function(ErrorModel) error,
  }) async {
    try {
      if (SpUtil.preferences.getString(StorageKeys.tokenKey) != null) {
        dio.options.headers["Authorization"] =
            SpUtil.preferences.getString(StorageKeys.tokenKey);
      }
      Response response;
      if (method == NetMethod.GET) {
        if (params != null) {
          List<String> lists = List();
          params.forEach((key, value) {
            String ss = key + '=' + value;
            lists.add(ss);
          });
          for (int i = 0; i < lists.length; i++) {
            if (i == 0) {
              path = path + '?';
              path = path + lists[i];
            } else {
              path = path + '&' + lists[i];
            }
          }
        }
        response = await dio.request(path,
            options: Options(method: NetMethodValue[method]));
      } else {
        response = await dio.request(path,
            data: params, options: Options(method: NetMethodValue[method]));
      }
      if (response != null) {
        BaseModel model = BaseModel<T>.fromJson(response.data);

        ///打印出json字符串
        var message = json.encode(response.data);
        printWrapped(message);
        if (model.code == 200 || model.code == 0) {
          success(model.data);
        } else {
          print("---errorCode-----${model.code}");
          error(ErrorModel(code: model.code, message: model.msg));
        }
      } else {
        error(ErrorModel(code: -1, message: "未知错误"));
      }
    } on DioError catch (e) {
      print("---Response出错-------$e");
      error(createErrorModel(e));
    }
  }

  Future requestList<T>(
    NetMethod method,
    String path, {
    Map<String, dynamic> params,
    Function(List<T>) success,
    Function(ErrorModel) error,
  }) async {
    try {
      if (SpUtil.preferences.getString(StorageKeys.tokenKey) != null) {
        dio.options.headers["Authorization"] =
            SpUtil.preferences.getString(StorageKeys.tokenKey);
      }
      Response response;
      if (method == NetMethod.GET) {
        if (params != null) {
          List<String> lists = List();
          params.forEach((key, value) {
            String ss = key + '=' + value;
            lists.add(ss);
          });
          for (int i = 0; i < lists.length; i++) {
            if (i == 0) {
              path = path + '?';
              path = path + lists[i];
            } else {
              path = path + '&' + lists[i];
            }
          }
        }
        response = await dio.request(path,
            options: Options(method: NetMethodValue[method]));
      } else {
        response = await dio.request(path,
            data: params, options: Options(method: NetMethodValue[method]));
      }
      if (response != null) {
        BaseListModel model = BaseListModel<T>.fromJson(response.data);
        if (model.code == 0) {
          success(model.data);
        } else {
          error(ErrorModel(code: model.code, message: model.msg));
        }
      } else {
        error(ErrorModel(code: -1, message: "未知错误"));
      }
    } on DioError catch (e) {
      error(createErrorModel(e));
    }
  }
}

void printWrapped(String text) {
  final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => developer.log(match.group(0)));
}
