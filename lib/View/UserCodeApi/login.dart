import 'dart:convert';
import 'package:bootcamp_1/Helper/postingapi.dart';
import 'package:bootcamp_1/setting.dart';
import 'package:flutter/material.dart';

//Login
class Login extends StatefulWidget {
  @override
  //Login
  _LoginState createState() => _LoginState();
}

//Login
class _LoginState extends State<Login> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  //var db = new UserCodeRepository();
  final _formKey = GlobalKey<FormState>();
  TextEditingController txtusername = new TextEditingController();
  TextEditingController txtpassword = new TextEditingController();
  @override
  void initState() {
    Future(
      () {
        detail();
        //login();
      },
    );
    super.initState();
  }

  resetform() {
    txtusername.text = "";
    txtpassword.text = "";
  }

  clearform() {
    setState(
      () {
        resetform();
      },
    );
  }

  Future<void> login() async {
    userapi = txtusername.text;
    passapi = txtpassword.text;
    var _url = "${baseurlapi}TokenResource.svc/";
    List<dynamic> _listval = await getToken(_url, "");
    if (_listval[0].toString() == "Success") {
      tokenapi = _listval[1].toString();
      Navigator.pushNamed(context, '/UserCodeApi/ListData');
    } else {
      final snackBar = new SnackBar(content: Text('Error: ${_listval[1]}'));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  Widget detail() {
    return new Container(
      padding: new EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: new Form(
        key: _formKey,
        child: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new TextFormField(
                controller: txtusername,
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent, width: 0.0),
                  ),
                  hintText: "Username",
                  labelText: "Username",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Username Required';
                  }
                  return null;
                },
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              new TextFormField(
                controller: txtpassword,
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent, width: 0.0),
                  ),
                  hintText: "Password",
                  labelText: "Password",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Password Required';
                  }
                  return null;
                },
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: new RaisedButton(
                  color: Theme.of(context).primaryColor,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  child: new Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 16.0,
                    ),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Expanded(
                          child: Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      login();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      key: _scaffoldKey,
      body: detail(),
    );
  }
}
