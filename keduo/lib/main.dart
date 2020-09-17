import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keduo/utils/spUtil.dart';
//import 'package:provider/provider.dart';

import 'base/routes.dart';
import 'base/tabbarController.dart';
import 'pages/mine/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  realRunApp();
}

void realRunApp() async {
  bool success = await SpUtil.getInstance();
  print("init-" + success.toString());
  runApp(MyApp());
  if (Platform.isAndroid) {
    SystemUiOverlayStyle style = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: onGenerateRoute,
        theme: ThemeData(
          primaryColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool login = true;
  @override
  Widget build(BuildContext context) {
    if (SpUtil.preferences.getBool(StorageKeys.loginKey) == null) {
      //判断存储的是否有某个Key值
      login = false;
    } else {
      login = SpUtil.preferences.getBool(StorageKeys.loginKey);
    }
    if (login) {
      return TabbarController();
    } else {
      return LoginPage();
    }
  }
}
