import 'dart:io';
import 'package:flex_my_way/util/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleProgressIndicator extends StatelessWidget {

  const CircleProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? const CupertinoActivityIndicator(radius: 16, color: whiteColor)
        : const CircularProgressIndicator(
      strokeWidth: 3.0,
      valueColor: AlwaysStoppedAnimation<Color>(whiteColor),
    );
  }
}