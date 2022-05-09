import 'dart:developer';
import 'dart:io';
import 'package:flex_my_way/components/dropdown-field.dart';
import 'package:flex_my_way/components/button.dart';
import 'package:flex_my_way/components/text-form-field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/host-controller.dart';
import '../../util/constants/constants.dart';
import '../../util/constants/functions.dart';
import '../../util/constants/strings.dart';
import '../../util/size-config.dart';
import 'host-flex-terms-and-conditions.dart';
import 'package:image_picker/image_picker.dart';

class HostAFlex extends StatelessWidget {

  static const String id = "hostAFlex";
  HostAFlex({Key? key}) : super(key: key);

  /// calling the [HostController] for [HostAFlex]
  final HostController controller = Get.put(HostController());

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

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
            child: Obx(() => Form(
                key: _formKey,
                child: Column(
                  children: [
                    ///name this flex
                    CustomTextFormField(
                      hintText: AppStrings.nameThisFlex,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      textEditingController: controller.nameFlexController,
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
                        textEditingController: controller.dateController,
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
                            controller.dateController.text = DateFormat('yyyy-MMM-d').format(picked).toString();
                          }
                        },
                      ),
                    /// how many people can come
                    CustomTextFormField(
                      hintText: AppStrings.howManyPeople,
                      keyboardType: TextInputType.number,
                      textEditingController: controller.numberOfPeopleController,
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
                        if(controller.ageRating.value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        value = value.toString();
                        controller.ageRating.value = value.toString();
                      },
                    ),
                    /// type of flex
                    CustomDropdownButtonField(
                      hintText: AppStrings.typeOfFlex,
                      items: preferredFlexes,
                      onChanged: (value) {
                        value = value.toString();
                        controller.typeOfFlex.value = value.toString();
                      },
                      validator: (value) {
                        if (controller.typeOfFlex.value.isEmpty) {
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
                      textEditingController: controller.bannerImageController,
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
                    ///flex address
                    CustomTextFormField(
                      hintText: AppStrings.setAddress,
                      keyboardType: TextInputType.streetAddress,
                      readOnly: true,
                      onTap: () {
                        showModalBottomSheet(
                          barrierColor: Colors.black.withOpacity(0.5),
                          elevation: 1.5,
                          enableDrag: true,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                          context: context,
                          builder: (context){
                            return _showAddressModal(context, textTheme);
                          },
                        );
                      },
                      textInputAction: TextInputAction.next,
                      textEditingController: controller.flexAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                    /// add hashtag
                    CustomTextFormField(
                      hintText: AppStrings.addAHAshtag,
                      textEditingController: controller.eventHashTagController,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 2) {
                          return 'This field is required';
                        }
                        if(!value.contains('#')) {
                          controller.eventHashTagController.text = '#$value}';
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
                        controller.paid.value = value.toString();
                      },
                      validator: (value) {
                        if (controller.paid.value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                    controller.paid.value == 'Paid'
                      ? CustomTextFormField(
                        hintText: AppStrings.howMuchAreYouCharging,
                        textEditingController: controller.eventAmountController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (controller.paid.value == 'Paid'){
                            if (value!.isEmpty) {
                              return 'This field is required';
                            }
                          }
                          return null;
                        },
                      )
                      : Container(),
                    controller.paid.value == 'Paid'
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
                          controller.publicOrPrivate.value = value.toString();
                      },
                      validator: (value) {
                        if (controller.publicOrPrivate.value.isEmpty) {
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
                        controller.displayFlexLocation.value = value.toString();
                      },
                      validator: (value) {
                        if (controller.displayFlexLocation.value.isEmpty) {
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
                        controller.genderRestriciton = value;
                      },
                      validator: (value) {
                        if (controller.genderRestriciton == null) {
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
                        controller.consumablePolicy.value = value.toString();
                      },
                      validator: (value) {
                        if (controller.consumablePolicy.value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                    /// flex rules
                    CustomTextFormField(
                      hintText: AppStrings.rulesAboutFlex,
                      textEditingController: controller.flexRulesController,
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
                    CustomTextFormField(
                      hintText: AppStrings.videoLink,
                      textEditingController: controller.videoLinkController,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 15),
                    Button(
                      label: 'Host Flex',
                      onPressed: () {
                        if(_formKey.currentState!.validate()) {
                          Get.toNamed(HostFlexTermsAndConditions.id);
                        }
                      },
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              )
            ),
          ),
        ),
      ),
    );
  }

  /// function to pick image from the users gallery
  Future<void> _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if(image == null) {
        return;
      }
      else {
        final fileTemp = File(image.path);
        controller.bannerImageController.text = fileTemp.path;
        Functions.showMessage('Image upload successful');
      }
    }
    on PlatformException {
      Functions.showMessage('Image upload failed');
    }
  }

  /// Bottom modal Widget [PickImageSource]
  Widget _bottomModalSheet(BuildContext context, TextTheme textTheme) {
    return Container(
      height: SizeConfig.screenHeight! * 0.22,
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
          const SizedBox(height: 10),
          const Divider(
            color: primaryColor,
            height: 0.5,
          ),
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
                          size: 40,
                          color: primaryColor,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Gallery',
                          style: textTheme.headline5!.copyWith(
                            fontSize: 17,
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
                          size: 40,
                          color: primaryColor,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Camera',
                          style: textTheme.headline5!.copyWith(
                            fontSize: 17,
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

  /// Bottom modal Widget to set flex address
  Widget _showAddressModal(BuildContext context, TextTheme textTheme) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      },
      child: Container(
        height: SizeConfig.screenHeight! * 0.9,
        decoration: const BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 21),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 30),
                Center(
                  child: Text(
                    'Search Address',
                    style: textTheme.headline5!.copyWith(
                      fontSize: 17,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      size: 31,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 21),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomTextFormField(
                hintText: AppStrings.enterAddress,
                textEditingController: controller.searchAddress,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.done,
              ),
            ),
            const Divider(
              color: neutralColor,
              height: 2.5,
              thickness: 0.3,
            ),
            TextButton(
              onPressed: () {
                try {
                  controller.getUserLocation();
                  Navigator.pop(context);
                } catch (e) {
                  Functions.showMessage(e);
                }
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 9),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.near_me_outlined,
                    color: neutralColor,
                    size: 21,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Use my location',
                    style: textTheme.bodyText1,
                  ),
                ],
              ),
            ),
            const Divider(
              color: primaryColor,
              height: 0.1,
              thickness: 0.1,
            ),
          ],
        ),
      ),
    );
  }

}

