import 'package:flex_my_way/components/dropdown-field.dart';
import 'package:flex_my_way/components/button.dart';
import 'package:flex_my_way/components/text-form-field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl/intl.dart';
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

  /// A [TextEditingController] to control the input text for select a date
  final TextEditingController _dateController = TextEditingController();

  /// A [TextEditingController] to control the input text for event hash tag
  final TextEditingController _eventHashTagController = TextEditingController();

  /// A [TextEditingController] to control the input text for number of people
  final TextEditingController _numberOfPeopleController = TextEditingController();

  /// A [TextEditingController] to control the input text for event amount
  final TextEditingController _eventAmountController = TextEditingController();

  /// A [TextEditingController] to control the input text for banner image
  final TextEditingController _bannerImageController = TextEditingController();

  /// A [TextEditingController] to control the input text for event amount
  final TextEditingController _flexRulesController = TextEditingController();

  /// A variable to hold the payment status
  String _paid = 'Free';

  /// A variable to hold the age rate
  String _ageRating = '';

  /// A variable to hold the type of flex
  String _typeOfFlex = '';

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  //name this flex
                  CustomTextFormField(
                    hintText: AppStrings.nameThisFlex,
                    textCapitalization: TextCapitalization.words,
                    textEditingController: _nameFlexController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  //select a date
                  CustomTextFormField(
                    hintText: AppStrings.selectADate,
                    onChanged: (value) {},
                    readOnly: true,
                    textEditingController: _dateController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                    suffix: const Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      child: Icon(
                        IconlyLight.calendar,
                        color: neutralColor,
                      ),
                    ),
                    onTap: () async {
                      DateTime now = DateTime.now();
                      DateTime? picked = await showDatePicker(
                        context: context,
                        lastDate: now,
                        firstDate: DateTime(now.year),
                        initialDate: DateTime(now.year),
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              colorScheme: const ColorScheme.light().copyWith(
                                primary: primaryColor,
                              ),
                            ),
                            child: child!,
                          );
                        }
                      );
                      if (picked != null && picked != now) {
                        if(!mounted) return;
                        setState(() => _dateController.text = DateFormat('d / MMM / yyyy').format(picked).toString());
                      }
                    },
                  ),
                  //how many people can come
                  CustomTextFormField(
                    hintText: AppStrings.howManyPeople,
                    keyboardType: TextInputType.number,
                    textEditingController: _numberOfPeopleController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  //age rating
                  CustomDropdownButtonField(
                    hintText: AppStrings.whatsAgeRating,
                    items: ageRating,
                    validator: (value) {
                      if(value.toString().length < 2) {
                        return 'This field is required';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      value = value.toString();
                      setState(() {
                        _ageRating = value.toString();
                      });
                    },
                  ),
                  //type of flex
                  CustomDropdownButtonField(
                    hintText: AppStrings.typeOfFlex,
                    items: typeOfFlex,
                    onChanged: (value) {
                      value = value.toString();
                      setState(() {
                        _typeOfFlex = value.toString();
                      });
                    },
                  ),
                  //upload banner image
                  CustomTextFormField(
                    hintText: AppStrings.uploadBannerImage,
                    onChanged: (value) {},
                    readOnly: true,
                    textEditingController: _bannerImageController,
                    suffix: const Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Icon(
                        Icons.linked_camera_outlined,
                        color: neutralColor,
                      ),
                    ),
                    onTap: () async {
                      DateTime now = DateTime.now();
                      DateTime? picked = await showDatePicker(
                          context: context,
                          lastDate: now,
                          firstDate: DateTime(now.year),
                          initialDate: DateTime(now.year),
                          builder: (context, child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                colorScheme: const ColorScheme.light().copyWith(
                                  primary: primaryColor,
                                ),
                              ),
                              child: child!,
                            );
                          }
                      );
                      if (picked != null && picked != now) {
                        if(!mounted) return;
                        setState(() => _dateController.text = DateFormat('d / MMM / yyyy').format(picked).toString());
                      }
                    },
                  ),
                  // add hashtag
                  CustomTextFormField(
                    hintText: AppStrings.addAHAshtag,
                    textEditingController: _eventHashTagController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  CustomDropdownButtonField(
                    hintText: AppStrings.isPaidOrFree,
                    items: paidOrFree,
                    onChanged: (value) {
                      value = value.toString();
                      setState(() {
                        _paid = value.toString();
                      });
                    },
                  ),
                  _paid == 'Paid'
                      ? CustomTextFormField(
                    hintText: AppStrings.howMuchAreYouCharging,
                    textEditingController: _eventAmountController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (_paid == 'Paid'){
                        if (value!.isEmpty) {
                          return 'This field is required';
                        }
                      }
                      return null;
                    },
                  )
                      : Container(),
                  _paid == 'Paid'
                      ? Container(
                        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 30),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: primaryColorVariant,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Text(
                          AppStrings.weWillTake,
                          style: textTheme.bodyText2,
                        ),
                      )
                      : Container(),
                  // public or private
                  CustomDropdownButtonField(
                    hintText: AppStrings.openToPublicOrPrivate,
                    items: publicOrPrivate,
                    onChanged: (value) {
                      value = value.toString();
                    },
                  ),
                  //display flex location
                  CustomDropdownButtonField(
                    hintText: AppStrings.displayToOnlyAccepted,
                    items: yesOrNo,
                    onChanged: (value) {
                      value = value.toString();
                    },
                  ),
                  // gender restrictions
                  CustomDropdownButtonField(
                    hintText: AppStrings.genderRestrictions,
                    items: isGenderRestrictions,
                    onChanged: (value) {
                      value = value as bool;
                    },
                  ),
                  //food and drinks policy
                  CustomDropdownButtonField(
                    hintText: AppStrings.foodAndDrinkPolicy,
                    items: foodAndDrinkPolicy,
                    onChanged: (value) {
                      value = value.toString();
                    },
                  ),
                  //flex rules
                  CustomTextFormField(
                    hintText: AppStrings.rulesAboutFlex,
                    textEditingController: _flexRulesController,
                    maxLines: 10,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  Button(
                    label: 'Host Flex',
                    onPressed: () {
                      if(_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return HostFlexTermsAndConditions(
                                paid: _paid,
                                body: {
                                  'name': _nameFlexController.text,
                                  'date': "2021-12-04T10:57:25.509Z",
                                  'capacity': _numberOfPeopleController.text,
                                  'ageRating': '$_ageRating+',
                                  'flexType': _typeOfFlex,
                                  "hashtag": _eventHashTagController.text,
                                  "consumablesPolicy": "Food and drinks free"
                                }
                              );
                            }),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


