import 'package:flutter/material.dart';
import '../../util/constants/constants.dart';
import '../../util/size-config.dart';

class FlexHistoryDetail extends StatefulWidget {

  static const String id = "flexHistoryDetail";
  const FlexHistoryDetail({Key? key}) : super(key: key);

  @override
  _FlexHistoryDetailState createState() => _FlexHistoryDetailState();
}

class _FlexHistoryDetailState extends State<FlexHistoryDetail> {

  showFlexPartyDetail(TextTheme textTheme) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      barrierColor: transparent,
      builder: (BuildContext context) {
        return Container(
          height: SizeConfig.screenHeight! - 200,
          width: SizeConfig.screenWidth,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 25),
          decoration:  const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: backgroundColor,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Afro Nation Festival',
                      style: textTheme.headline4!.copyWith(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 26),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(23),
                      color: whiteColor,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'DEC',
                          style: textTheme.headline5!.copyWith(
                            color: primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '25',
                          style: textTheme.headline5!.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        color: Colors.green,
        child: Column(
          children: [
            const SizedBox(height: 50),
            //appbar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: whiteColor,
                  radius: 22,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(left: 8),
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: neutralColor,
                      size: 22,
                    ),
                  ),
                ),
                Hero(
                  tag: 'cameraButton',
                  child: CircleAvatar(
                    backgroundColor: whiteColor,
                    radius: 22,
                    child: TextButton(
                      onPressed: () {
                        showFlexPartyDetail(textTheme);
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(12),
                        shape: const CircleBorder(),
                      ),
                      child: const Icon(
                        Icons.linked_camera_outlined,
                        color: primaryColor,
                        size: 21,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //body
          ],
        ),
      ),
    );
  }
}
