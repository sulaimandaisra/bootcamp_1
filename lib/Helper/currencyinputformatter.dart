import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);
    final formatter = NumberFormat("###,###,###", "en_US");
    String newText = formatter.format(value);

    return newValue.copyWith(
      text: newText,
      // selection: new TextSelection.collapsed(offset: newText.length)
    );
  }
}
