import 'package:flex_my_way/components/app-bar.dart';
import 'package:flex_my_way/util/util.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EulaPolicy extends StatelessWidget {
  static const String id = "eulaPolicy";
  const EulaPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: buildAppBar(context, textTheme, 'Eula Policy'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.fromLTRB(2, 21, 2, 5),
          decoration: BoxDecoration(
              color: whiteColor, borderRadius: BorderRadius.circular(24)),
          child: RawScrollbar(
            thumbColor: primaryColor,
            radius: const Radius.circular(8.0),
            thickness: 4.0,
            thumbVisibility: true,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 25, 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeadingText(
                        textName: 'End User License Agreement (EULA)'),
                    const SubHeadingText(textName: AppStrings.eWelcomeText),
                    const HeadingText(textName: '1. License Grant'),
                    const SubHeadingText(textName: AppStrings.sectionE1),
                    const SizedBox(height: 10),
                    const HeadingText(textName: '2. User Obligations'),
                    const SubHeadingText(
                        textNo: '2.1.	', textName: AppStrings.sectionE21),
                    const SubHeadingText(
                        textNo: '2.2 	', textName: AppStrings.sectionE22),
                    const SubHeadingText(
                        textNo: '2.3	', textName: AppStrings.sectionE23),
                    const SizedBox(height: 10),
                    const HeadingText(
                        textName: '3. Intellectual Property Rights'),
                    const SubHeadingText(textName: AppStrings.sectionE3),
                    const SizedBox(height: 10),
                    const HeadingText(textName: '4. Support and Maintenance'),
                    const SubHeadingText(textName: AppStrings.sectionE4),
                    const SizedBox(height: 10),
                    const HeadingText(textName: '5. Disclaimer of Warranties'),
                    const SubHeadingText(textName: AppStrings.sectionE5),
                    const SizedBox(height: 10),
                    const HeadingText(textName: '6. Limitation of Liability'),
                    const SubHeadingText(textName: AppStrings.sectionE6),
                    const SizedBox(height: 10),
                    const HeadingText(
                        textName: '7. Retention of personal data'),
                    const SubHeadingText(textName: AppStrings.sectionE7),
                    const SizedBox(height: 10),
                    const HeadingText(
                        textName: '8. Governing Law and Jurisdiction'),
                    const SubHeadingText(textName: AppStrings.sectionE8),
                    const SizedBox(height: 10),
                    const HeadingText(textName: '9.  Contact Information'),
                    const SubHeadingText(textName: AppStrings.sectionE9),
                    const SizedBox(height: 10),
                    const SubHeadingText(
                        textName: 'Company Name: Stmayorz Intl Ltd'),
                    const SubHeadingText(textName: 'Country: Nigeria'),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Contact: ',
                          style: textTheme.headlineSmall!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '+2349023130910',
                            style: textTheme.headlineSmall!.copyWith(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w400,
                                color: primaryColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Email: ',
                          style: textTheme.headlineSmall!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'support@flexmyway.com',
                          style: textTheme.headlineSmall!.copyWith(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w400,
                              color: primaryColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const SubHeadingText(
                        textName: AppStrings.installingSoftware),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HeadingText extends StatelessWidget {
  const HeadingText({Key? key, this.textName = ''}) : super(key: key);

  final String textName;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          textName,
          style: textTheme.headlineSmall!
              .copyWith(fontSize: 17.5, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class SubHeadingText extends StatelessWidget {
  const SubHeadingText({Key? key, this.textName = '', this.textNo = ''})
      : super(key: key);

  final String textName;
  final String textNo;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              textNo,
              style: textTheme.headlineSmall!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            Expanded(
              child: Text(
                textName,
                style: textTheme.headlineSmall!
                    .copyWith(fontSize: 14.5, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5.5),
      ],
    );
  }
}
