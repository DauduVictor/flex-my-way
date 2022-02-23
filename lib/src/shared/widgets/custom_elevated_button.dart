import 'package:flex_my_way/src/content/constants/colors.dart';
import 'package:flex_my_way/src/content/utilities/screen_utility.dart';
import 'package:flutter/material.dart';

enum ButtonType { primary, secondary, shadowed }

class CustomElevatedButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  final Color color;
  final ButtonType buttonType;
  final Color labelColor;
  final bool isLoading;

  const CustomElevatedButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.color = AppColors.primaryColor,
    this.buttonType = ButtonType.primary,
    this.labelColor = AppColors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        minimumSize: Size(
          ScreenUtil.screenWidth(context),
          50,
        ),
        primary: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: isLoading ? null : onPressed,
      child: Text(
        isLoading ? 'Loading...' : label,
        style: textTheme.bodyText1!.copyWith(
          color: labelColor,
        ),
      ),
    );
  }
}
