import 'package:flex_my_way/util/constants/constants.dart';
import 'package:flex_my_way/util/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import '../../components/app-bar.dart';
import '../../controllers/dashboard-controller.dart';
import '../../util/size-config.dart';

class Notifications extends StatelessWidget {

  static const String id = "notifications";
  Notifications({Key? key}) : super(key: key);

  /// calling the [DashboardController] for [Notifications]
  final DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: buildAppBar(context, textTheme, 'Notifications'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24),
          child: Column(
            children: const [
              NotificationButton(
                text: 'Please contact the customer care as we noticed an authorized access to your account\n'
                    'This is just pure testing of the new implementation that i just did....',
              ),
              NotificationButton(
                text: AppStrings.loremIpsum,
              ),
              NotificationButton(
                text: 'Please contact the customer care as we noticed an authorized access to your account',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationButton extends StatefulWidget {

  final String text;

  const NotificationButton({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<NotificationButton> createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {

  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() => _expanded = !_expanded);
          },
          child: AnimatedContainer(
            height: _expanded == true
              ? SizeConfig.screenHeight! * 0.17
              : SizeConfig.screenHeight! * 0.085,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(24.0),
            ),
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastOutSlowIn,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      widget.text,
                      style: const TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _expanded == false
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                      size: 21,
                      color: whiteColor,
                    ),
                    _expanded == true
                      ? Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: GestureDetector(
                            onTap: () {
                              print('delete notification');
                            },
                            child: const Icon(
                              IconlyBold.delete,
                              size: 19,
                              color: whiteColor,
                            ),
                          ),
                      )
                      : Container(),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

