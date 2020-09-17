class UserInfo {
  int userId;
  String account;
  String username;
  String token;
  String mobile;

  UserInfo({this.userId, this.account, this.username, this.token, this.mobile});

  UserInfo.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    account = json['account'];
    username = json['username'];
    token = json['token'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> userInfo = new Map<String, dynamic>();
    userInfo['user_id'] = this.userId;
    userInfo['account'] = this.account;
    userInfo['username'] = this.username;
    userInfo['token'] = this.token;
    userInfo['mobile'] = this.mobile;
    return userInfo;
  }
}
