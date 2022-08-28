import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flex_my_way/util/util.dart';

class ReusablePaymentOptionButton extends StatelessWidget {

  final String type;
  final bool active;
  final void Function() onTap;

  const ReusablePaymentOptionButton({
    Key? key,
    required this.type,
    required this.active,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        backgroundColor: active ? primaryColor : whiteColor,
        padding: const EdgeInsets.symmetric(vertical: 17.9, horizontal: 9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: active ? primaryColor : neutralWhiteColor.withOpacity(0.5),
          ),
        ),
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/images/svgs/payment.svg',
            color: active ?
              whiteColor : primaryColor.withOpacity(0.3),
          ),
          const SizedBox(height: 11),
          Text(
            type,
            style: textTheme.button!.copyWith(
              fontSize: 12.5,
              color: active ? whiteColor : primaryColor.withOpacity(0.3),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}