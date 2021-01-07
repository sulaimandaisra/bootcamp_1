import 'package:flutter/material.dart';
import 'package:bootcamp_1/View/UserCodeApi/login.dart' as Login;
import 'package:bootcamp_1/Helper/loader.dart' as Loader;
import 'dart:async';

import 'package:bootcamp_1/dbhelper.dart';

class Index extends StatefulWidget {
  Index({Key key, this.title, this.username, this.pass}) : super(key: key);
  final String title;
  final String username;
  final String pass;

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  bool isLoading = false;
  void tomenu() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          settings: RouteSettings(name: "Login"),
          builder: (context) => Login.Login()),
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    var db = new DBHelper();
    await db.setDB();
    Timer(Duration(seconds: 5), () => tomenu());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white70),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 200,
                        width: 200,
                        child: Center(
                          child: Image.asset("assets/images/cyber-punk.png"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Loader.ColorLoader5(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
