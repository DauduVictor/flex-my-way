import 'dart:io';
import 'package:flex_my_way/components/dropdown-field.dart';
import 'package:flex_my_way/components/button.dart';
import 'package:flex_my_way/components/text-form-field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:intl/intl.dart';
import '../../util/constants/constants.dart';
import '../../util/constants/functions.dart';
import '../../util/constants/strings.dart';
import '../../util/size-config.dart';
import 'host_flex_terms_and_conditions.dart';
import 'package:image_picker/image_picker.dart';

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
  String _paid = '';

  /// A variable to hold the public or private status
  String _publicOrPrivate = '';

  /// A variable to hold the flex location
  String _displayFlexLocation = '';

  /// A variable to hold the gender restriction
  bool? _genderRestriciton;

  /// A variable to hold the consumable policy
  String _consumablePolicy = '';

  /// A variable to hold the age rate
  String _ageRating = '';

  /// A variable to hold the type of flex
  String _typeOfFlex = '';

  /// File Variable to hold the file source of the selected image
  File? image;

  Future<void> _pickImage(ImageSource source) async {
    if(!mounted) return;
    try {
      final image = await ImagePicker().pickImage(source: source);
      if(image == null) return;
      setState(() {
        final fileTemp = File(image.path);
        this.image = fileTemp;
        _bannerImageController.text = fileTemp.path;
      });
      Functions.showMessage('Image upload successful');
    }
    on PlatformException catch (e) {
      Functions.showMessage('Image upload failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  //name this flex
                  CustomTextFormField(
                    hintText: AppStrings.nameThisFlex,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textEditingController: _nameFlexController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  /// select a date
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
                        lastDate: DateTime(now.year + 2),
                        firstDate: now,
                        initialDate: now,
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
                        setState(() => _dateController.text = DateFormat('yyyy-MMM-d').format(picked).toString());
                      }
                    },
                  ),
                  /// how many people can come
                  CustomTextFormField(
                    hintText: AppStrings.howManyPeople,
                    keyboardType: TextInputType.number,
                    textEditingController: _numberOfPeopleController,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(' ')),
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  /// age rating
                  CustomDropdownButtonField(
                    hintText: AppStrings.whatsAgeRating,
                    items: ageRating,
                    validator: (value) {
                      if(_ageRating.isEmpty) {
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
                  /// type of flex
                  CustomDropdownButtonField(
                    hintText: AppStrings.typeOfFlex,
                    items: preferredFlex,
                    onChanged: (value) {
                      value = value.toString();
                      setState(() {
                        _typeOfFlex = value.toString();
                      });
                    },
                    validator: (value) {
                      if (_typeOfFlex.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  /// upload banner image
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
                    onTap: () {
                      showModalBottomSheet(
                        barrierColor: Colors.black.withOpacity(0.5),
                        elevation: 1.5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)
                        ),
                        context: context,
                        builder: (context){
                          return _bottomModalSheet(context, textTheme);
                        },
                      );
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Upload your flex banner image';
                      }
                      return null;
                    },
                  ),
                  /// add hashtag
                  CustomTextFormField(
                    hintText: AppStrings.addAHAshtag,
                    textEditingController: _eventHashTagController,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 2) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  /// paid or free
                  CustomDropdownButtonField(
                    hintText: AppStrings.isPaidOrFree,
                    items: paidOrFree,
                    onChanged: (value) {
                      value = value.toString();
                      setState(() {
                        _paid = value.toString();
                      });
                    },
                    validator: (value) {
                      if (_paid.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
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
                  /// public or private
                  CustomDropdownButtonField(
                    hintText: AppStrings.openToPublicOrPrivate,
                    items: publicOrPrivate,
                    onChanged: (value) {
                      value = value.toString();
                      setState(() {
                        _publicOrPrivate = value.toString();
                      });
                    },
                    validator: (value) {
                      if (_publicOrPrivate.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  /// display flex location
                  CustomDropdownButtonField(
                    hintText: AppStrings.displayToOnlyAccepted,
                    items: yesOrNo,
                    onChanged: (value) {
                      value = value.toString();
                      setState(() {
                        _displayFlexLocation = value.toString();
                      });
                    },
                    validator: (value) {
                      if (_displayFlexLocation.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  /// gender restrictions
                  CustomDropdownButtonField(
                    hintText: AppStrings.genderRestrictions,
                    items: isGenderRestrictions,
                    onChanged: (value) {
                      value = value as bool;
                      setState(() {
                        _genderRestriciton = value as bool;
                      });
                    },
                    validator: (value) {
                      if (_genderRestriciton == null) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  /// food and drinks policy
                  CustomDropdownButtonField(
                    hintText: AppStrings.foodAndDrinkPolicy,
                    items: foodAndDrinkPolicy,
                    onChanged: (value) {
                      value = value.toString();
                      setState(() {
                        _consumablePolicy = value.toString();
                      });
                    },
                    validator: (value) {
                      if (_consumablePolicy.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  /// flex rules
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
                  const SizedBox(height: 15),
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
                                  'date': _dateController.text,
                                  'capacity': _numberOfPeopleController.text,
                                  'ageRating': _ageRating,
                                  'flexType': _typeOfFlex,
                                  'bannerImage': [],
                                  'hashtag': _eventHashTagController.text,
                                  'paidOrFree': _paid,
                                  'publicOrPrivate': _publicOrPrivate,
                                  'displayFlexLocation': _displayFlexLocation,
                                  'genderRestriction': _genderRestriciton,
                                  'consumablesPolicy': _consumablePolicy,
                                  'flexRules': _flexRulesController.text
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

  /// Bottom modal Widget [PickImageSource]
  Widget _bottomModalSheet(BuildContext context, TextTheme textTheme) {
    return Container(
      height: SizeConfig.screenHeight! * 0.25,
      decoration: const BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Continue action using',
            style: textTheme.headline5!.copyWith(
              fontSize: 21,
            ),
          ),
          const SizedBox(height: 15),
          const Divider(
            color: primaryColor,
            height: 0.5,
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.fromLTRB(75, 20, 75, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                  child: Container(
                    color: backgroundColor,
                    child: Column(
                      children: [
                        const Icon(
                          IconlyBold.image,
                          size: 45,
                          color: primaryColor,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Gallery',
                          style: textTheme.headline5!.copyWith(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                  child: Container(
                    color: backgroundColor,
                    child: Column(
                      children: [
                        const Icon(
                          IconlyLight.camera,
                          size: 45,
                          color: primaryColor,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Camera',
                          style: textTheme.headline5!.copyWith(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
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

