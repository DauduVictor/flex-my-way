import 'package:flutter/material.dart';
import 'package:flex_my_way/util/util.dart';
import 'package:flex_my_way/components/components.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentMethod extends StatelessWidget {

  static const String id = 'paymentMethod';
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: buildAppBar(
        context, textTheme,
        AppStrings.paymentMethod,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ReusablePaymentOptionButton(
                      type: 'Card',
                      active: true,
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: ReusablePaymentOptionButton(
                      type: 'Bank Transfer',
                      active: false,
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: ReusablePaymentOptionButton(
                      type: 'USSD',
                      active: false,
                      onTap: () {},
                    ),
                  ),

                ],
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.05),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextButton(
                  onPressed: () {
                    
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: neutralColor),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Add New Card',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: neutralColor
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: neutralColor,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Button(
                  onPressed: () { },
                  label: 'Proceed',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardContainer extends StatelessWidget {

  final bool selected;

  const CardContainer({
    Key? key,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        backgroundColor: lightPurpleColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: selected ? primaryColor : neutralWhiteColor.withOpacity(0.5),
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            color: whiteColor,
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  '****  ****  ****  3280',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
