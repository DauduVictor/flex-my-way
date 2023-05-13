import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flex_my_way/networking/flex-datasource.dart';
import 'package:flutter/material.dart';
import 'package:flex_my_way/util/util.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flex_my_way/controllers/controllers.dart';
import 'package:flex_my_way/components/components.dart';
import 'package:uuid/uuid.dart';

class EditFlex extends StatefulWidget {

  static const String id = 'editFlex';
  final String? flexCode;

  const EditFlex({
    Key? key,
    this.flexCode,
  }) : super(key: key);

  @override
  State<EditFlex> createState() => _EditFlexState();
}

class _EditFlexState extends State<EditFlex> {
  /// calling the [HostController] for [HostAFlex]
  final EditController controller = Get.put(EditController());

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    controller.getFlexDetails(widget.flexCode!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        title: Text(
          AppStrings.editFlex,
          style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: DismissKeyboard(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 20, 28, 0),
            child: Obx(() => Form(
              key: _formKey,
              child: controller.showSpinner.value == true
                ? SizedBox(
                  height: SizeConfig.screenHeight! * 0.6,
                  child: Center(
                      child: SpinKitCircle(
                        color: primaryColor.withOpacity(0.9),
                        size: 45,
                      ),
                    ),
                )
                : Column(
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
                        DateTime now = controller.pickedDate!;
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
                        if (picked != null) {
                          controller.pickedDate = picked;
                          controller.dateController.text = DateFormat('yyyy-MM-dd').format(picked).toString();
                          controller.allowPickTime.value = true;
                          controller.update();
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
                                if ( controller.startTime!.compareTo(controller.pickedDate!) < 0) {
                                  Functions.showMessage('Reselect flex time');
                                  return 'Reselect time';
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
                                      helpText: 'SELECT FLEX START TIME',
                                      initialTime: const TimeOfDay(hour: 00, minute: 00),
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
                                if ( controller.endTime!.compareTo(controller.pickedDate!) < 0) {
                                  Functions.showMessage('Reselect flex time');
                                  return 'Reselect time';
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
                                      initialTime: const TimeOfDay(hour: 00, minute: 00),
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
                      validator: (value) {
                        if(controller.image.value.length > 3) return 'max of 3 images';
                        return null;
                      },
                      suffix: const Padding(
                        padding: EdgeInsets.only(right: 15.0),
                        child: Icon(
                          Icons.linked_camera_outlined,
                          color: neutralColor,
                        ),
                      ),
                      bottomSpacing: false,
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          showImagePreview(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 5.0),
                          margin: const EdgeInsets.fromLTRB(8, 6, 0, 22),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: const Text(
                            'Preview Image(s)',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
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
                    CustomDropdownButtonField(
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
                              style: textTheme.bodyMedium,
                            ),
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
                      value: controller.genderRestriction.value != ''
                          ? controller.genderRestriction.value : null,
                      onChanged: (value) {
                        controller.genderRestriction.value = value.toString();
                      },
                      validator: (value) {
                        if (controller.genderRestriction.value == '') {
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
                      label: 'Edit Flex',
                      onPressed: () {
                        if(_formKey.currentState!.validate()) {
                          if(controller.image.value.length <= 3) {
                            controller.editFlex(widget.flexCode!);
                          } else {
                            Functions.showMessage('Maximum of 3 images');
                          }
                        }
                      },
                      child: controller.loginEditSpinner.value == true
                        ? const SizedBox(
                        height: 21,
                        width: 19,
                        child: CircleProgressIndicator())
                        : null,
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
        List<XFile>? image = await ImagePicker().pickMultiImage(imageQuality: 40);
        controller.image.clear();
        controller.update();
        for (int i = 0; i < image.length; i++) {
          var compressedImage = await FlutterNativeImage.compressImage(image[i].path, quality: 70);
          controller.image.add(compressedImage);
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
      height: SizeConfig.screenHeight! * 0.3,
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
            style: textTheme.headlineSmall!.copyWith(
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
                          style: textTheme.headlineSmall!.copyWith(
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
                          style: textTheme.headlineSmall!.copyWith(
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
    final sessionToken = const Uuid().v4();
    return StatefulBuilder(builder: (context, StateSetter setDialogState) {
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
                      style: textTheme.headlineSmall!.copyWith(
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
              GetBuilder<EditController>(builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextFormField(
                    textEditingController: controller.searchAddress,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.done,
                    hintText: 'Search address',
                    suffix: controller.showSearchSpinner == true
                        ? SpinKitCircle(
                            color: primaryColor.withOpacity(0.9),
                            size: 25,
                          )
                        : IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.search,
                              color: neutralColor,
                            ),
                          ),
                    onChanged: (value) {
                      if (controller.flexAddress.text != '') {
                          controller.flexAddress.text = '';
                      }
                      if (value!.length > 2) {
                        setDialogState(() {
                          searchAddress(
                              address: value, sessionToken: sessionToken);
                        });
                      }
                    },
                  ),
                );
              }),
              const SizedBox(height: 5),
              Column(
                children: [
                  const Divider(
                    color: neutralColor,
                    height: 2.5,
                    thickness: 0.3,
                  ),
                  TextButton(
                    onPressed: () async {
                      try {
                        await controller.getUserLocation()
                          .then((value) => Navigator.pop(context))
                          .catchError((e) {
                          Functions.showMessage(
                              'An error occured, ensure you have internet enabled and try again!');
                        });
                      } catch (e) {
                        Functions.showMessage(e);
                      }
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 9),
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
                          style: textTheme.titleSmall,
                        ),
                        const Spacer(),
                        GetBuilder<EditController>(builder: (controller) {
                          return Visibility(
                            visible: controller.isAddressSearch,
                            child: SpinKitCircle(
                              color: primaryColor.withOpacity(0.9),
                              size: 25,
                            ),
                          );
                        }),
                        const SizedBox(width: 5),
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
              GetBuilder<EditController>(builder: (controller) {
                if (controller.googlePlacesPredictionModel != null) {
                  return ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 10),
                    itemCount: controller.googlePlacesPredictionModel?.predictions?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TextButton(
                        onPressed: () {
                          controller.flexAddress.text = controller.googlePlacesPredictionModel?.predictions?[index].description?.capitalizeFirst ?? '';
                          getAddressDetails(
                            placeId: controller.googlePlacesPredictionModel?.predictions?[index].placeId ?? '',
                            sessionToken: sessionToken
                          );
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          minimumSize: Size(SizeConfig.screenWidth!, 5),
                          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            controller.googlePlacesPredictionModel?.predictions?[index].description?.capitalizeFirst ?? '',
                            style: textTheme.bodyLarge!.copyWith(
                              fontSize: 16.5,
                            ),
                          ),
                        ),
                      );
                  },
                  separatorBuilder: (context, index) => const Divider(
                    height: 0.5,
                  ),
                  );
                } else {
                  return const SizedBox();
                }
              }),
            ],
          ),
        ),
      );
    });
  }

  Timer? _debounce;

  // Api function to search input address
  void searchAddress({String? address, required String sessionToken}) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 800), () async {
      controller.showSearchSpinner = true;
      controller.update();
      var api = FlexDataSource();
      await api.searchAddress(address: address ?? '', sessionToken: sessionToken)
        .then((value) {
          controller.showSearchSpinner = false;
          controller.googlePlacesPredictionModel = value;
          controller.update();
        }).catchError((e) {
          controller.showSearchSpinner = false;
          controller.update();
          log(':::error: seems an error occured');
          Functions.showMessage(e.toString());
        });
    });
  }

  // Api function to get address details [Long, Lat] from selected addrress suggestion
  void getAddressDetails({required String placeId, required String sessionToken}) async {
    var api = FlexDataSource();
    await api.getAddressDetails(placeId: placeId, sessionToken: sessionToken).then((value) {
      // update long and lat for flex
      controller.lat.value = value[0].toString();
      controller.long.value = value[1].toString();
      controller.update();
    }).catchError((e) {
      controller.update();
      log(':::error: seems an error occured');
      Functions.showMessage(e.toString());
    });
  }

  ///widget to show the dialog for image
  Future<void> showImagePreview (BuildContext context) {
    return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: '',
        barrierColor: neutralColor.withOpacity(0.4),
        transitionBuilder: (context, animation, secondaryAnimation, widget) {
          return Transform.translate(
            offset: Offset(0, 10 * animation.value),
            child: StatefulBuilder(
                builder: (context, stateSetter) {
                  return Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 9),
                        child: Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
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
                                const SizedBox(height: 15),
                                SizedBox(
                                  child: controller.image.isEmpty
                                    ? CarouselSlider(
                                        options: CarouselOptions(
                                          initialPage: 0,
                                          autoPlay: false,
                                          viewportFraction: 1,
                                          height: SizeConfig.screenHeight! * 0.77,
                                        ),
                                        items: controller.flex!.bannerImage!.map((e) {
                                          return Column(
                                            children: [
                                              CachedNetworkImage(
                                                alignment: Alignment.topCenter,
                                                imageUrl: e,
                                                progressIndicatorBuilder: (context, url, downloadProgress) {
                                                  return SpinKitCircle(
                                                    color: primaryColor.withOpacity(0.7),
                                                    size: 30,
                                                  );
                                                },
                                                errorWidget: (context, url, error) => Icon(
                                                  Icons.error,
                                                  color: neutralColor.withOpacity(0.4),
                                                  size: 30,
                                                ),
                                                height: SizeConfig.screenHeight! * 0.7,
                                                fit: BoxFit.cover,
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                      )
                                    : CarouselSlider(
                                        options: CarouselOptions(
                                          initialPage: 0,
                                          autoPlay: true,
                                          viewportFraction: 1,
                                          height: SizeConfig.screenHeight! * 0.77,
                                        ),
                                        items: controller.image.map((e) {
                                          return Image.file(
                                            File(e.path.toString()),
                                            height: SizeConfig.screenHeight! * 0.7,
                                            fit: BoxFit.cover,
                                          );
                                        }).toList(),
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (context, animation1, animation2) {
          return Container();
        }
    );
  }
}

