import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/services.dart';
import 'package:bootcamp_1/Helper/customcolor.dart';
import 'package:bootcamp_1/Helper/searchhelper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:bootcamp_1/Helper/currencyinputformatter.dart';
import 'package:unicorndial/unicorndial.dart';

// readOnlyTextField() {
//   TextField(
//     focusNode: FocusNode(),
//     enableInteractiveSelection: false,
//   );
// }

validasiText(String pesan) {
  final validasi = (String value) {
    if (value.isEmpty) {
      return pesan;
    }
    return null;
  };
  return validasi;
}

txtdisable(_id, _label, _validator, _keyboardType) {
  return new TextFormField(
    style: TextStyle(
      color: Colors.grey,
      fontSize: 15.0,
    ),
    controller: _id,
    keyboardType: _keyboardType,
    decoration: new InputDecoration(
        fillColor: Colors.grey[300],
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 0.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: new BorderSide(color: Colors.grey),
        ),
        hintText: _label,
        labelText: _label),
    validator: _validator,
    readOnly: true,
  );
}

textStd(_id, _label, _validator, _keyboardType) {
  return new TextFormField(
    controller: _id,
    keyboardType: _keyboardType,
    decoration: new InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent, width: 0.0),
      ),
      hintText: _label,
      labelText: _label,
    ),
    validator: _validator,
    style: TextStyle(
      fontSize: 15.0,
    ),
  );
}

textDisabled(_id, _label, _validator, _keyboardType) {
  return new TextFormField(
    controller: _id,
    keyboardType: _keyboardType,
    decoration: new InputDecoration(
      fillColor: Colors.grey[300],
      filled: true,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 0.0),
      ),
      focusedBorder:
          UnderlineInputBorder(borderSide: new BorderSide(color: Colors.grey)),
      hintText: _label,
      labelText: _label,
    ),
    validator: _validator,
    style: TextStyle(fontSize: 15.0, color: Colors.grey),
    readOnly: true,
  );
}

textIcon(_id, _label, _validator, _keyboardType, IconButton _iconbtn) {
  return new TextFormField(
    controller: _id,
    keyboardType: _keyboardType,
    decoration: new InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent, width: 0.0),
      ),
      hintText: _label,
      labelText: _label,
      suffixIcon: _iconbtn,
    ),
    validator: _validator,
    style: TextStyle(
      fontSize: 15.0,
    ),
  );
}

textNumber(_id, _label, _validator, _keyboardType) {
  return new TextFormField(
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly,
      CurrencyInputFormatter(),
    ],
    controller: _id,
    keyboardType: _keyboardType,
    decoration: new InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent, width: 0.0),
      ),
      hintText: _label,
      labelText: _label,
    ),
    validator: _validator,
    style: TextStyle(
      fontSize: 15.0,
    ),
  );
}

btnStd(BuildContext context, _label, _onpress) {
  return new Container(
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
                _label,
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      onPressed: _onpress,
    ),
  );
}

snackBarSuccess(String message, String title, BuildContext context) {
  Flushbar(
          title: title,
          message: message,
          backgroundColor: Colors.green,
          // backgroundGradient:
          //     LinearGradient(colors: [Colors.green, Colors.grey]),
          boxShadows: [
            BoxShadow(
              color: Colors.red[800],
              offset: Offset(0.0, 2.0),
              blurRadius: 3.0,
            )
          ],
          duration: Duration(seconds: 4))
      .show(context);
}

snackBarFailed(String message, String title, BuildContext context) {
  Flushbar(
          title: title,
          message: message,
          backgroundColor: Colors.red,
          // backgroundGradient: LinearGradient(colors: [Colors.red, Colors.grey]),
          boxShadows: [
            BoxShadow(
              color: Colors.red[800],
              offset: Offset(0.0, 2.0),
              blurRadius: 3.0,
            )
          ],
          duration: Duration(seconds: 4))
      .show(context);
}

var alertStyle = AlertStyle(
  animationType: AnimationType.grow,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  descStyle: TextStyle(fontWeight: FontWeight.bold),
  animationDuration: Duration(milliseconds: 400),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(0.0),
    side: BorderSide(
      color: Colors.grey,
    ),
  ),
  titleStyle: TextStyle(
    color: Colors.red,
  ),
);
msgFailed(_title, _desc, BuildContext context) {
  return new Alert(
    context: context,
    style: alertStyle,
    type: AlertType.error,
    title: _title,
    desc: _desc,
    buttons: [
      DialogButton(
        child: Text(
          "Ok",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        color: Color.fromRGBO(0, 179, 134, 1.0),
        radius: BorderRadius.circular(0.0),
      ),
    ],
  ).show();
}

msgInfo(_title, _desc, BuildContext context) {
  return new Alert(
    context: context,
    style: alertStyle,
    type: AlertType.info,
    title: _title,
    desc: _desc,
    buttons: [
      DialogButton(
        child: Text(
          "Ok",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        color: Color.fromRGBO(0, 179, 134, 1.0),
        radius: BorderRadius.circular(0.0),
      ),
    ],
  ).show();
}

msgSuccess(_title, _desc, BuildContext context) {
  return new Alert(
    context: context,
    style: alertStyle,
    type: AlertType.success,
    title: _title,
    desc: _desc,
    buttons: [
      DialogButton(
        child: Text(
          "Ok",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        color: Color.fromRGBO(0, 179, 134, 1.0),
        radius: BorderRadius.circular(0.0),
      ),
    ],
  ).show();
}

msgbtnStd(_title, _desc, BuildContext context) {
  return new Alert(
    context: context,
    type: AlertType.info,
    style: alertStyle,
    title: _title,
    desc: _desc,
    buttons: [
      DialogButton(
        child: Text(
          "Ok",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        color: Color.fromRGBO(0, 179, 134, 1.0),
      ),
      DialogButton(
        child: Text(
          "Cancel",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        // gradient: LinearGradient(colors: [
        //   Color.fromRGBO(116, 116, 191, 1.0),
        //   Color.fromRGBO(52, 138, 199, 1.0)
        // ]),
      )
    ],
  ).show();
}

msgFormStd(_title, _desc, BuildContext context) {
  return new Alert(
      context: context,
      title: "LOGIN",
      content: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              icon: Icon(Icons.account_circle),
              labelText: 'Username',
            ),
          ),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              labelText: 'Password',
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            "LOGIN",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ]).show();
}

msgSession(_title, _desc, BuildContext context) {
  return new Alert(
    context: context,
    style: alertStyle,
    type: AlertType.error,
    title: _title,
    desc: _desc,
    buttons: [
      DialogButton(
        child: Text(
          "Ok",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () =>
            Navigator.popUntil(context, ModalRoute.withName("Login")),
        color: Color.fromRGBO(0, 179, 134, 1.0),
        radius: BorderRadius.circular(0.0),
      ),
    ],
  ).show();
}

appBar(_title, BuildContext context, SearchBar searchBar, bool btnsearch) {
  return new AppBar(
      backgroundColor: maincolor(),
      title: new Text(_title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey.shade300,
            fontWeight: FontWeight.bold,
          )),
      leading: new Container(
        child: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(null),
          color: Colors.grey.shade300,
        ),
      ),
      actions:
          (btnsearch) ? <Widget>[searchBar.getSearchAction(context)] : null);
}

unicornbutton(
    _label, _tag, Color _color, Icon _icon, _onpress, BuildContext context) {
  return new UnicornButton(
    hasLabel: true,
    labelText: _label,
    currentButton: FloatingActionButton(
      heroTag: _tag,
      backgroundColor: _color,
      mini: true,
      child: _icon,
      onPressed: _onpress,
    ),
  );
}
