import 'package:flutter/services.dart';

class RegxUtils {
  static WhitelistingTextInputFormatter passWord =
      WhitelistingTextInputFormatter(RegExp('^[A-Za-z0-9]+\$'));
  static String letter = '[a-zA-Z]';
  static String chinese = '[\u4e00-\u9fa5]';
  static String number = '[0-9]';
  static BlacklistingTextInputFormatter noletter =
      BlacklistingTextInputFormatter(RegExp('[a-zA-Z]+\$'));
  static BlacklistingTextInputFormatter nochinese =
      BlacklistingTextInputFormatter(RegExp('[\u4e00-\u9fa5]+\$'));
  static BlacklistingTextInputFormatter nonumber =
      BlacklistingTextInputFormatter(RegExp('[0-9]+\$'));
  static WhitelistingTextInputFormatter price =
      WhitelistingTextInputFormatter(RegExp(r'^(\d+)?\.?\d{0,2}'));
}
