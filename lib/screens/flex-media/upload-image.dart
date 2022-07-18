import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flex_my_way/util/util.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flex_my_way/controllers/controllers.dart';
import 'package:flex_my_way/components/components.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatelessWidget {

  static const String id = 'uploadImage';
  UploadImage({Key? key}) : super(key: key);

  /// calling the [HostController] for [HostAFlex]
  final FlexeryController controller = Get.put(FlexeryController());

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
          'Upload Image',
          style: textTheme.headline5!.copyWith(fontWeight: FontWeight.w600),
        ),
        backgroundColor: transparentColor,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Obx(() {
                      return Container(
                        height: SizeConfig.screenHeight! * 0.4,
                        width: SizeConfig.screenWidth,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        clipBehavior: Clip.hardEdge,
                        decoration: controller.image != null
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(8.3),
                              image: DecorationImage(
                                image: FileImage(controller.image!),
                                fit: BoxFit.cover,
                              ),
                            )
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(8.3),
                              color: neutralColorLight.withOpacity(0.4),
                              border: Border.all(color: neutralColor),
                            ),
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showImageDialog(controller.images.value, context);
                              },
                              child: controller.images.value.length > 1
                                ? Center(
                                    child: Text(
                                      '+${controller.images.value.length -1}',
                                      style: textTheme.bodyMedium!.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: neutralColor.withOpacity(0.25),
                                        fontSize: 110,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            ),
                            GestureDetector(
                              onTap: () {
                                _pickImage(ImageSource.gallery);
                              },
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  color: Colors.black.withOpacity(0.1),
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Add Photo',
                                        style: textTheme.bodyMedium!.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: whiteColor,
                                          fontSize: 21,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Icon(
                                        Icons.camera_outlined,
                                        color: whiteColor,
                                        size: 23,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  ),
                  const SizedBox(height: 30),
                  CustomTextFormField(
                    hintText: 'Add Hashtag #',
                    bottomSpacing: false,
                    keyboardType: TextInputType.text,
                    autoValidateMode: AutovalidateMode.disabled,
                    textInputAction: TextInputAction.next,
                    textEditingController: controller.hashTagController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field is required';
                      }
                      if (!value.contains('#')) {
                        controller.hashTagController.text = '#$value';
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp('[ ]')),
                    ],
                  ),
                  const SizedBox(height: 11),
                  Text(
                    '* Uploaded Image will be shared to all flexers using ths #tag',
                    style: textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 30),
                  /// add location
                  CustomTextFormField(
                    hintText: 'Add Location',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textEditingController: controller.locationController,
                  ),
                  // CustomTextFormField(
                  //   hintText: AppStrings.uploadBannerImage,
                  //   onChanged: (value) {},
                  //   readOnly: true,
                  //   textEditingController: controller.bannerImageController,
                  //   suffix: const Padding(
                  //     padding: EdgeInsets.only(right: 15.0),
                  //     child: Icon(
                  //       Icons.linked_camera_outlined,
                  //       color: neutralColor,
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     showModalBottomSheet(
                  //       barrierColor: Colors.black.withOpacity(0.5),
                  //       elevation: 1.5,
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(30)
                  //       ),
                  //       context: context,
                  //       builder: (context){
                  //         return _bottomModalSheet(context, textTheme);
                  //       },
                  //     );
                  //   },
                  // ),
                  const SizedBox(height: 15),
                  Button(
                    label: 'Upload',
                    onPressed: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();

                      if(_formKey.currentState!.validate()) {
                        // Get.toNamed(HostFlexTermsAndConditions.id);
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

  /// function to pick image from the users gallery
  Future<void> _pickImage(ImageSource source) async {
    try {
      List<XFile>? image = await ImagePicker().pickMultiImage();
      for (int i = 0; i < image!.length; i++) {
        controller.images.add(File(image[i].path));
      }
      controller.image = controller.images.first;
      Functions.showMessage('Image upload successful');
    }
    on PlatformException {
      Functions.showMessage('Image upload failed');
    }
  }

  ///widget to show the dialog for image
  Future<void> _showImageDialog (List<File>? image, BuildContext context) {
    int imageIndex = 0;
    return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: '',
        transitionBuilder: (context, animation, secondaryAnimation, widget) {
          return StatefulBuilder(
            builder: (context, stateSetter) {
              return Transform.translate(
                offset: Offset(0, 10 * animation.value),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 15),
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
                              const SizedBox(height: 10),
                              SizedBox(
                                width: SizeConfig.screenWidth,
                                height: SizeConfig.screenHeight! * 0.7,
                                child: Image.file(
                                  image![imageIndex],
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.medium,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          if (imageIndex < image.length) {
                            stateSetter(() {
                              imageIndex += 1;
                            });
                          }
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent.withOpacity(0.1),
                          radius: 22,
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: whiteColor,
                            size: 21,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (context, animation1, animation2) {
          return Container();
        }
    );
  }

}
