import 'package:flutter/material.dart';
import 'package:flex_my_way/util/util.dart';
import 'package:flex_my_way/components/components.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flex_my_way/controllers/controllers.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_count_down.dart';

class AddCard extends StatelessWidget {

  static const String id = 'addCard';
  AddCard({Key? key}) : super(key: key);

  /// calling the [HostController] for [HostAFlex]
  final PaymentController controller = Get.put(PaymentController());

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

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
      body: DismissKeyboard(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ReusablePaymentOptionButton(
                        type: 'Card',
                        active: false,
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
                        active: false,
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
                        active: false,
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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      ///name on the card
                      CustomTextFormField(
                        hintText: AppStrings.nameOnTheCard,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textEditingController: controller.nameCardController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        hintText: AppStrings.digitNumber,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        textEditingController: controller.cardDigit,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        inputFormatters: [

                        ],
                      ),
                      CustomTextFormField(
                        hintText: AppStrings.expiryDate,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textEditingController: controller.expiryDate,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        inputFormatters: [

                        ],
                      ),
                      CustomTextFormField(
                        hintText: AppStrings.cvv,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        textEditingController: controller.cvv,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        inputFormatters: [

                        ],
                      ),
                      const SizedBox(height: 15),
                      Button(
                        label: 'Proceed',
                        onPressed: () {
                          if(_formKey.currentState!.validate()) {

                          }
                        },
                      ),
                      const SizedBox(height: 25),
                    ],
                  ),
                ),
              ],
            ),
            ),
          ),
      ),
    );
  }
}
