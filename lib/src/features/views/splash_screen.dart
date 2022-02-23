import 'package:flex_my_way/src/content/constants/colors.dart';
import 'package:flex_my_way/src/content/constants/constants.dart';
import 'package:flex_my_way/src/features/view_model/splash_screen_view_model.dart';
import 'package:flex_my_way/src/shared/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashScreenView extends ConsumerWidget {
  const SplashScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final splashScreenNotifier = ref.read(splashScreenViewModel);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        backgroundColor: AppColors.splashBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(
                AppStrings.celebrateTogether,
                style: textTheme.headline5!.copyWith(color: AppColors.white),
              ),
              const Spacing.bigHeight(),
              Text(
                AppStrings.flexMyWay,
                style: textTheme.headline1!.copyWith(
                    color: AppColors.white, fontWeight: FontWeight.w600),
              ),
              const Spacing.bigHeight(),
              Container(
                height: 10,
                // width: splashScreenNotifier.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white12,
                ),
                child: AnimatedContainer(
                  // height: 10,
                  width: splashScreenNotifier.width,
                  duration: const Duration(seconds: 5),
                  onEnd: () => splashScreenNotifier.onEnd(context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
