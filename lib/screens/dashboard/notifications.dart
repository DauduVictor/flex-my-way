import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flex_my_way/util/util.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../components/app-bar.dart';
import 'package:flex_my_way/controllers/controllers.dart';
import '../../networking/user-datasource.dart';
import '../../util/size-config.dart';

class Notifications extends StatelessWidget {

  static const String id = "notifications";
  Notifications({Key? key}) : super(key: key);

  /// calling the user controller [UserController]
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Obx(() {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: backgroundColor,
              appBar: buildAppBar(context, textTheme, 'Notifications'),
              body: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24),
                child: userController.notification.isEmpty
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          empty,
                          width: 70,
                          height: 70,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'You have no new notifications',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  )
                  : ListView.builder(
                      itemCount: userController.notification.length,
                      itemBuilder: (BuildContext context, int index) {
                        return NotificationButton(
                          text: userController.notification[index].message!,
                          id: userController.notification[index].id!,
                          index: index,
                        );
                      },
                    ),
              ),
            ),
            userController.showNotificationSpinner.value == true
              ? Container(
                  child: AbsorbPointer(
                    absorbing: userController.showNotificationSpinner.value,
                    child: SpinKitCircle(
                      color: primaryColor.withOpacity(0.9),
                      size: 65,
                    ),
                  ),
                  color: userController.showNotificationSpinner.value == true
                      ? whiteColor.withOpacity(0.2)
                      : transparentColor,
                )
              : Container(),
          ],
        );
      }
    );
  }
}

class NotificationButton extends StatefulWidget {

  final String text;
  final String id;
  final int index;

  const NotificationButton({
    Key? key,
    required this.text,
    required this.id,
    required this.index,
  }) : super(key: key);

  @override
  State<NotificationButton> createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {

  /// calling the user controller [UserController]
  final UserController userController = Get.find<UserController>();

  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        Dismissible(
          key: Key(widget.id),
          onDismissed: (direction) {
            _deleteNotification(widget.id, widget.index);
          },
          background: Container(
            height: SizeConfig.screenHeight! * 0.05,
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(
                  IconlyBold.delete,
                  size: 19,
                  color: primaryColor,
                ),
                Icon(
                  IconlyBold.delete,
                  size: 19,
                  color: primaryColor,
                ),
              ],
            ),
          ),
          child: GestureDetector(
            onTap: () {
              setState(() => _expanded = !_expanded);
            },
            child: AnimatedContainer(
              height: _expanded == true
                ? SizeConfig.screenHeight! * 0.13
                : SizeConfig.screenHeight! * 0.085,
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(24.0),
              ),
              duration: const Duration(milliseconds: 400),
              curve: Curves.fastOutSlowIn,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.text,
                      style: const TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  const SizedBox(width: 7),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                log('delete notification');
                                _deleteNotification(widget.id, widget.index);
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
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  void _deleteNotification(String id, int index) async {
    userController.showNotificationSpinner.value = true;
    var api = UserDataSource();
    userController.notification.removeAt(index);
    await api.deleteNotification(id).then((value) {
      userController.showNotificationSpinner.value = false;
      Functions.showMessage('Notification deleted successfully');
    }).catchError((e) {
      userController.showNotificationSpinner.value = false;
      Functions.showMessage(e);
      log(e);
    });
  }

}

