import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'constants.dart';

class Functions {

  /// Function to show error message using flutter toast
  static void showMessage(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black.withOpacity(0.8),
        textColor: whiteColor,
        fontSize: 14.0
    );
  }

  /// Converting [dateTime] to return a formatted time
  /// of day, month, hour with am or pm
  static String getFormattedDateTime(DateTime dateTime) { // 23, May, 2000
    return DateFormat('dd MMM, yyyy').format(dateTime).toString();
  }

  /// Converting a string to return a formatted time
  /// of day, month, hour with am or pm
  static String getFormattedDateTimeText(String date) { // 23, May, 2000
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('dd MMM, yyyy').format(dateTime).toString();
  }

  /// Converting [dateTime] to return a formatted time
  /// of day, month, hour with am or pm
  static List<String> getFlexDayAndMonth(DateTime dateTime) { // Dec \n 25
    List<String> date = [];
    date.add(DateFormat('MMM').format(dateTime).toString());
    date.add(DateFormat('dd').format(dateTime).toString());
    return date;
  }

}