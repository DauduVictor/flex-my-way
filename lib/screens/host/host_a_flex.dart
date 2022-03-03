import 'package:flex_my_way/components/reusable-dropdown-field.dart';
import 'package:flex_my_way/components/reusable-button.dart';
import 'package:flex_my_way/components/reusable-text-form-field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../util/constants/constants.dart';
import '../../util/constants/strings.dart';
import 'host_flex_terms_and_conditions.dart';

class HostAFlex extends StatefulWidget {

  static const String id = "hostAFlex";
  const HostAFlex({Key? key}) : super(key: key);

  @override
  _HostAFlexState createState() => _HostAFlexState();
}

class _HostAFlexState extends State<HostAFlex> {

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  /// A [TextEditingController] to control the input text for name flex
  final TextEditingController _nameFlexController = TextEditingController();

  /// A [TextEditingController] to control the input text for event hash tag
  final TextEditingController _eventHashTagController = TextEditingController();

  /// A [TextEditingController] to control the input text for number of people
  final TextEditingController _numberOfPeopleController = TextEditingController();

  /// A [TextEditingController] to control the input text for event amount
  final TextEditingController _eventAmountController = TextEditingController();

  /// A [TextEditingController] to control the input text for event amount
  final TextEditingController _flexRulesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppStrings.hostAFlex,
          style: textTheme.headline4!.copyWith(fontWeight: FontWeight.w600),
        ),
        actions: const [
          Icon(
            Icons.close,
            color: primaryColor,
          ),
          SizedBox(width: 24),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    hintText: AppStrings.nameThisFlex,
                    textCapitalization: TextCapitalization.words,
                    onChanged: (value) {},
                    textEditingController: _nameFlexController,
                  ),
                  // InkWell(
                  //   onTap: () async {
                  //     dateState.value = await showDatePicker(
                  //       context: context,
                  //       initialDate: DateTime.now(),
                  //       firstDate: DateTime.now(),
                  //       lastDate: DateTime(2100),
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
                  //           dateState.value.toString() == 'null'
                  //               ? AppStrings.dateOfBirth
                  //               : viewModel.formatDate(dateState.value!),
                  //           style: textTheme.bodyText2,
                  //         ),
                  //         SvgPicture.asset(calendar)
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 24),
                  CustomTextFormField(
                    hintText: AppStrings.howManyPeople,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      value = value.toString();
                    },
                    textEditingController: _numberOfPeopleController,
                  ),
                  CustomDropdownButtonField(
                    hintText: AppStrings.whatsAgeRating,
                    items: ageRating,
                    onChanged: (value) {
                      value = value.toString();
                    },
                  ),
                  CustomDropdownButtonField(
                    hintText: AppStrings.typeOfFlex,
                    items: typeOfFlex,
                    onChanged: (value) {
                      value = value.toString();
                    },
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     // dateState.value = await showDatePicker(
                  //     //   context: context,
                  //     //   initialDate: DateTime.now(),
                  //     //   firstDate: DateTime.now(),
                  //     //   lastDate: DateTime(2100),
                  //     // );
                  //   },
                  //   child: Container(
                  //     height: 60,
                  //     padding: const EdgeInsets.all(10),
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10),
                  //         border: Border.all(color: AppColors.secondaryColor)),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text(
                  //           dateState.value.toString() == 'null'
                  //               ? AppStrings.uploadBannerImage
                  //               : viewModel.formatDate(dateState.value!),
                  //           style: textTheme.bodyText2,
                  //         ),
                  //         SvgPicture.asset(AppSvgs.cameraIcon)
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 24),
                  CustomTextFormField(
                    hintText: AppStrings.addAHAshtag,
                    onChanged: (value) {},
                    textEditingController: _eventHashTagController,
                  ),
                  CustomDropdownButtonField(
                    hintText: AppStrings.isPaidOrFree,
                    items: paidOrFree,
                    onChanged: (value) {
                      value = value.toString();
                    },
                  ),
                  // eventPaymentState.value == 'Paid'
                  //     ? CustomTextFormField(
                  //   hintText: AppStrings.howMuchAreYouCharging,
                  //   onChanged: (value) {},
                  //   textEditingController: eventAmountController,
                  // )
                  //     : Container(),
                  // eventPaymentState.value == 'Paid'
                  //     ? Container(
                  //   padding: const EdgeInsets.all(20),
                  //   decoration: BoxDecoration(
                  //     color: primaryColorVariant,
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   child: Text(
                  //     AppStrings.weWillTake,
                  //     style: textTheme.bodyText2,
                  //   ),
                  // )
                  //     : Container(),
                  CustomDropdownButtonField(
                    hintText: AppStrings.openToPublicOrPrivate,
                    items: publicOrPrivate,
                    onChanged: (value) {
                      value = value.toString();
                    },
                  ),
                  CustomDropdownButtonField(
                    hintText: AppStrings.displayToOnlyAccepted,
                    items: publicOrPrivate,
                    onChanged: (value) {
                      value = value.toString();
                    },
                  ),
                  CustomDropdownButtonField(
                    hintText: AppStrings.genderRestrictions,
                    items: isGenderRestrictions,
                    onChanged: (value) {
                      value = value as bool;
                    },
                  ),
                  CustomDropdownButtonField(
                    hintText: AppStrings.foodAndDrinkPolicy,
                    items: foodAndDrinkPolicy,
                    onChanged: (value) {
                      value = value.toString();
                    },
                  ),
                  CustomTextFormField(
                    hintText: AppStrings.rulesAboutFlex,
                    onChanged: (value) {},
                    textEditingController: _flexRulesController,
                    maxLines: 10,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.done,
                  ),
                  const SizedBox(height: 32),
                  Button(
                    label: AppStrings.signUp,
                    onPressed: () {
                      Navigator.pushNamed(context, HostFlexTermsAndConditions.id);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

