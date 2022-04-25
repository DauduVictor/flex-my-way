import 'package:flex_my_way/components/dropdown-field.dart';
import 'package:flex_my_way/components/button.dart';
import 'package:flex_my_way/components/text-form-field.dart';
import 'package:flex_my_way/screens/host/host-a-flex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../components/circle-indicator.dart';
import '../../controllers/host-controller.dart';
import '../../util/constants/constants.dart';
import '../../util/constants/strings.dart';

class HostRegistration extends StatelessWidget {

  static const String id = "hostRegistration";
  HostRegistration({Key? key}) : super(key: key);

  /// calling the [HostController] for [HostRegistration]
  final HostController controller = Get.put(HostController());

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        title: Text(
          AppStrings.hostAFlex,
          style: textTheme.headline4!.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
            child: Obx(() => AbsorbPointer(
                absorbing: controller.showSpinner.value,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        hintText: AppStrings.hostName,
                        textEditingController: controller.hostNameController,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        validator: (value) {

                        },
                      ),
                      CustomTextFormField(
                        hintText: AppStrings.hostEmailAddress,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {},
                        textEditingController: controller.hostEmailAddressController,
                      ),
                      CustomTextFormField(
                        hintText: AppStrings.password,
                        obscureText: controller.hostObscureText.value,
                        validator: (value) {},
                        textEditingController: controller.hostPasswordController,
                        suffix: GestureDetector(
                          onTap: () {
                            controller.hostObscureText.toggle();
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0,13 ,10 ,0),
                            child: Text(
                              controller.hostObscureText.value == true ? 'SHOW' : 'HIDE',
                              style: textTheme.button!.copyWith(
                                fontSize: 17,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      CustomTextFormField(
                        hintText: AppStrings.hostPhoneNumber,
                        keyboardType: TextInputType.number,
                        validator: (value) {},
                        onChanged: (value) {},
                        textEditingController: controller.hostPhoneNumberController,
                      ),
                      /// gender
                      CustomDropdownButtonField(
                        hintText: AppStrings.gender,
                        items: genders,
                        onChanged: (value) {
                          value = value.toString();
                        },
                      ),
                      /// occupation
                      CustomTextFormField(
                        textEditingController: controller.occupationController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        hintText: 'Your Occupation',
                        validator: (value) {
                          if(value!.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                      ),
                      // InkWell(
                      //   onTap: () async {
                      //     dateOfBirthState.value = await showDatePicker(
                      //       context: context,
                      //       initialDate: DateTime.now(),
                      //       firstDate: DateTime(1900),
                      //       lastDate: DateTime.now(),
                      //     );
                      //   },
                      //   child: Container(
                      //     height: 60,
                      //     padding: const EdgeInsets.all(10),
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(10),
                      //         border: Border.all(color: neutralColor)),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Text(
                      //           dateOfBirthState.value.toString() == 'null'
                      //               ? AppStrings.dateOfBirth
                      //               : viewModel.formatDate(dateOfBirthState.value!),
                      //           style: textTheme.bodyText2,
                      //         ),
                      //         SvgPicture.asset(calendar)
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 24),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: neutralColor,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(uploadIcon),
                                const SizedBox(height: 8),
                                const Text(
                                  AppStrings.uploadYourID,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Button(
                        label: AppStrings.signUp,
                        onPressed: () {
                          if(_formKey.currentState!.validate()) {
                            
                          }
                        },
                        child: controller.showSpinner.value == false
                          ?  null
                          : const SizedBox(
                              height: 19,
                              width: 19,
                              child: CircleProgressIndicator(),
                            ),
                      ),
                      const SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
