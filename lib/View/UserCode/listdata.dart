import 'package:bootcamp_1/Helper/searchhelper.dart';
import 'package:bootcamp_1/Model/usercoderepository.dart';
import 'package:bootcamp_1/dbhelper.dart';
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
  var db = new UserCodeRepository();
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
        getDataDB();
        getData();
      },
    );
    super.initState();
  }

  getDataDB() async {
    var db = new DBHelper();
    await db.setDB();
  }

  Future<void> getData() async {
    List<dynamic> _listval = await db.getdata(searchonbar);
    if (_listval[0] == "Success") {
      list = await _listval[1];
      setState(() {});
    } else {
      if (_listval[2] == 401) {
        final snackBar = new SnackBar(content: Text('Error: ${_listval[1]}'));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      } else {
        final snackBar = new SnackBar(content: Text('Error: ${_listval[1]}'));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    }
  }

  deleteData(_id) async {
    try {
      var db = UserCodeRepository();
      List<dynamic> _listval = [];
      _listval = await db.deletedata(_id);
      if (_listval[0] == "Success") {
        final snackBar = new SnackBar(content: Text('Success'));
        _scaffoldKey.currentState.showSnackBar(snackBar);
        getData();
      } else {
        if (_listval[2] == 401) {
          final snackBar = new SnackBar(content: Text('Error: ${_listval[1]}'));
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
    await Navigator.pushNamed(
      context,
      '/UserCode/Detail',
      arguments: {'ID': _id},
    );
    getData();
  }

  Widget listdata() {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          child: new GestureDetector(
            onTap: () async {
              toDetail(list[i].codetypeid);
            },
            child: new Card(
              child: new ListTile(
                title: new Text(
                  "Title: ${list[i].codetypeid}",
                ),
                subtitle: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      "${list[i].description}",
                    ),
                  ],
                ),
                trailing: new IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  ),
                  onPressed: () async {
                    deleteData(list[i].codetypeid);
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
      actions: <Widget>[
        searchBar.getSearchAction(context),
      ],
    );
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
