import 'package:flutter/material.dart';
import 'package:bootcamp_1/View/UserCode/detail.dart' as UserCodeDetail;
import 'package:bootcamp_1/View/UserCode/listdata.dart' as UserCodeList;
import 'package:bootcamp_1/View/UserCodeApi/detail.dart' as UserCodeApiDetail;
import 'package:bootcamp_1/View/UserCodeApi/listdata.dart' as UserCodeApiList;
import 'package:bootcamp_1/View/UserCodeApi/login.dart' as UserCodeApiLogin;
import 'package:bootcamp_1/Helper/splashscreen.dart' as Splash;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bootcamp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: ListData(),
      initialRoute: '/SplashScreen/Index',
      routes: <String, WidgetBuilder>{
        '/SplashScreen/Index': (BuildContext context) => new Splash.Index(),
        '/UserCode/ListData': (BuildContext context) =>
            new UserCodeList.ListData(),
        '/UserCode/Detail': (BuildContext context) =>
            new UserCodeDetail.Detail(),
        '/UserCodeApi/ListData': (BuildContext context) =>
            new UserCodeApiList.ListData(),
        '/UserCodeApi/Detail': (BuildContext context) =>
            new UserCodeApiDetail.Detail(),
        '/UserCodeApi/Login': (BuildContext context) =>
            new UserCodeApiLogin.Login(),
      },
    );
  }
}
