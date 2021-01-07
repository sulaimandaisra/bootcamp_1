import 'dart:convert';

import 'package:bootcamp_1/Helper/postingapi.dart';
import 'package:bootcamp_1/Model/usercode.dart';
import 'package:bootcamp_1/dbhelper.dart';
import 'package:bootcamp_1/setting.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class UserCodeRepository {
  static Database _db;
  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await DBHelper.internal().setDB();
    return _db;
  }

  Future<List<dynamic>> savedata(List<UserCode> _listdata) async {
    var dbClient = await db;
    dynamic exception;
    List<dynamic> _listval;
    for (var item in _listdata) {
      try {
        List<Map> list = await dbClient.rawQuery(
            "Select * from tb_m_usercode where codetypeid='" +
                item.codetypeid +
                "'");
        if (list.length > 0) {
          await dbClient.update("tb_m_usercode", item.toMap(),
              where: "codetypeid='" + item.codetypeid + "'");
        } else {
          await dbClient.insert("tb_m_usercode", item.toMap());
        }
        _listval = ["Success", "Success", 200];
      } catch (e) {
        exception = e.toString();
        _listval = ["Not Success", exception, 400];
        return _listval;
      }
    }
    return _listval;
  }

  Future<List<dynamic>> getdata(String _search) async {
    var dbClient = await db;
    dynamic exception;
    List<dynamic> _listval;
    try {
      String sql = "Select * from tb_m_usercode where 1=1";
      if (_search != "") {
        sql += " And (description like '%" + _search + "%')";
      }
      List<Map> list = await dbClient.rawQuery(sql);
      List<UserCode> listdata = new List();
      for (int i = 0; i < list.length; i++) {
        var item = new UserCode(list[i]["codetypeid"], list[i]["description"]);
        listdata.add(item);
      }
      _listval = ["Success", listdata, 200];
    } catch (e) {
      exception = e.toString();
      _listval = ["Not Success", exception, 400];
      return _listval;
    }
    return _listval;
  }

  Future<List<dynamic>> getdatabyId(String _id) async {
    var dbClient = await db;
    dynamic exception;
    List<dynamic> _listval;
    try {
      String sql = "Select * from tb_m_usercode where codetypeid='$_id'";
      List<Map> list = await dbClient.rawQuery(sql);
      List<UserCode> listdata = new List();
      for (int i = 0; i < list.length; i++) {
        var item = new UserCode(list[i]["codetypeid"], list[i]["description"]);
        listdata.add(item);
      }
      _listval = ["Success", listdata, 200];
    } catch (e) {
      exception = e.toString();
      _listval = ["Not Success", exception, 400];
      return _listval;
    }
    return _listval;
  }

  Future<List<dynamic>> deletedata(String _id) async {
    var dbClient = await db;
    dynamic exception;
    List<dynamic> _listval;
    try {
      await dbClient.delete("tb_m_usercode", where: "codetypeid='$_id'");
      _listval = ["Success", "Success", 200];
    } catch (e) {
      exception = e.toString();
      _listval = ["Not Success", exception, 400];
      return _listval;
    }
    return _listval;
  }

  Future<List<dynamic>> savedataapi(List<UserCode> _listdata) async {
    List<dynamic> _listval;
    for (var item in _listdata) {
      var _url = "";
      var body = "";
      var dataDS;
      _url = "${baseurlapi}api/v1/Ice.BO.UserCodesSvc/GetNewUDCodeType";
      body = """"ds": {}""";
      _listval = await postHttpClient(_url, body);
      dataDS = json.decode(_listval[1])['parameters']['ds'];
      dataDS = json.encode(dataDS);
      if (_listval[0] == "Success") {
        dataDS = dataDS.replaceAll('"RowMod":""', '"RowMod":"A"');
        dataDS = dataDS.replaceAll(
            '"CodeTypeID":""', '"CodeTypeID":"${item.codetypeid}"');
        dataDS = dataDS.replaceAll(
            '"CodeTypeDesc":""', '"CodeTypeDesc":"${item.description}"');
        _url = "${baseurlapi}api/v1/Ice.BO.UserCodesSvc/Update";
        body = """"ds": $dataDS""";
        _listval = await postHttpClient(_url, body);
      } else {
        if (_listval[2] == 401) {
          break;
        } else {
          break;
        }
      }
    }
    return _listval;
  }

  Future<List<dynamic>> updatedataapi(List<UserCode> _listdata) async {
    List<dynamic> _listval;
    for (var item in _listdata) {
      var _url = "";
      var body = "";
      var dataDS;
      _url = "${baseurlapi}api/v1/Ice.BO.UserCodesSvc/GetByID";
      body = """
        "codeTypeID": "${item.codetypeid}"
      """;
      _listval = await postHttpClient(_url, body);
      dataDS = json.decode(_listval[1])['returnObj'];
      var desc = json.decode(_listval[1])['returnObj']['UDCodeType'][0]
          ['CodeTypeDesc'];
      dataDS = json.encode(dataDS);
      if (_listval[0] == "Success") {
        dataDS = dataDS.replaceAll(
            '"CodeTypeDesc":"$desc"', '"CodeTypeDesc":"${item.description}"');
        _url = "${baseurlapi}api/v1/Ice.BO.UserCodesSvc/Update";
        body = """
          "ds": $dataDS
        """;
        _listval = await postHttpClient(_url, body);
      } else {
        if (_listval[2] == 401) {
          break;
        } else {
          break;
        }
      }
    }
    return _listval;
  }
}
