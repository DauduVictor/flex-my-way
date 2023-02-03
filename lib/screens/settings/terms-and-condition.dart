import 'package:flutter/material.dart';
import '../../components/app-bar.dart';
import '../../util/constants/constants.dart';
import '../../util/constants/strings.dart';
import '../../util/size-config.dart';

class TermsAndCondition extends StatelessWidget {

  static const String id = 'termsAndCondition';
  const TermsAndCondition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: buildAppBar(context, textTheme, AppStrings.termsAndConditions),
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
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    HeadingText(textName: '1. Introduction'),
                    SubHeadingText(textNo: '1.1.	', textName: AppStrings.section11),
                    SubHeadingText(textNo: '1.2.	', textName: AppStrings.section12),
                    SubHeadingText(textNo: '1.3.	', textName: AppStrings.section13),
                    SubHeadingText(textNo: '1.4.	', textName: AppStrings.section14),
                    SizedBox(height: 10),

                    HeadingText(textName: '2. Definitions'),
                    SubHeadingText(textNo: '2.1.	', textName: AppStrings.section21),
                    SubHeadingText(textNo: '2.1.1 	', textName: AppStrings.section211),
                    SubHeadingText(textNo: '2.1.2	', textName: AppStrings.section212),
                    SubHeadingText(textNo: '2.1.3	', textName: AppStrings.section213),
                    SizedBox(height: 10),

                    HeadingText(textName: '3. Limitation of Liability'),
                    SubHeadingText(textNo: '3.1.	', textName: AppStrings.section31),
                    SizedBox(height: 10),

                    HeadingText(textName: '4. Relationship of the parties'),
                    SubHeadingText(textNo: '4.1.	', textName: AppStrings.section41),
                    SubHeadingText(textNo: '4.1.1 	', textName: AppStrings.section411),
                    SubHeadingText(textNo: '4.1.2	', textName: AppStrings.section412),
                    SubHeadingText(textNo: '4.1.3	', textName: AppStrings.section413),
                    SubHeadingText(textNo: '4.1.4	', textName: AppStrings.section414),
                    SubHeadingText(textNo: '4.2.	', textName: AppStrings.section42),
                    SubHeadingText(textNo: '4.3.	', textName: AppStrings.section43),
                    SubHeadingText(textNo: '4.3.1 	', textName: AppStrings.section431),
                    SubHeadingText(textNo: '4.3.2	', textName: AppStrings.section432),
                    SubHeadingText(textNo: '4.3.3	', textName: AppStrings.section433),
                    SubHeadingText(textNo: '4.3.4	', textName: AppStrings.section434),
                    SubHeadingText(textNo: '4.4.	', textName: AppStrings.section44),
                    SizedBox(height: 10),
                    
                    HeadingText(textName: '5. Amendment'),
                    SubHeadingText(textNo: '5.1.	', textName: AppStrings.section51),
                    SizedBox(height: 10),

                    HeadingText(textName: '6. Account Information and useage'),
                    SubHeadingText(textNo: '6.1.	', textName: AppStrings.section61),
                    SubHeadingText(textNo: '6.2.	', textName: AppStrings.section62),
                    SubHeadingText(textNo: '6.3.	', textName: AppStrings.section63),
                    SizedBox(height: 10),

                    HeadingText(textName: '7. Indemnity'),
                    SubHeadingText(textNo: '7.1.	', textName: AppStrings.section71),
                    SubHeadingText(textNo: '7.2.	', textName: AppStrings.section72),
                    SizedBox(height: 10),
                    
                    HeadingText(textName: '8. Disclaimer and Warranty'),
                    SubHeadingText(textNo: '8.1.	', textName: AppStrings.section71),
                    SubHeadingText(textNo: '8.1.1 	', textName: AppStrings.section811),
                    SubHeadingText(textNo: '8.1.2 	', textName: AppStrings.section812),
                    SubHeadingText(textNo: '8.1.3 	', textName: AppStrings.section813),
                    SubHeadingText(textNo: '8.2.	', textName: AppStrings.section82),
                    SubHeadingText(textNo: '8.3.	', textName: AppStrings.section84),
                    SubHeadingText(textNo: '8.4.	', textName: AppStrings.section82),
                    SizedBox(height: 10),
                    
                    HeadingText(textName: '9. Termination'),
                    SubHeadingText(textNo: '9.1.	', textName: AppStrings.section71),
                    SubHeadingText(textNo: '9.1.1 	', textName: AppStrings.section911),
                    SubHeadingText(textNo: '9.1.2 	', textName: AppStrings.section912),
                    SubHeadingText(textNo: '9.1.3 	', textName: AppStrings.section913),
                    SubHeadingText(textNo: '9.1.4 	', textName: AppStrings.section914),
                    SizedBox(height: 10),

                    HeadingText(textName: '10. Severability'),
                    SubHeadingText(textNo: '10.1.	', textName: AppStrings.section101),
                    SubHeadingText(textNo: '10.1.	', textName: AppStrings.section102),
                    SubHeadingText(textNo: '10.1.	', textName: AppStrings.section103),
                    SizedBox(height: 10),

                    HeadingText(textName: '11. Governing Law and Dispute'),
                    SubHeadingText(textNo: '11.1.	', textName: AppStrings.section111),
                    SizedBox(height: 10),

                    HeadingText(textName: '12. Entire Agreement'),
                    SubHeadingText(textNo: '12.1.	', textName: AppStrings.section1221),
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
          style: textTheme.headlineSmall!.copyWith(fontSize: 17, fontWeight: FontWeight.w600),
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
              style: textTheme.headlineSmall!.copyWith(
                fontSize: 14, 
                fontWeight: FontWeight.w400,
              ),
            ),
            Expanded(
              child: Text(
                textName,
                style: textTheme.headlineSmall!.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5.5),
      ],
    );
  }
}
