import 'package:flex_my_way/networking/user-datasource.dart';
import 'package:flex_my_way/util/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/app-bar.dart';
import '../../components/button.dart';
import '../../components/circle-indicator.dart';
import '../../components/dropdown-field.dart';
import '../../components/text-form-field.dart';
import '../../controllers/setting-controller.dart';
import '../../util/constants/constants.dart';
import '../../util/constants/functions.dart';
import '../../util/size-config.dart';

class EditProfileDetail extends StatelessWidget {

  static const String id = "editProfileDetail";
  EditProfileDetail({Key? key}) : super(key: key);

  /// calling the onboarding controller for [EditProfileDetail]
  final SettingsController controller = Get.put(SettingsController());

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: buildAppBar(context, textTheme, AppStrings.editProfileDetails),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
        },
        child: AbsorbPointer(
          absorbing: controller.showSpinner.value,
          child: SingleChildScrollView(
            child: Container(
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              padding: const EdgeInsets.fromLTRB(24, 25, 24, 20),
              child: Column(
                children: [
                  Text(
                    'See something wrong?\nChange it below',
                    textAlign: TextAlign.center,
                    style: textTheme.button!.copyWith(
                      color: neutralColor.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          hintText: 'Your Name',
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          textEditingController: controller.nameController,
                        ),
                        CustomTextFormField(
                          hintText: 'Your Email Address',
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          textEditingController: controller.emailAddressController,
                        ),
                        CustomTextFormField(
                          hintText: 'Your Phone Number',
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          textEditingController: controller.phoneNumberController,
                        ),
                        CustomDropdownButtonField(
                          hintText: 'Select a Gender',
                          items: genders,
                          value: controller.gender,
                          onChanged: (value) {
                            controller.gender = value.toString();
                          },
                        ),
                        CustomTextFormField(
                          hintText: 'Your Occupation',
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          textEditingController: controller.occuapationController,
                        ),
                        CustomDropdownButtonField(
                          hintText: 'What type of flex are you interested in?',
                          items: preferredFlex,
                          value: controller.preferredFlex,
                          onChanged: (value) {
                            controller.preferredFlex = value.toString();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Button(
                    label: AppStrings.save,
                    onPressed: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
                      if(_formKey.currentState!.validate()){
                        updateUserInfo();
                      }
                    },
                    child: controller.showSpinner.value == true
                      ? const SizedBox(
                      height: 21,
                      width: 19,
                      child: CircleProgressIndicator()
                  )
                      : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// function to make api call Post
  void updateUserInfo() async{
    // if(!mounted) return;
    controller.showSpinner.value = true;
    var api = UserDataSource();
    Map<String, dynamic> body = {
      'name': controller.nameController.text,
      'email': controller.emailAddressController.text,
      'phone': controller.phoneNumberController.text,
      'gender': controller.gender,
      'occupation': controller.occuapationController.text,
      'preferredFlex': controller.preferredFlex,
    };
    print(body);
    await api.updateUserInfo(body).then((value) {
      // if(!mounted) return;
      controller.showSpinner.value = false;
      Functions.showMessage('Your details have been updated successfully');
    }).catchError((e){
      // if(!mounted) return;
      controller.showSpinner.value = false;
      Functions.showMessage(e);
      log(e);
    });
  }

}
