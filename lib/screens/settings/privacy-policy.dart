import 'package:flutter/material.dart';
import '../../components/app-bar.dart';
import '../../util/constants/constants.dart';
import '../../util/constants/strings.dart';
import '../../util/size-config.dart';

class PrivacyPolicy extends StatelessWidget {

  static const String id = "privacyPolicy";
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: buildAppBar(context, textTheme, AppStrings.privacyPolicy),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight,
          padding: const EdgeInsets.fromLTRB(2, 24, 2, 10),
          decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(24)),
          child: RawScrollbar(
            thumbColor: primaryColor,
            radius: const Radius.circular(8.0),
            thickness: 4.0,
            isAlwaysShown: true,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 25, 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    HeadingText(textName: 'Privacy Policy and Terms of Use'),
                    SubHeadingText(textName: AppStrings.welcomeText),
                    HeadingText(textName: '1. Our commitment to your privacy'),
                    SubHeadingText(textNo: 'A.	', textName: AppStrings.section1A),
                    SubHeadingText(textNo: 'B.	', textName: AppStrings.section1B),
                    SizedBox(height: 10),

                    HeadingText(textName: '2. Definitions'),
                    SubHeadingText(textNo: '2.1.	', textName: AppStrings.sectionP21),
                    SubHeadingText(textNo: '2.1.1 	', textName: AppStrings.sectionP211),
                    SubHeadingText(textNo: '2.1.2	', textName: AppStrings.sectionP212),
                    SubHeadingText(textNo: '2.1.3	', textName: AppStrings.sectionP213),
                    SizedBox(height: 10),

                    HeadingText(textName: '3. What Data does the Company collect and why? '),
                    SubHeadingText(textNo: '3.1.  ', textName: AppStrings.section3),
                    SizedBox(height: 10),

                    HeadingText(textName: '4. Obtaining consent '),
                    SubHeadingText(textNo: '4.1.	', textName: AppStrings.sectionP41),
                    SubHeadingText(textNo: '4.2.	', textName: AppStrings.sectionP42),
                    SizedBox(height: 10),
                    
                    HeadingText(textName: '5. Use and disclosure of your data'),
                    SubHeadingText(textNo: '5.1.	', textName: AppStrings.sectionP51),
                    SubHeadingText(textNo: '5.2.	', textName: AppStrings.sectionP52),
                    SubHeadingText(textNo: '5.3.	', textName: AppStrings.sectionP53),
                    SubHeadingText(textNo: '5.4.	', textName: AppStrings.sectionP54),

                    SizedBox(height: 10),

                    HeadingText(textName: '6. Data Accuracy'),
                    SubHeadingText(textNo: '6.1.	', textName: AppStrings.sectionP61),
                    SizedBox(height: 10),

                    HeadingText(textName: '7. Retention of personal data'),
                    SubHeadingText(textNo: '7.1.	', textName: AppStrings.sectionP71),
                    SizedBox(height: 10),
                    
                    HeadingText(textName: '8. Your rights in relation to your personal data'),
                    SubHeadingText(textNo: '8.1.	', textName: AppStrings.sectionP81),
                    SubHeadingText(textNo: '8.2.	', textName: AppStrings.sectionP82),
                    SubHeadingText(textNo: '8.3.	', textName: AppStrings.sectionP83),
                    SubHeadingText(textNo: '8.4.	', textName: AppStrings.sectionP84),
                    SubHeadingText(textNo: '8.5.	', textName: AppStrings.sectionP85),
                    SubHeadingText(textNo: '8.6.	', textName: AppStrings.sectionP86),
                    SubHeadingText(textNo: '8.7.	', textName: AppStrings.sectionP87),
                    SizedBox(height: 10),
                    
                    HeadingText(textName: '9. Security'),
                    SubHeadingText(textNo: '9.1.	', textName: AppStrings.sectionP91),
                    SubHeadingText(textNo: '9.2.1 	', textName: AppStrings.sectionP921),
                    SubHeadingText(textNo: '9.2.2 	', textName: AppStrings.sectionP922),
                    SubHeadingText(textNo: '9.2.3 	', textName: AppStrings.sectionP923),
                    SubHeadingText(textNo: '9.2.4 	', textName: AppStrings.sectionP924),
                    SizedBox(height: 10),

                    HeadingText(textName: '10.	Cookies'),
                    SubHeadingText(textNo: '10.1.	', textName: AppStrings.sectionP101),
                    SubHeadingText(textNo: '10.2.	', textName: AppStrings.sectionP102),
                    SizedBox(height: 10),

                    HeadingText(textName: '11. Third-Party Websites'),
                    SubHeadingText(textNo: '11.1.	', textName: AppStrings.sectionP111),
                    SubHeadingText(textNo: '11.2.	', textName: AppStrings.sectionP112),
                    SubHeadingText(textNo: '11.3.	', textName: AppStrings.sectionP113),
                    SizedBox(height: 10),

                    HeadingText(textName: '12.	Updating of Privacy Policy '),
                    SubHeadingText(textNo: '12.1.	', textName: AppStrings.sectionP1221),
                    SubHeadingText(textNo: '12.2.	', textName: AppStrings.sectionP1222),
                    SizedBox(height: 10),

                    HeadingText(textName: 'Website Privacy Policy Changes '),
                    SubHeadingText(textName: AppStrings.sectionWebUpdate),
                    SizedBox(height: 40),
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

  const HeadingText({ 
    Key? key,
    this.textName = ''
  }) : super(key: key);

  final String textName;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          textName,
          style: textTheme.headline5!.copyWith(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class SubHeadingText extends StatelessWidget {

  const SubHeadingText({ 
    Key? key,
    this.textName = '',
    this.textNo = ''
  }) : super(key: key);

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
              style: textTheme.headline5!.copyWith(
                fontSize: 14, 
                fontWeight: FontWeight.w400,
              ),
            ),
            Expanded(
              child: Text(
                textName,
                style: textTheme.headline5!.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5.5),
      ],
    );
  }
}