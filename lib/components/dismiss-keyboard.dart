import 'package:flutter/material.dart';

class DismissKeyboard extends StatelessWidget {

  final Widget child;

  const DismissKeyboard({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    return GestureDetector(
      onTap: () {
        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      },
      child: child,
    );
  }
}
