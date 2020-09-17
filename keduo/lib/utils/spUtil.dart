import 'package:shared_preferences/shared_preferences.dart';

class StorageKeys {
  static final loginKey = "loginKey"; //是否登录
  static final tokenKey = "tokenKey"; //用户token
  static final userNameKey = "userNameKey"; //用户名
}

class SpUtil {
  //使用一个工具类持有一个静态的shared_preferences 参考https://www.cnblogs.com/qqcc1388/p/11690516.html
  static SharedPreferences preferences;

  static Future<bool> getInstance() async {
    preferences = await SharedPreferences.getInstance();
    return true;
  }
}
