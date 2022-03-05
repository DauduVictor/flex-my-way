import 'package:flex_my_way/screens/host/host_flex_success.dart';
import 'package:flex_my_way/components/button.dart';
import 'package:flutter/material.dart';
import '../../util/constants/constants.dart';
import '../../util/constants/strings.dart';

class HostFlexTermsAndConditions extends StatefulWidget {

  static const String id = "hostFlexTermsAndConditions";
  const HostFlexTermsAndConditions({Key? key}) : super(key: key);

  @override
  State<HostFlexTermsAndConditions> createState() => _HostFlexTermsAndConditionsState();
}

class _HostFlexTermsAndConditionsState extends State<HostFlexTermsAndConditions> {

  /// bool value to hold the state of terms and condition
  bool _termsAndConditionsAccepted = false;

  /// bool value to hold the state of privacy policy
  bool _privacyPolicyAccepted = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        title: Text(
          AppStrings.hostAFlex,
          style: textTheme.headline4!.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
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
            Expanded(
              child: Container(
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
            ),
            const SizedBox(height: 24),
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
                value: _termsAndConditionsAccepted,
                onChanged: (value) {
                  setState(() {
                    _termsAndConditionsAccepted = !_termsAndConditionsAccepted;
                  });
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
                value: _privacyPolicyAccepted,
                onChanged: (value) {
                  setState(() {
                    _privacyPolicyAccepted = !_privacyPolicyAccepted;
                  });
                },
              ),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.center,
              child: Button(
                label: AppStrings.finish,
                onPressed: () {
                  if(_termsAndConditionsAccepted && _privacyPolicyAccepted == true){
                    Navigator.pushNamed(context, HostFlexSuccess.id);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
