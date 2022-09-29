import 'dart:developer';
import 'dart:io';
import 'package:flex_my_way/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/host-controller.dart';
import 'package:flex_my_way/util/util.dart';
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
      body: DismissKeyboard(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 20, 28, 0),
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
                            controller.pickedDate = picked;
                            controller.dateController.text = DateFormat('yyyy-MM-dd').format(picked).toString();
                            controller.allowPickTime.value = true;
                          }
                        },
                      ),
                    /// pick flex time
                    Row(
                      children: [
                        /// start time
                        Expanded(
                          child: CustomTextFormField(
                            hintText: AppStrings.startTime,
                            onChanged: (value) {},
                            readOnly: true,
                            textEditingController: controller.startTimeController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            suffix: const Padding(
                              padding: EdgeInsets.only(right: 12.0),
                              child: Icon(
                                IconlyLight.timeCircle,
                                color: neutralColor,
                              ),
                            ),
                            onTap: () async {
                              if (controller.allowPickTime.value == false) {
                                Functions.showMessage('Pick a flex date first');
                              } else {
                                DateTime now = DateTime.now();
                                TimeOfDay? picked = await showTimePicker(
                                    context: context,
                                    helpText: 'SELECT FLEX START TIME',
                                    initialTime: const TimeOfDay(hour: 00, minute: 00)
                                    builder: (context, child) {
                                  return Theme(
                                    data: ThemeData.light().copyWith(
                                      platform: TargetPlatform.iOS,
                                      colorScheme: const ColorScheme.light().copyWith(
                                        primary: primaryColor,
                                      ),
                                    ),
                                    child: child!,
                                  );
                                }
                              );
                                if (picked != null) {
                                  controller.startTimeController.text =
                                  TimeOfDay(hour: picked.hour, minute: picked.minute).format(context).toString();
                                  controller.startTime = DateTime(
                                    controller.pickedDate!.year,
                                    controller.pickedDate!.month,
                                    controller.pickedDate!.day,
                                    picked.hour,
                                    picked.minute,
                                  );
                                  print(controller.startTime);
                                }
                              }
                            },
                          ),
                        ),
                        const SizedBox(width:  15),
                        Expanded(
                          child: CustomTextFormField(
                            hintText: AppStrings.endTine,
                            onChanged: (value) {},
                            readOnly: true,
                            textEditingController: controller.endTimeController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            suffix: const Padding(
                              padding: EdgeInsets.only(right: 12.0),
                              child: Icon(
                                IconlyLight.timeCircle,
                                color: neutralColor,
                              ),
                            ),
                            onTap: () async {
                              if (controller.allowPickTime.value == false) {
                                Functions.showMessage('Pick a flex date first');
                              } else {
                                  TimeOfDay? picked = await showTimePicker(
                                      context: context,
                                      helpText: 'SELECT FLEX END TIME',
                                      initialTime: const TimeOfDay(hour: 00, minute: 00)
                                      builder: (context, child) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                        platform: TargetPlatform.iOS,
                                        colorScheme: const ColorScheme.light().copyWith(
                                          primary: primaryColor,
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  }
                                );
                                  if (picked != null) {
                                    controller.endTimeController.text =
                                    TimeOfDay(hour: picked.hour, minute: picked.minute).format(context).toString();
                                    controller.endTime = DateTime(
                                      controller.pickedDate!.year,
                                      controller.pickedDate!.month,
                                      controller.pickedDate!.day,
                                      picked.hour,
                                      picked.minute,
                                    );
                                    print(controller.endTime);
                                  }
                              }
                            },
                          ),
                        ),
                      ]
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
                      value: controller.ageRating.value != ''
                        ? controller.ageRating.value : null,
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
                      value: controller.typeOfFlex.value != ''
                        ? controller.typeOfFlex.value : null,
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
                      bottomSpacing: false,
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
                    ),
                    const SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '  * You can upload multiple banner images',
                        style: textTheme.bodyText2!.copyWith(
                          fontSize: 11.5,
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 19),
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
                      autoValidateMode: AutovalidateMode.disabled,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This field is required';
                        }
                        if(!value.contains('#')) {
                          controller.eventHashTagController.text = '#$value';
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp('[ ]')),
                      ],
                    ),
                    /// paid or free
                    Row(
                      children: [
                        Expanded(
                          child: CustomDropdownButtonField(
                            hintText: AppStrings.isPaidOrFree,
                            items: paidOrFree,
                            value: controller.paid.value != ''
                              ? controller.paid.value : null,
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
                        ),
                        controller.paid.value == 'Paid'
                          ? Row(
                              children: [
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    _showPayHint(context, textTheme);
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(bottom: 20.0),
                                    child: Icon(
                                      Icons.info_outlined,
                                      color: primaryColorVariant,
                                      size: 27,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      ],
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
                    /// public or private
                    CustomDropdownButtonField(
                      hintText: AppStrings.openToPublicOrPrivate,
                      value: controller.publicOrPrivate.value != ''
                          ? controller.publicOrPrivate.value : null,
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
                      value: controller.displayFlexLocation.value != ''
                          ? controller.displayFlexLocation.value : null,
                      onChanged: (value) {
                        value = value.toString();
                        controller.displayFlexLocation.value = value.toString();
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                    /// gender restrictions
                    CustomDropdownButtonField(
                      hintText: AppStrings.genderRestrictions,
                      items: isGenderRestrictions,
                      value: controller.genderRestriciton.value != ''
                        ? controller.genderRestriciton.value : null,
                      onChanged: (value) {
                        value = value.toString();
                        controller.genderRestriciton.value = value.toString();
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                    /// food and drinks policy
                    CustomDropdownButtonField(
                      hintText: AppStrings.foodAndDrinkPolicy,
                      items: foodAndDrinkPolicy,
                      value: controller.consumablePolicy.value != ''
                        ? controller.consumablePolicy.value : null,
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
                      maxLength: 500,
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
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      textEditingController: controller.videoLinkController,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return ValidationExtension.validateUrlLink(value.toString());
                        }
                        return null;
                      },
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
      if (source == ImageSource.camera) {
        var image = (await ImagePicker().pickImage(source: source));
        controller.image.first = File(image!.path);
        final fileTemp = File(image.path);
        controller.bannerImageController.text = fileTemp.path.split('/').last;
        Functions.showMessage('Image upload successful');
      } else {
        List<XFile>? image = await ImagePicker().pickMultiImage();
        controller.image.clear();
        controller.update();
        for (int i = 0; i < image!.length; i++) {
          controller.image.add(File(image[i].path));
        }
        controller.update();
        controller.bannerImageController.text = '${controller.image.length} images(s) uploaded';
        Functions.showMessage('Image upload successful');
        controller.convertFileToMultipart();
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
    return StatefulBuilder(
      builder: (context, StateSetter setDialogState) {
        return DismissKeyboard(
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
                    readOnly: true,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      if (value!.length > 2) {
                        setDialogState(() {
                          controller.getUserLatLongByAddress(value);
                        });
                      }
                    },
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
                _buildLocationSuggestions(textTheme, setDialogState),
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _buildLocationSuggestions(TextTheme textTheme, StateSetter setDialogState) {
    List<Widget> locationSuggestionContainer = [];
    if (controller.location.isNotEmpty) {
      for (int i = 0; i < controller.location.length; i++) {
        locationSuggestionContainer.add(
          TextButton(
            onPressed: () async {
              controller.flexAddress.text = await controller.formatLocation(
                controller.location[i].latitude,
                controller.location[i].longitude);
              controller.lat.value = controller.location[i].latitude.toString();
              controller.long.value = controller.location[i].longitude.toString();
            },
            style: TextButton.styleFrom(
              minimumSize: Size(SizeConfig.screenWidth!, 5),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${controller.formatLocation(controller.location[i].latitude,
                    controller.location[i].longitude)}',
                style: textTheme.bodyText1!.copyWith(
                  fontSize: 16.5,
                ),
              ),
            ),
          ),
        );
      }
      return Column(
        children: locationSuggestionContainer,
      );
    } else {
      return SizedBox(
        child: SpinKitCircle(
          color: primaryColor.withOpacity(0.9),
          size: 5,
        ),
      );
    }
  }

  ///widget to show the payment hint
  Future<void> _showPayHint (BuildContext context, TextTheme textTheme) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Container(
        margin: const EdgeInsets.all(60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.close,
                  color: whiteColor,
                  size: 31,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 18, 0, 19),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: const Color(0xFFFFFFFF),
              ),
              child: Material(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 26),
                  child: Text(
                    AppStrings.weWillTake,
                    style: textTheme.bodyText2!.copyWith(
                      fontSize: 16,
                      height: 1.2
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

