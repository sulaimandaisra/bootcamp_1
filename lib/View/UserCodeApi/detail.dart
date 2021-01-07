import 'dart:convert';
import 'package:bootcamp_1/Helper/postingapi.dart';
import 'package:bootcamp_1/Model/usercode.dart';
import 'package:bootcamp_1/Model/usercoderepository.dart';
import 'package:bootcamp_1/setting.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  var db = new UserCodeRepository();
  final _formKey = GlobalKey<FormState>();
  TextEditingController txtcodetypeid = new TextEditingController();
  TextEditingController txtdescription = new TextEditingController();
  @override
  void initState() {
    Future(
      () {
        getData();
      },
    );
    super.initState();
  }

  resetform() {
    txtcodetypeid.text = "";
    txtdescription.text = "";
  }

  clearform() {
    setState(
      () {
        resetform();
      },
    );
  }

  Future<void> getData() async {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments['ID'] != "") {
      var _url = "${baseurlapi}api/v1/Ice.BO.UserCodesSvc/GetByID";
      var body = """ "codeTypeID": "${arguments['ID']}" """;
      List<dynamic> _listval = await postHttpClient(_url, body);
      if (_listval[0] == "Success") {
        List list = await json.decode(_listval[1])['returnObj']['UDCodeType'];
        for (var item in list) {
          txtcodetypeid.text = item["CodeTypeID"];
          txtdescription.text = item["CodeTypeDesc"];
        }
        setState(() {});
      } else {
        if (_listval[2] == 401) {
          final snackBar = new SnackBar(
            content: Text(
              'Session Time Out: ${_listval[1]}',
            ),
          );
          _scaffoldKey.currentState.showSnackBar(snackBar);
        } else {
          final snackBar = new SnackBar(
            content: Text(
              'Error: ${_listval[1]}',
            ),
          );
          _scaffoldKey.currentState.showSnackBar(snackBar);
        }
      }
    } else {
      resetform();
    }
  }

  saveData() async {
    try {
      var db = UserCodeRepository();
      List<UserCode> listdata = new List();
      var item = new UserCode(
        txtcodetypeid.text,
        txtdescription.text,
      );
      listdata.add(item);
      List<dynamic> _listval = [];
      _listval = await db.savedataapi(listdata);
      if (_listval[0] == "Success") {
        resetform();
        final snackBar = new SnackBar(
          content: Text('Success'),
        );
        _scaffoldKey.currentState.showSnackBar(snackBar);
      } else {
        if (_listval[2] == 401) {
          final snackBar = new SnackBar(
            content: Text('Error: ${_listval[1]}'),
          );
          _scaffoldKey.currentState.showSnackBar(snackBar);
        } else {
          final snackBar = new SnackBar(
            content: Text('Error: ${_listval[1]}'),
          );
          _scaffoldKey.currentState.showSnackBar(snackBar);
        }
      }
    } catch (e) {
      final snackBar = new SnackBar(content: Text('Error: ${e.toString()}'));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  updateData() async {
    try {
      var db = UserCodeRepository();
      List<UserCode> listdata = new List();
      var item = new UserCode(
        txtcodetypeid.text,
        txtdescription.text,
      );
      listdata.add(item);
      List<dynamic> _listval = [];
      _listval = await db.updatedataapi(listdata);
      if (_listval[0] == "Success") {
        resetform();
        final snackBar = new SnackBar(
          content: Text('Success Update'),
        );
        _scaffoldKey.currentState.showSnackBar(snackBar);
      } else {
        if (_listval[2] == 401) {
          final snackBar = new SnackBar(
            content: Text('Error: ${_listval[1]}'),
          );
          _scaffoldKey.currentState.showSnackBar(snackBar);
        } else {
          final snackBar = new SnackBar(
            content: Text('Error: ${_listval[1]}'),
          );
          _scaffoldKey.currentState.showSnackBar(snackBar);
        }
      }
    } catch (e) {
      final snackBar = new SnackBar(content: Text('Error: ${e.toString()}'));
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
                controller: txtcodetypeid,
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent, width: 0.0),
                  ),
                  hintText: "Code Type ID",
                  labelText: "Code Type ID",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Code Type ID harus diisi';
                  }
                  return null;
                },
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              new TextFormField(
                controller: txtdescription,
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent, width: 0.0),
                  ),
                  hintText: "Description",
                  labelText: "Description",
                ),
                validator: null,
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
                            "Save",
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
                      updateData();
                    } // else if (_formKey.currentState.validate()) {
                    //   updateData();
                    //   saveData();
                    // }
                  },
                ),
              ),
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
        title: Text("User Code"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.clear_all),
            onPressed: () => clearform(),
          ),
        ],
      ),
      key: _scaffoldKey,
      body: detail(),
    );
  }
}
