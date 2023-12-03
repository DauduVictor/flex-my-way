import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'constants.dart';

class Functions {
  /// Function to show error message using flutter toast
  static void showToast(String message) {
    showSimpleNotification(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: primaryColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.emergency_share_rounded,
              color: whiteColor.withOpacity(0.9),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 15,
                  color: whiteColor.withOpacity(0.9),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
      background: transparentColor,
      position: NotificationPosition.bottom,
      elevation: 0,
    );
    // Fluttertoast.showToast(
    //   msg: message,
    //   toastLength: Toast.LENGTH_LONG,
    //   gravity: ToastGravity.BOTTOM,
    //   timeInSecForIosWeb: 1,
    //   backgroundColor: Colors.black.withOpacity(0.8),
    //   textColor: whiteColor,
    //   fontSize: 14.5,
    // );
  }

  /// Converting [dateTime] to return a formatted time
  /// of day, month, hour with am or pm
  static String getFormattedDateTime(DateTime dateTime) {
    // 23, May, 2000
    return DateFormat('dd MMM, yyyy').format(dateTime).toString();
  }

  /// Converting a string to return a formatted time
  /// of day, month, hour with am or pm
  static String getFormattedDateTimeText(String date) {
    // 23, May, 2000
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('dd MMM, yyyy').format(dateTime).toString();
  }

  /// Converting [dateTime] to return a formatted time
  /// of day, month, hour with am or pm
  static List<String> getFlexDayAndMonth(DateTime dateTime) {
    // Dec \n 25
    List<String> date = [];
    date.add(DateFormat('MMM').format(dateTime).toString());
    date.add(DateFormat('dd').format(dateTime).toString());
    return date;
  }

  static String getFlexTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  static Future<bool> onWillPops() {
    DateTime? currentBackPressTime;
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Functions.showToast('Press back again to exit');
      return Future.value(false);
    }
    return Future.value(true);
  }
}
