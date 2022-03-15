import 'package:flex_my_way/util/constants/strings.dart';
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(unsplashImage),
                fit: BoxFit.cover,
              ),
            ),
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
          DraggableScrollableSheet(
            minChildSize: 0.4,
            maxChildSize: 0.7,
            builder: (context, controller) {
              return Container(
                // height: SizeConfig.screenHeight! * 0.6,
                width: SizeConfig.screenWidth,
                decoration:  const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: backgroundColor,
                ),
                child: SingleChildScrollView(
                  controller: controller,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Afro Nation Festival',
                                style: textTheme.headline4!.copyWith(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 30,
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
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Time',
                                    style: textTheme.bodyText1!.copyWith(
                                      fontSize: 16,
                                      color: neutralColor.withOpacity(0.5),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    '1:00PM - 1:00AM',
                                    style: textTheme.bodyText1!.copyWith(
                                      fontSize: 18.5,
                                      color: neutralColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFFE9EEF4),
                                padding: const EdgeInsets.symmetric(vertical: 21, horizontal: 26),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Text(
                                'Join this flex',
                                style: textTheme.button!.copyWith(
                                  color: whiteColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.host,
                                  style: textTheme.headline5!.copyWith(
                                    color: neutralColor.withOpacity(0.5),
                                    fontSize: 16.5,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Kelechi Mo.',
                                  style: textTheme.bodyText1!.copyWith(
                                    fontSize: 18.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'First Time Hoster',
                                  style: textTheme.headline5!.copyWith(
                                    color: primaryColor,
                                    fontSize: 16.5,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: const DecorationImage(
                                  image: AssetImage(hostImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        //about
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'About/Rules',
                              style: textTheme.bodyText1!.copyWith(
                                fontSize: 18.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                                  'Amet lorem tellus viverra venenatis dui id vitae phasellus odio. '
                                  'Viverra diam venenatis aliquet imperdiet ultrices nullam gravida viverra faucibus.'
                                  ' Donec varius tortor mauris gravida sed amet ligula tempus.',
                              style: textTheme.headline5!.copyWith(fontSize: 16.5),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //guest
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Guests',
                                    style: textTheme.bodyText1!.copyWith(
                                      fontSize: 18.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '100/200 Total',
                                    style: textTheme.headline5!.copyWith(fontSize: 16.5),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            //provided
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Food & Drinks',
                                  style: textTheme.bodyText1!.copyWith(
                                    fontSize: 18.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Will be Provided',
                                  style: textTheme.headline5!.copyWith(fontSize: 16.5),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //nature of flex
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nature of Flex',
                                    style: textTheme.bodyText1!.copyWith(
                                      fontSize: 18.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Beach Flex',
                                    style: textTheme.headline5!.copyWith(fontSize: 16.5),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            //rsvp
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'RSVP',
                                  style: textTheme.bodyText1!.copyWith(
                                    fontSize: 18.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '+234 706 197 2722',
                                  style: textTheme.headline5!.copyWith(fontSize: 16.5),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        Container(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight! * 0.25,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 3),
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.content_copy_outlined,
                                  color: primaryColor,
                                  size: 12,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Click to Copy Address',
                                  style: textTheme.headline5!.copyWith(
                                    color: primaryColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
          }),
        ],
      ),
    );
  }
}
