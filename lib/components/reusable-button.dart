import 'package:flex_my_way/util/size-config.dart';
import 'package:flutter/material.dart';
import '../util/constants/constants.dart';

class Button extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final Color labelColor;

  const Button({
    Key? key,
    required this.label,
    required this.onPressed,
    this.labelColor = whiteColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    SizeConfig().init(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 21),
        primary: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: SizeConfig.screenWidth! - 130,
        child: Center(
          child: Text(
            label,
            style: textTheme.bodyText2!.copyWith(
              color: labelColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
