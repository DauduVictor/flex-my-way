import 'package:flutter/material.dart';
import 'package:flex_my_way/util/util.dart';
import 'package:flex_my_way/components/components.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flex_my_way/controllers/controllers.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'add-card.dart';

class PaymentMethod extends StatelessWidget {

  static const String id = 'paymentMethod';
  PaymentMethod({Key? key}) : super(key: key);

  /// calling the [HostController] for [HostAFlex]
  final PaymentController controller = Get.put(PaymentController());

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
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: SingleChildScrollView(
          child: Obx(() {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ReusablePaymentOptionButton(
                          type: 'Card',
                          active: controller.paymentOption.value == 1
                            ? true : false,
                          onTap: () {
                            if (controller.paymentOption.value != 1) {
                              controller.paymentOption.value = 1;
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 13),
                      Expanded(
                        child: ReusablePaymentOptionButton(
                          type: 'Bank Transfer',
                          active: controller.paymentOption.value == 2
                            ? true : false,
                          onTap: () {
                            if (controller.paymentOption.value != 2) {
                              controller.paymentOption.value = 2;
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 13),
                      Expanded(
                        child: ReusablePaymentOptionButton(
                          type: 'USSD',
                          active: controller.paymentOption.value == 3
                            ? true : false,
                          onTap: () {
                            if (controller.paymentOption.value != 3) {
                              controller.paymentOption.value = 3;
                            }
                          },
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight! * 0.05),
                  if (controller.paymentOption.value == 1)
                    buildCardWidget(),
                  if (controller.paymentOption.value == 2)
                    buildBankTransferWidget(),
                  if (controller.paymentOption.value == 3)
                    buildUssdWidget(),
                ],
              );
            }
          ),
        ),
      ),
    );
  }

  Widget buildCardWidget() {
    return Column(
      children: [
        CardContainer(
          selected: false,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextButton(
            onPressed: () {
              Get.toNamed(AddCard.id);
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 17),
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
                    fontSize: 14.5,
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
    );
  }

  Widget buildBankTransferWidget() {
    return Obx(() {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: AbsorbPointer(
                absorbing: controller.isAccountGenerated.value,
                child: TextButton(
                  onPressed: () {
                    if (controller.isAccountGenerated.value != true) {
                      controller.isAccountGenerated.value = true;
                      Future.delayed(const Duration(seconds: 3), () {
                        controller.isAccountGeneratedFromApi.value = true;
                      });
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(
                        color: controller.isAccountGenerated.value == false
                          ? neutralColor : neutralColor.withOpacity(0.4),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Generate Account',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: controller.isAccountGenerated.value == false
                            ? neutralColor : neutralColor.withOpacity(0.4),
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: controller.isAccountGenerated.value == false
                          ? neutralColor : neutralColor.withOpacity(0.4),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            controller.isAccountGenerated.value == true
              ? Column(
                  children: [
                    controller.isAccountGeneratedFromApi.value == false
                      ? SizedBox(
                          height: SizeConfig.screenHeight! * 0.15,
                          child: Center(
                            child: SpinKitCircle(
                              color: primaryColor.withOpacity(0.9),
                              size: 35,
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            Container(
                                padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
                                margin: const EdgeInsets.symmetric(horizontal: 18),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.0),
                                  color: primaryColor.withOpacity(0.2),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4.5),
                                          child: Image.asset(
                                            'assets/images/jpegs/naira.png',
                                            width: 20,
                                            height: 20,
                                          ),
                                        ),
                                        const SizedBox(width: 3),
                                        const Text(
                                          '50,000',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                                      child: Text(
                                        'Transfer this exact amount to the account below',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 25),
                                    const BankTransferField(
                                      fieldName: 'Bank:',
                                      fieldText: 'First Bank',
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.copyMessage('012345678');
                                      },
                                      child: const BankTransferField(
                                        fieldName: 'Account:',
                                        fieldText: '0123456789',
                                        copy: true,
                                      ),
                                    ),
                                    const SizedBox(height: 25),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.error_outline,
                                          size: 14,
                                        ),
                                        const SizedBox(width: 7),
                                        const Text(
                                          'Account number expires in ',
                                          style: TextStyle(
                                            fontSize: 12.5,
                                          ),
                                        ),
                                        Countdown(
                                          seconds: 10,
                                          build: (context, double time) => Text(
                                            '${time.toInt()}s',
                                            style: const TextStyle(
                                              fontSize: 12.5,
                                            ),
                                          ),
                                          onFinished: () {
                                            controller.isAccountGeneratedFromApi.value = false;
                                            controller.isAccountGenerated.value = false;
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            const SizedBox(height: 40),
                          ],
                      ),
                  ],
                )
              : const SizedBox(),
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Button(
                onPressed: () { },
                color: controller.isAccountGeneratedFromApi.value
                  ? primaryColor : primaryColorVariant,
                label: controller.isAccountGeneratedFromApi.value
                  ? 'I Have Paid' : 'Proceed',
              ),
            ),
          ],
        );
      }
    );
  }

  Widget buildUssdWidget() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextButton(
            onPressed: () {

            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 17),
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
    );
  }
}

class BankTransferField extends StatelessWidget {

  final String fieldName;
  final String fieldText;
  final bool? copy;

  const BankTransferField({
    Key? key,
    required this.fieldName,
    required this.fieldText,
    this.copy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              fieldName,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Text(
              fieldText,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            copy == true
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 7),
                    SvgPicture.asset('assets/images/svgs/copy.svg'),
                  ],
                )
              : const SizedBox(),
          ],
        ),
        const SizedBox(height: 15),
      ],
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: whiteColor,
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
                  width: SizeConfig.screenWidth,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '****  ****  ****  3280',
                        style: TextStyle(
                          fontSize: 14,
                          color: neutralColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 24),

                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
