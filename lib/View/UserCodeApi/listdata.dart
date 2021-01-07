import 'dart:convert';
import 'package:bootcamp_1/Helper/postingapi.dart';
import 'package:bootcamp_1/Helper/searchhelper.dart';
import 'package:bootcamp_1/setting.dart';
import 'package:flutter/material.dart';

class ListData extends StatefulWidget {
  ListData({Key key}) : super(key: key);
  @override
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  List list;
  String searchonbar = "";
  SearchBar searchBar;
  _ListDataState() {
    searchBar = new SearchBar(
        inBar: false,
        setState: setState,
        onClosed: onClosed,
        clearOnSubmit: false,
        onSubmitted: onfilter,
        onChanged: onfilter,
        buildDefaultAppBar: buildAppBar);
  }
  onfilter(String value) async {
    searchonbar = value;
    getData();
  }

  void onClosed() {
    searchonbar = "";
    getData();
  }

  @override
  void initState() {
    Future(
      () {
        login();
      },
    );
    super.initState();
  }

  Future<void> login() async {
    userapi = "epicor";
    passapi = "epicor";
    var _url = "${baseurlapi}TokenResource.svc/";
    List<dynamic> _listval = await getToken(_url, "");
    if (_listval[0].toString() == "Success") {
      tokenapi = _listval[1].toString();
      getData();
    } else {
      final snackBar = new SnackBar(content: Text('Error: ${_listval[1]}'));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  Future<void> getData() async {
    var _url = "${baseurlapi}api/v1/Ice.BO.UserCodesSvc/GetList";
    var body =
        """"whereClause": "CodeTypeDesc like '%$searchonbar%'", "pageSize": 100, "absolutePage": 0""";
    List<dynamic> _listval = await postHttpClient(_url, body);
    if (_listval[0] == "Success") {
      list = await json.decode(_listval[1])['returnObj']['UDCodeTypeList'];
      setState(() {});
    } else {
      if (_listval[2] == 401) {
        final snackBar =
            new SnackBar(content: Text('Session Time Out: ${_listval[1]}'));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      } else {
        final snackBar = new SnackBar(content: Text('Error: ${_listval[1]}'));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    }
  }

  deleteData(_id) async {
    try {
      var _url = "${baseurlapi}api/v1/Ice.BO.UserCodesSvc/DeleteByID";
      var body = """"codeTypeID": "$_id" """;
      List<dynamic> _listval = await postHttpClient(_url, body);
      if (_listval[0] == "Success") {
        final snackBar = new SnackBar(content: Text(_listval[0]));
        _scaffoldKey.currentState.showSnackBar(snackBar);
        getData();
      } else {
        if (_listval[2] == 401) {
          final snackBar =
              new SnackBar(content: Text('Session Time Out: ${_listval[1]}'));
          _scaffoldKey.currentState.showSnackBar(snackBar);
        } else {
          final snackBar = new SnackBar(content: Text('Error: ${_listval[1]}'));
          _scaffoldKey.currentState.showSnackBar(snackBar);
        }
      }
    } catch (e) {
      final snackBar = new SnackBar(content: Text('Error: ${e.toString()}'));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  toDetail(_id) async {
    await Navigator.pushNamed(context, '/UserCodeApi/Detail',
        arguments: {'ID': _id});
    getData();
  }

  Widget listdata() {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          child: new GestureDetector(
            onTap: () async {
              toDetail(list[i]["CodeTypeID"]);
            },
            child: new Card(
              child: new ListTile(
                title: new Text(
                  "Title: ${list[i]["CodeTypeID"]}",
                ),
                subtitle: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      "${list[i]["CodeTypeDesc"]}",
                    ),
                  ],
                ),
                trailing: new IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  ),
                  onPressed: () async {
                    deleteData(list[i]["CodeTypeID"]);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text(
          "User Code",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey.shade300,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: new Container(
          child: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(null),
            color: Colors.grey.shade300,
          ),
        ),
        actions: <Widget>[searchBar.getSearchAction(context)]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.build(context),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.red,
        child: new Icon(Icons.add),
        onPressed: () async {
          toDetail("");
        },
      ),
      key: _scaffoldKey,
      body: new RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: getData,
        child: new Container(
          padding: const EdgeInsets.all(10),
          child: listdata(),
        ),
      ),
    );
  }
}
