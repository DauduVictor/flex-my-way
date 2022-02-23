import 'package:flex_my_way/src/content/constants/constants.dart';
import 'package:flex_my_way/src/content/utilities/app_images.dart';
import 'package:flex_my_way/src/features/view_model/host_registration_view_model.dart';
import 'package:flex_my_way/src/shared/widgets/custom_dropdown_field.dart';
import 'package:flex_my_way/src/shared/widgets/custom_elevated_button.dart';
import 'package:flex_my_way/src/shared/widgets/custom_text_form_field.dart';
import 'package:flex_my_way/src/shared/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HostRegistration extends HookWidget {
  const HostRegistration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final hostNameController = useTextEditingController();
    final hostEmailAddressController = useTextEditingController();
    final passwordController = useTextEditingController();
    final hostPhoneNumberController = useTextEditingController();
    final bvnController = useTextEditingController();
    final genderState = useState('Male');
    final occupationState = useState('Architect');
    final ValueNotifier<DateTime?> dateOfBirthState = useState(null);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppStrings.hostAFlex,
          style: textTheme.headline4!.copyWith(fontWeight: FontWeight.w600),
        ),
        actions: const [
          Icon(
            Icons.close,
            color: AppColors.darkTextColor,
          ),
          Spacing.bigWidth()
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Consumer(
          builder: (context, ref, child) {
            final viewModel = ref.watch(hostRegistrationViewModel);

            return SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextFormField(
                    hintText: AppStrings.hostName,
                    textEditingController: hostNameController,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    validator: (value) {},
                    onChanged: (value) {},
                  ),
                  CustomTextFormField(
                    hintText: AppStrings.hostEmailAddress,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {},
                    onChanged: (value) {},
                    textEditingController: hostEmailAddressController,
                  ),
                  CustomTextFormField(
                    hintText: AppStrings.password,
                    obscureText: viewModel.textObscured,
                    validator: (value) {},
                    onChanged: (value) {},
                    textEditingController: passwordController,
                    suffix: viewModel.textObscured
                        ? TextButton(
                            onPressed: () {
                              viewModel.changeTextObscured();
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Text('SHOW'),
                            ),
                          )
                        : TextButton(
                            onPressed: () {
                              viewModel.changeTextObscured();
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Text('HIDE'),
                            ),
                          ),
                  ),
                  CustomTextFormField(
                    hintText: AppStrings.hostPhoneNumber,
                    keyboardType: TextInputType.number,
                    validator: (value) {},
                    onChanged: (value) {},
                    textEditingController: hostPhoneNumberController,
                  ),
                  CustomDropdownButtonField(
                    hintText: AppStrings.gender,
                    items: viewModel.genders,
                    onChanged: (value) {
                      genderState.value = value as String;
                    },
                  ),
                  CustomDropdownButtonField(
                    hintText: AppStrings.occupation,
                    items: viewModel.occupations,
                    onChanged: (value) {
                      occupationState.value = value as String;
                    },
                  ),
                  InkWell(
                    onTap: () async {
                      dateOfBirthState.value = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                    },
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.secondaryColor)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dateOfBirthState.value.toString() == 'null'
                                ? AppStrings.dateOfBirth
                                : viewModel.formatDate(dateOfBirthState.value!),
                            style: textTheme.bodyText2,
                          ),
                          SvgPicture.asset(AppSvgs.calendar)
                        ],
                      ),
                    ),
                  ),
                  const Spacing.bigHeight(),
                  CustomTextFormField(
                    hintText: AppStrings.yourBVN,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {},
                    textEditingController: bvnController,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.secondaryColor,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppSvgs.uploadIcon,
                            ),
                            const Spacing.smallHeight(),
                            const Text(
                              AppStrings.uploadYourID,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Spacing.largeHeight(),
                  CustomElevatedButton(
                    label: AppStrings.signUp,
                    onPressed: () {
                      viewModel.navigateToHostAFlex();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
