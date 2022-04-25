import 'package:flex_my_way/util/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/button.dart';
import '../../components/circle-indicator.dart';
import '../../components/dropdown-field.dart';
import '../../components/text-form-field.dart';
import '../../controllers/host-controller.dart';
import '../../util/constants/strings.dart';
import '../../util/size-config.dart';

class BetaSms extends StatelessWidget {

  static const String id = "betaSms";
  BetaSms({Key? key}) : super(key: key);

  /// calling the [HostController] for [BetaSms]
  final HostController controller = Get.put(HostController());

  /// A [GlobalKey] to hold the form state of my form widget for form validation
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        iconTheme: const IconThemeData(
          color: primaryColor,
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          'BetaSMS',
          style: textTheme.headline4!.copyWith(fontSize: 30),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
        },
        child: Obx(() => AbsorbPointer(
          absorbing: controller.showSpinner.value,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 33),
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        Container(
                          width: SizeConfig.screenWidth,
                          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(24)),
                            border: Border.all(color: neutralColor),
                          ),
                          child: const Text(
                            'Kelechi Mo is inviting you to flex\n\n'
                             'Find him this weekend on\n'
                             '24 Oct, 2021.\n\n'
                             'Click the link below to join the flex.\n'
                              'https://www.flexmyway.io/uweb191',
                          ),
                        ),
                        const SizedBox(height: 21),
                        _buildForm(textTheme),
                        const SizedBox(height: 16),
                        Button(
                          label: 'Sign Up',
                          onPressed: () {
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
                            if(_formKey.currentState!.validate()){
                              // _signUp();
                            }
                          },
                          child: controller.showSpinner.value == true
                            ? const SizedBox(
                              height: 21,
                              width: 19,
                              child: CircleProgressIndicator()
                          )
                            : null,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }

  Widget _buildForm(TextTheme textTheme) {
    return Form(
      key: _formKey,
      child: Obx(() => Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(24, 18, 12, 18),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                border: Border.all(
                  color: controller.editingContact.value == true
                    ? primaryColor
                    : neutralColor
                ),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.isUploaded.value
                        ? print('add more contacts')
                        : controller.isUploaded.value = true;
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.isUploaded.value ? 'Add more Contacts' : 'Upload your Contacts',
                          style: textTheme.bodyText2,
                        ),
                        const Icon(
                          Icons.contacts_outlined,
                        ),
                      ],
                    ),
                  ),
                  controller.isUploaded.value
                    ? TextFormField(
                        textInputAction: TextInputAction.done,
                        maxLines: 5,
                        style: const TextStyle(fontSize: 14),
                        keyboardType: TextInputType.number,
                        controller: controller.contactController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a valid phone number';
                          }
                          return null;
                        },
                        onChanged: (value) => controller.editingContact.value = true,
                        onEditingComplete: () {
                          controller.editingContact.value = false;
                          print('editing complete');
                        },
                        decoration: const InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none
                        ),
                      )
                    : Container(),
                ],
              ),
            ),
            const SizedBox(height: 21),
            /// use betasms database
            CustomDropdownButtonField(
              hintText: AppStrings.useDatabase,
              items: yesOrNo,
              onChanged: (value) {
                value = value.toString();
                controller.useDatabase.value = value.toString();
                print(controller.useDatabase.value);
              },
              validator: (value) {
                if (controller.useDatabase.value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
            controller.useDatabase.value == 'Yes'
              ? Column(
                  children: [
                    CustomTextFormField(
                      hintText: 'Specify how many numbers you would like to reach',
                      textInputAction: TextInputAction.done,
                      maxLines: 2,
                      keyboardType: TextInputType.number,
                      textEditingController: controller.betasmsNoOfPeople,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a valid number';
                        }
                        return null;
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: primaryColor.withOpacity(0.2),
                      ),
                      child: Text(
                        'You will be redirected to our payment portal to complete this process.',
                        style: textTheme.bodyText1!.copyWith(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                )
              : Container(),
          ],
        )
      ),
    );
  }

}
