import 'package:flutter/material.dart';

MaterialColor maincolor() {
  WidgetsFlutterBinding.ensureInitialized();
  Map<int, Color> color = {
    50: Color.fromRGBO(0, 74, 130, .1),
    100: Color.fromRGBO(0, 74, 130, .2),
    200: Color.fromRGBO(0, 74, 130, .3),
    300: Color.fromRGBO(0, 74, 130, .4),
    400: Color.fromRGBO(0, 74, 130, .5),
    500: Color.fromRGBO(0, 74, 130, .6),
    600: Color.fromRGBO(0, 74, 130, .7),
    700: Color.fromRGBO(0, 74, 130, .8),
    800: Color.fromRGBO(0, 74, 130, .9),
    900: Color.fromRGBO(0, 74, 130, 1),
  };
  MaterialColor colorCustom = MaterialColor(0xFF004A82, color);
  return colorCustom;
}
