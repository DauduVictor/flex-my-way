import 'package:flex_my_way/src/content/constants/colors.dart';
import 'package:flex_my_way/src/content/constants/constants.dart';
import 'package:flex_my_way/src/features/view_model/find_a_flex_view_model.dart';
import 'package:flex_my_way/src/shared/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FindAFlex extends StatelessWidget {
  const FindAFlex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.splashBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacing.largeHeight(),
            Center(
              child: Text(
                AppStrings.youDeyGround,
                textAlign: TextAlign.center,
                style: textTheme.headline1!.copyWith(
                  color: AppColors.white,
                  fontSize: 64,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Spacing.largeHeight(),
            Consumer(builder: (_, ref, __) {
              final viewModel = ref.watch(findAFlexViewModel);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () => viewModel.navigateToHostRegistration(),
                    child: CircleAvatar(
                      backgroundColor: AppColors.white,
                      radius: 42,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColors.splashBackgroundColor,
                        child: Text(
                          AppStrings.host,
                          style: textTheme.headline6!.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: AppColors.white,
                    radius: 42,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColors.white,
                      child: Text(
                        AppStrings.join,
                        style: textTheme.headline6!.copyWith(
                            color: AppColors.splashBackgroundColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
