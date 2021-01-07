import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import 'package:bootcamp_1/setting.dart';

Future<List<dynamic>> postHttpClient(_url, _body) async {
  dynamic exception;
  IOClient ioClient;
  List _listval = [];
  var response;
  try {
    bool trustSelfSigned = true;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    httpClient.authenticate = (uri, scheme, realm) {
      httpClient.addCredentials(
          uri, realm, new HttpClientDigestCredentials(userapi, passapi));
      return new Future.value(true);
    };
    httpClient.connectionTimeout = Duration(seconds: TimeOutApi);
    ioClient = new IOClient(httpClient);
    var headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $tokenapi",
      "CallSettings": '{"Company":"$companyID","Plant":"$plant"}',
      "Content-Type": "application/json",
    };
    response = await ioClient.post(_url, headers: headers, body: "{$_body}");
    ioClient.close();
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      exception = null;
    } else {
      if (response.statusCode == 401) {
        // ditolak epicor
        exception = "Session Time Out";
      }
      if (response.statusCode == 500) {
        exception =
            "Internal server error. Server is unable to processthe request.";
      }
      if (response.statusCode == 503) {
        exception = "The Service is unavailable";
      }
      if (response.statusCode == 400) {
        try {
          exception = json.decode(response.body)['ErrorMessage'];
          if (exception == null) exception = "odata.error";
        } catch (e) {
          exception =
              "Unable to deserialize entity. Input data is notin correct format.";
        }
      }
    }
    if (exception == null) {
      var _returnjson = await response.body;
      _listval = ["Success", _returnjson, response.statusCode];
      return _listval;
    } else {
      _listval = [
        "Not Success",
        "Not Success : $exception",
        response.statusCode
      ];
    }
  } on SocketException catch (e) {
    exception = e.message;
    _listval = ["Not Success", exception, response.statusCode];
  } catch (e) {
    exception = e.toString();
    _listval = ["Not Success", "Not Success : $exception", response.statusCode];
  }
  ioClient.close();
  return _listval;
}

Future<List<dynamic>> getHttpClient(_url) async {
  dynamic exception;
  IOClient ioClient;
  List _listval = [];
  try {
    bool trustSelfSigned = true;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    httpClient.authenticate = (uri, scheme, realm) {
      httpClient.addCredentials(
          uri, realm, new HttpClientDigestCredentials(userapi, passapi));
      return new Future.value(true);
    };
    httpClient.connectionTimeout = Duration(seconds: TimeOutApi);
    ioClient = new IOClient(httpClient);
    var headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $tokenapi",
      "CallSettings": '{"Company":"$companyID","Plant":"$plant"}',
      "Content-Type": "application/json",
    };
    var response;
    response = await ioClient.get(_url, headers: headers);
    ioClient.close();
    if (response.statusCode == 400) {
      try {
        exception = json.decode(response.body)['ErrorMessage'];
        if (exception == null) exception = "odata.error";
      } catch (e) {
        exception =
            "Unable to deserialize entity. Input data is not in correctformat.";
      }
    }
    if (response.statusCode == 500) {
      exception =
          "Internal server error. Server is unable to process the request.";
    }
    if (response.statusCode == 503) {
      exception = "The Service is unavailable";
    }
    if (exception == null) {
      ioClient.close();
      var _returnjson = await response.body;
      _listval = ["Success", _returnjson];
      return _listval;
    } else {
      ioClient.close();
      exception = response.body["Message"] != null
          ? response.body["Message"]
          : response.body;
      _listval = ["Not Success", "Not Success : $exception"];
      return _listval;
    }
  } on SocketException catch (e) {
    ioClient.close();
    exception = e.message;
    _listval = ["Not Success", exception];
    return _listval;
  } catch (e) {
    ioClient.close();
    exception = e.toString();
    _listval = ["Not Success", "Not Success : $exception"];
    return _listval;
  }
}

Future<List<dynamic>> getToken(_url, _body) async {
  var exception = "";
  IOClient ioClient;
  List _listval = [];
  try {
    bool trustSelfSigned = true;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    httpClient.authenticate = (uri, scheme, realm) {
      httpClient.addCredentials(
          uri, realm, new HttpClientDigestCredentials(userapi, passapi));
      return new Future.value(true);
    };
    httpClient.connectionTimeout = const Duration(seconds: TimeOutApi);
    ioClient = new IOClient(httpClient);
    var bytes = utf8.encode("$userapi:$passapi");
    var credentials = base64.encode(bytes);
    var headers = {
      "Accept": "application/json",
      "Authorization": "Basic $credentials",
      "Content-Type": "application/json"
    };
    var response;
    response = await ioClient.post(_url, headers: headers, body: "");
    ioClient.close();
    if (response.statusCode == 400) {
      try {
        exception = json.decode(response.body)['ErrorMessage'];
        if (exception == null) exception = "odata.error";
      } catch (e) {
        exception =
            "Unable to deserialize entity. Input data is not in correctformat.";
      }
    }
    if (response.statusCode == 500) {
      exception =
          "Internal server error. Server is unable to process the request.";
    }
    if (response.statusCode == 503) {
      exception = "The Service is unavailable";
    }
    if (exception == "") {
      ioClient.close();
      var _returnjson = await json.decode(response.body)['AccessToken'];
      _listval = ["Success", _returnjson];
      return _listval;
    } else {
      ioClient.close();
      exception = response.body["Message"] != null
          ? response.body["Message"]
          : response.body;
      _listval = ["Not Success", "Not Success : $exception"];
      return _listval;
    }
  } on SocketException catch (e) {
    ioClient.close();
    exception = e.message;
    _listval = ["Not Success", exception];
    return _listval;
  } on HandshakeException catch (e) {
    ioClient.close();
    exception = e.message;
    _listval = ["Not Success", exception];
    return _listval;
  } catch (e) {
    ioClient.close();
    exception = "Incorrect username or password";
    _listval = ["Not Success", "Not Success : $exception"];
    return _listval;
  }
}
