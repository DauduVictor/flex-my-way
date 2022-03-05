import 'package:flex_my_way/util/constants/strings.dart';
import 'package:flutter/material.dart';
import '../../components/app-bar.dart';
import '../../components/button.dart';
import '../../components/dropdown-field.dart';
import '../../components/text-form-field.dart';
import '../../util/constants/constants.dart';
import '../../util/size-config.dart';

class EditProfileDetail extends StatefulWidget {

  static const String id = "editProfileDetail";
  const EditProfileDetail({Key? key}) : super(key: key);

  @override
  _EditProfileDetailState createState() => _EditProfileDetailState();
}

class _EditProfileDetailState extends State<EditProfileDetail> {

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  /// A [TextEditingController] to control the input text for new email address
  final TextEditingController _emailAddressController = TextEditingController();

  /// A [TextEditingController] to control the input text for phone number
  final TextEditingController _phoneNumberController = TextEditingController();

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
        child: SingleChildScrollView(
          child: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            padding: const EdgeInsets.fromLTRB(24, 45, 24, 20),
            child: Column(
              children: [
                Text(
                  'See something wrong?\nChange it below',
                  textAlign: TextAlign.center,
                  style: textTheme.button!.copyWith(
                    color: neutralColor.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 35),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        hintText: 'Your Email Address',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {},
                        textEditingController: _emailAddressController,
                      ),
                      CustomTextFormField(
                        hintText: 'Your Phone Number',
                        onChanged: (value) {},
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        textEditingController: _phoneNumberController,
                      ),
                      CustomDropdownButtonField(
                        hintText: 'Select a Gender',
                        items: genders,
                        onChanged: (value) {
                          value = value.toString();
                        },
                      ),
                      CustomDropdownButtonField(
                        hintText: 'Your Occupation',
                        items: occupations,
                        onChanged: (value) {
                          value = value.toString();
                        },
                      ),
                      CustomDropdownButtonField(
                        hintText: 'What type of flex are you interested in?',
                        items: typeOfFlex,
                        onChanged: (value) {
                          value = value.toString();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Button(
                  onPressed: () { },
                  label: AppStrings.save,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
