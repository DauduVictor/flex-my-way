import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../controllers/host-controller.dart';
import 'package:flex_my_way/util/util.dart';
import 'package:flex_my_way/components/components.dart';

class HostRegistration extends StatelessWidget {

  static const String id = "hostRegistration";
  HostRegistration({Key? key}) : super(key: key);

  /// calling the [HostController] for [HostRegistration]
  final HostController controller = Get.put(HostController());

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        title: Text(
          AppStrings.becomeAHost,
          style: textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: DismissKeyboard(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
            child: Obx(() => AbsorbPointer(
                absorbing: controller.showSpinner.value,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      /*CustomTextFormField(
                        hintText: AppStrings.hostName,
                        textEditingController: controller.hostNameController,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        validator: (value) {

                        },
                      ),
                      CustomTextFormField(
                        hintText: AppStrings.hostEmailAddress,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {},
                        textEditingController: controller.hostEmailAddressController,
                      ),
                      CustomTextFormField(
                        hintText: AppStrings.password,
                        obscureText: controller.hostObscureText.value,
                        validator: (value) {},
                        textEditingController: controller.hostPasswordController,
                        suffix: GestureDetector(
                          onTap: () {
                            controller.hostObscureText.toggle();
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0,13 ,10 ,0),
                            child: Text(
                              controller.hostObscureText.value == true ? 'SHOW' : 'HIDE',
                              style: textTheme.button!.copyWith(
                                fontSize: 17,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      CustomTextFormField(
                        hintText: AppStrings.hostPhoneNumber,
                        keyboardType: TextInputType.number,
                        validator: (value) {},
                        onChanged: (value) {},
                        textEditingController: controller.hostPhoneNumberController,
                      ),
                      /// gender
                      CustomDropdownButtonField(
                        hintText: AppStrings.gender,
                        items: genders,
                        onChanged: (value) {
                          value = value.toString();
                        },
                      ),
                      /// occupation
                      CustomTextFormField(
                        textEditingController: controller.occupationController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        hintText: 'Your Occupation',
                        validator: (value) {
                          if(value!.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                      ),*/
                      const SizedBox(height: 24),
                      InkWell(
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
                        child: controller.selfieImage == null
                          ? Container(
                              height: 200,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: neutralColor,
                                ),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(uploadIcon),
                                    const SizedBox(height: 13),
                                    const Text(
                                      AppStrings.uploadASelfie,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              height: 200,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: neutralColor,
                                ),
                                image: DecorationImage(
                                  image: FileImage(File(controller.selfieImage!.path)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      ),
                      const SizedBox(height: 32),
                      Button(
                        label: 'Become Host',
                        onPressed: () {
                          if(_formKey.currentState!.validate()) {
                            if (controller.selfieImage == null) {
                              Functions.showMessage('Please upload a selfie');
                            }
                            print('pass');
                          }
                        },
                        child: controller.showSpinner.value == false
                          ?  null
                          : const SizedBox(
                              height: 19,
                              width: 19,
                              child: CircleProgressIndicator(),
                            ),
                      ),
                      const SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// function to pick image from the users gallery
  Future<void> _pickImage(ImageSource source) async {
    controller.selfieImage = null;
    try {
      var image = (await ImagePicker().pickImage(source: source));
      controller.selfieImage = File(image!.path);
      print(':::imagePath: ${controller.selfieImage!.path}');
      controller.update();
      Functions.showMessage('Image upload successful');
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

}
