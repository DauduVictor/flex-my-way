import 'package:flex_my_way/screens/host/host-flex-success.dart';
import 'package:flex_my_way/components/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/circle-indicator.dart';
import '../../components/text-form-field.dart';
import '../../controllers/host-controller.dart';
import '../../networking/flex-datasource.dart';
import '../../util/constants/constants.dart';
import '../../util/constants/functions.dart';
import '../../util/constants/strings.dart';
import '../../util/size-config.dart';
import '../onboarding/login.dart';

class HostFlexTermsAndConditions extends StatelessWidget {

  static const String id = "hostFlexTermsAndConditions";
  HostFlexTermsAndConditions({Key? key}) : super(key: key);

  /// calling the [HostController] for [HostFlexTermsAndConditions]
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
        child: SizedBox(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: SingleChildScrollView(
            child: Obx(() => AbsorbPointer(
                absorbing: controller.showSpinner.value,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          AppStrings.termsAndConditions,
                          style: textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight! * 0.47,
                        padding: const EdgeInsets.fromLTRB(2, 24, 2, 10),
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(24)),
                        child: const RawScrollbar(
                          thumbColor: primaryColor,
                          radius: Radius.circular(8.0),
                          thickness: 4.0,
                          isAlwaysShown: true,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: SingleChildScrollView(
                              child: Text(AppStrings.loremIpsum),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                      controller.paid.value == 'Paid'
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Form(
                              key: _formKey,
                              child: CustomTextFormField(
                                hintText: AppStrings.yourBVN,
                                textEditingController: controller.bvnController,
                                validator: (value) {
                                  if(value!.isEmpty && controller.paid.value == 'Paid') {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          )
                        : Container(),
                      Text(
                        AppStrings.acceptThe,
                        style: textTheme.headline5!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          AppStrings.termsAndConditions,
                          style: textTheme.bodyText2,
                        ),
                        trailing: Checkbox(
                          value: controller.termsAndConditionsAccepted.value,
                          onChanged: (value) {
                            controller.termsAndConditionsAccepted.toggle();
                          },
                        ),
                      ),
                      const SizedBox(height: 5),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          AppStrings.privacyPolicy,
                          style: textTheme.bodyText2!,
                        ),
                        trailing: Checkbox(
                          value: controller.privacyPolicyAccepted.value,
                          onChanged: (value) {
                            controller.privacyPolicyAccepted.toggle();
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      Align(
                        alignment: Alignment.center,
                        child: Opacity(
                          opacity: (controller.termsAndConditionsAccepted.value
                              && controller.privacyPolicyAccepted.value) == true
                                ? 1.0 : 0.7,
                          child: Button(
                            label: AppStrings.finish,
                            onPressed: () {
                              if(controller.paid.value == 'Paid') {
                                if(_formKey.currentState!.validate()) {
                                  if(controller.termsAndConditionsAccepted.value &&
                                      controller.privacyPolicyAccepted.value) {
                                    controller.isLoggedIn.value == true
                                      ? _hostFlex()
                                      : Navigator.pushNamed(context, Login.id);
                                  }
                                }
                              }
                              else {
                                if(controller.termsAndConditionsAccepted.value
                                    && controller.privacyPolicyAccepted.value) {
                                  controller.isLoggedIn.value == true
                                    ? _hostFlex()
                                    : Navigator.pushNamed(context, Login.id);
                                }
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
                        ),
                      )
                    ],
                  ),
                ),
              )
            ),
          ),
        ),
      ),
    );
  }

  void _hostFlex() async {
    controller.showSpinner.value = true;
    Map<String, dynamic> body = {
      'name': controller.nameFlexController.text,
      'date': controller.dateController.text,
      'capacity': controller.numberOfPeopleController.text,
      'ageRating': controller.ageRating.value,
      'flexType': controller.typeOfFlex.value,
      'bannerImage': [],
      'hashtag': controller.eventHashTagController.text,
      'paidOrFree': controller.paid.value,
      'publicOrPrivate': controller.publicOrPrivate.value,
      'displayFlexLocation': controller.displayFlexLocation.value,
      'genderRestriction': controller.genderRestriciton,
      'consumablesPolicy': controller.consumablePolicy.value,
      'flexRules': controller.flexRulesController.text,
      'videoLink': controller.videoLinkController.text
    };
    print(body);
    var api = FlexDataSource();
    await api.createFlex(body).then((flex) {
      controller.showSpinner.value = false;
      Get.offAllNamed(HostFlexSuccess.id);
    }).catchError((e){
      controller.showSpinner.value = false;
      Get.offAllNamed(HostFlexSuccess.id);
      Functions.showMessage(e);
    });
  }

}