import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'constants.dart';

class Functions {

  /// Function to show error message using flutter toast
  static void showErrorMessage(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: errorColor,
        textColor: whiteColor,
        fontSize: 14.0
    );
  }

}