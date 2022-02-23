import 'package:flex_my_way/src/content/constants/constants.dart';
import 'package:flex_my_way/src/features/view_model/host_flex_terms_and_conditions_view_model.dart';
import 'package:flex_my_way/src/shared/widgets/custom_elevated_button.dart';
import 'package:flex_my_way/src/shared/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HostFlexTermsAndConditions extends HookWidget {
  const HostFlexTermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final termsAndConditionsAccepted = useState(false);
    final privacyPolicyAccepted = useState(false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppStrings.hostAFlex,
          style: textTheme.headline4!.copyWith(fontWeight: FontWeight.w600),
        ),
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.chevron_left,
        //     color: AppColors.primaryColor,
        //   ),
        //   onPressed: () {},
        // ),
        // actions: const [
        //   Icon(
        //     Icons.close,
        //     color: AppColors.primaryColor,
        //   ),
        //   Spacing.bigWidth()
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Consumer(
          builder: (_, ref, __) {
            final viewModel = ref.watch(hostFlexTermsAndConditionViewModel);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(20),
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              AppStrings.termsAndConditions,
                              style: textTheme.headline5,
                            ),
                            const Spacing.bigHeight(),
                            const Text(AppStrings.loremIpsum)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacing.bigHeight(),
                Text(
                  AppStrings.acceptThe,
                  style: textTheme.headline5!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                const Spacing.smallHeight(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    AppStrings.termsAndConditions,
                    style: textTheme.bodyText2,
                  ),
                  trailing: Checkbox(
                    value: termsAndConditionsAccepted.value,
                    onChanged: (value) {
                      termsAndConditionsAccepted.value = value!;
                    },
                  ),
                ),
                const Spacing.smallHeight(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    AppStrings.privacyPolicy,
                    style: textTheme.bodyText2,
                  ),
                  trailing: Checkbox(
                    value: privacyPolicyAccepted.value,
                    onChanged: (value) {
                      privacyPolicyAccepted.value = value!;
                    },
                  ),
                ),
                const Spacing.largeHeight(),
                CustomElevatedButton(
                  label: AppStrings.finish,
                  onPressed: () {
                    viewModel.navigateToHostFlexSuccess();
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
