import 'package:flex_my_way/src/content/constants/constants.dart';
import 'package:flex_my_way/src/content/utilities/utilities.dart';
import 'package:flex_my_way/src/features/view_model/host_a_flex_view_model.dart';
import 'package:flex_my_way/src/shared/widgets/custom_dropdown_field.dart';
import 'package:flex_my_way/src/shared/widgets/custom_elevated_button.dart';
import 'package:flex_my_way/src/shared/widgets/custom_text_form_field.dart';
import 'package:flex_my_way/src/shared/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HostAFlex extends HookWidget {
  const HostAFlex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final nameFlexController = useTextEditingController();
    final eventHashTagController = useTextEditingController();
    final flexRulesController = useTextEditingController();
    final numberOfPeopleController = useTextEditingController();
    final eventAmountController = useTextEditingController();

    final ValueNotifier<DateTime?> dateState = useState(null);
    final ageRatingState = useState(12);
    final typeOfFlexState = useState('After Party');
    final eventPaymentState = useState('Free');
    final publicOrPrivateState = useState('Public');
    final displayLocationToOnlyParticipantsState = useState(false);
    final genderRestrictionsState = useState(true);
    final foodAndDrinkPolicyState = useState('');

    // final bannerImageState = useState();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppStrings.hostAFlex,
          style: textTheme.headline4!.copyWith(fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: AppColors.primaryColor,
          ),
          onPressed: () {},
        ),
        actions: const [
          Icon(
            Icons.close,
            color: AppColors.primaryColor,
          ),
          Spacing.bigWidth()
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Consumer(
          builder: (_, ref, __) {
            final viewModel = ref.watch(hostAFlexViewModel);
            return SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextFormField(
                    hintText: AppStrings.nameThisFlex,
                    textCapitalization: TextCapitalization.words,
                    onChanged: (value) {},
                    textEditingController: nameFlexController,
                  ),
                  InkWell(
                    onTap: () async {
                      dateState.value = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                    },
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.secondaryColor)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dateState.value.toString() == 'null'
                                ? AppStrings.dateOfBirth
                                : viewModel.formatDate(dateState.value!),
                            style: textTheme.bodyText2,
                          ),
                          SvgPicture.asset(AppSvgs.calendar)
                        ],
                      ),
                    ),
                  ),
                  const Spacing.bigHeight(),
                  CustomTextFormField(
                    hintText: AppStrings.howManyPeople,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {},
                    textEditingController: numberOfPeopleController,
                  ),
                  CustomDropdownButtonField(
                    hintText: AppStrings.whatsAgeRating,
                    items: viewModel.ageRating,
                    onChanged: (value) {},
                  ),
                  CustomDropdownButtonField(
                    hintText: AppStrings.typeOfFlex,
                    items: viewModel.typeOfFlex,
                    onChanged: (value) {},
                  ),
                  InkWell(
                    onTap: () {
                      // dateState.value = await showDatePicker(
                      //   context: context,
                      //   initialDate: DateTime.now(),
                      //   firstDate: DateTime.now(),
                      //   lastDate: DateTime(2100),
                      // );
                    },
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.secondaryColor)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dateState.value.toString() == 'null'
                                ? AppStrings.uploadBannerImage
                                : viewModel.formatDate(dateState.value!),
                            style: textTheme.bodyText2,
                          ),
                          SvgPicture.asset(AppSvgs.cameraIcon)
                        ],
                      ),
                    ),
                  ),
                  const Spacing.bigHeight(),
                  CustomTextFormField(
                    hintText: AppStrings.addAHAshtag,
                    onChanged: (value) {},
                    textEditingController: eventHashTagController,
                  ),
                  CustomDropdownButtonField(
                    hintText: AppStrings.isPaidOrFree,
                    items: viewModel.paidOrFree,
                    onChanged: (value) {
                      eventPaymentState.value = value as String;
                    },
                  ),
                  eventPaymentState.value == 'Paid'
                      ? CustomTextFormField(
                          hintText: AppStrings.howMuchAreYouCharging,
                          onChanged: (value) {},
                          textEditingController: eventAmountController,
                        )
                      : Container(),
                  eventPaymentState.value == 'Paid'
                      ? Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColorVariant,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            AppStrings.weWillTake,
                            style: textTheme.bodyText2,
                          ),
                        )
                      : Container(),
                  CustomDropdownButtonField(
                    hintText: AppStrings.openToPublicOrPrivate,
                    items: viewModel.publicOrPrivate,
                    onChanged: (value) {
                      publicOrPrivateState.value = value as String;
                    },
                  ),
                  CustomDropdownButtonField(
                    hintText: AppStrings.displayToOnlyAccepted,
                    items: viewModel.publicOrPrivate,
                    onChanged: (value) {
                      publicOrPrivateState.value = value as String;
                    },
                  ),
                  CustomDropdownButtonField(
                    hintText: AppStrings.genderRestrictions,
                    items: viewModel.isGenderRestrictions,
                    onChanged: (value) {
                      genderRestrictionsState.value = value as bool;
                    },
                  ),
                  CustomDropdownButtonField(
                    hintText: AppStrings.foodAndDrinkPolicy,
                    items: viewModel.foodAndDrinkPolicy,
                    onChanged: (value) {},
                  ),
                  CustomTextFormField(
                    hintText: AppStrings.rulesAboutFlex,
                    onChanged: (value) {},
                    textEditingController: flexRulesController,
                    maxLines: 10,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.done,
                  ),
                  const Spacing.largeHeight(),
                  CustomElevatedButton(
                    label: AppStrings.signUp,
                    onPressed: () {
                      viewModel.navigateToHostAFlex();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
