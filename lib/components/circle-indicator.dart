import 'dart:io';
import 'package:flex_my_way/util/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleProgressIndicator extends StatelessWidget {
  const CircleProgressIndicator({
    this.animatingColor = whiteColor,
    Key? key,
  }) : super(key: key);

  final Color animatingColor;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoActivityIndicator(radius: 16, color: animatingColor)
        : CircularProgressIndicator(
            strokeWidth: 3.0,
            valueColor: AlwaysStoppedAnimation<Color>(animatingColor),
          );
  }
}
