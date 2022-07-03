import 'dart:async';
import 'dart:developer';
import 'package:flex_my_way/networking/flex-datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flex_my_way/util/util.dart';
import 'package:flex_my_way/controllers/controllers.dart';

class Flexery extends StatefulWidget {

  static const String id = "flexery";
  Flexery({Key? key}) : super(key: key);

  @override
  State<Flexery> createState() => _FlexeryState();
}

class _FlexeryState extends State<Flexery> {
  /// dynamic variable to hold an instance of flexDataSource
  var api = FlexDataSource();

  /// calling the user controller [UserController]
  final UserController userController = Get.find<UserController>();

  /// A [TextEditingController] to control the input text for search
  final TextEditingController searchController = TextEditingController();

  ///Function to get images by search
  void getFlexery(String? filter) async {
    userController.showSpinner.value = true;
    print(filter);
    await api.getFlexery(filter ?? 'time').then((value) {
      userController.showSpinner.value = false;
      print(value);
      if (filter == 'likes') {
        userController.flexeryFilter.value = 0;
      } else {
        userController.flexeryFilter.value = 1;
      }
    }).catchError((e) {
      userController.showSpinner.value = false;
      log(':::error: $e');
      Functions.showMessage(e.toString());
    });
  }

  @override
  void initState() {
    getFlexery('time');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(darkBackgroundImage),
              ),
            ),
            child: Obx(() {
                return Column(
                  children: [
                    const SizedBox(height: 50),
                    //appbar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Builder(
                            builder: (context) {
                              return CircleAvatar(
                                backgroundColor: whiteColor,
                                radius: 22,
                                child: TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.fromLTRB(12, 8, 6, 8),
                                    shape: const CircleBorder(),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    color: neutralColor,
                                    size: 22,
                                  ),
                                ),
                              );
                            }
                        ),
                        const SizedBox(width: 7),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: whiteColor,
                            ),
                            child: TextField(
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.search,
                                style: textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w600),
                                controller: searchController,
                                onChanged: (value) {
                                  getFlexeryByHashTag(value);
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.fromLTRB(5, 18, 5, 5),
                                  border: InputBorder.none,
                                  prefixIcon: Icon(
                                    IconlyLight.search,
                                    color: neutralColor.withOpacity(0.3),
                                    size: 16,
                                  ),
                                  hintText: 'Search flex hashtags',
                                  hintStyle: textTheme.bodyText1!.copyWith(
                                    fontSize: 13,
                                    color: neutralColor.withOpacity(0.3),
                                  ),
                                  suffixIcon: userController.showSearchSpinner.value == true
                                    ? SizedBox(
                                        width: 5,
                                        height: 5,
                                        child: SpinKitCircle(
                                          color: primaryColor.withOpacity(0.9),
                                          size: 25,
                                        ),
                                      )
                                    : const SizedBox(
                                        width: 2,
                                      height: 2,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 7),
                        CircleAvatar(
                          backgroundColor: whiteColor,
                          radius: 22,
                          child: TextButton(
                            onPressed: () {},
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
                        const SizedBox(width: 7),
                        CircleAvatar(
                          backgroundColor: whiteColor,
                          radius: 22,
                          child: TextButton(
                            onPressed: () {
                              _showFilterDialog(context);
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(10),
                              shape: const CircleBorder(),
                            ),
                            child: const Icon(
                              IconlyLight.filter2,
                              color: primaryColor,
                              size: 21,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    //body of media
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      spacing: 5,
                      runSpacing: 5,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showImageDialog(unsplashImage, context);
                          },
                          child: Container(
                            width: SizeConfig.screenWidth! * 0.3,
                            height: SizeConfig.screenHeight! * 0.155,
                            color: Colors.grey,
                            child: Image.asset(
                              unsplashImage,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.medium,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showImageDialog(hostImage, context);
                          },
                          child: Container(
                            width: SizeConfig.screenWidth! * 0.3,
                            height: SizeConfig.screenHeight! * 0.155,
                            color: Colors.grey,
                            child: Image.asset(
                              hostImage,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.medium,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showImageDialog(unsplashImage, context);
                          },
                          child: Container(
                            width: SizeConfig.screenWidth! * 0.3,
                            height: SizeConfig.screenHeight! * 0.155,
                            color: Colors.grey,
                            child: Image.asset(
                              unsplashImage,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.medium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }

  ///widget to show the dialog for image
  Future<void> _showImageDialog (String image, BuildContext context) {
    return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: '',
        transitionBuilder: (context, animation, secondaryAnimation, widget) {
          return Transform.translate(
            offset: Offset(0, 10 * animation.value),
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 15),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Icon(
                                Icons.close,
                                color: whiteColor,
                                size: 31,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight! * 0.7,
                            child: Image.asset(
                              image,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.medium,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent.withOpacity(0.1),
                      radius: 22,
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: whiteColor,
                        size: 21,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (context, animation1, animation2) {
          return Container();
        }
    );
  }

  ///widget to show the dialog for filter
  Future<void> _showFilterDialog (BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Container(
        margin: const EdgeInsets.all(60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.close,
                  color: whiteColor,
                  size: 31,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 21),
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: const Color(0xFFFFFFFF),
              ),
              child: Material(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Sort by',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Gilroy',
                      ),
                    ),
                    const SizedBox(height: 25),
                    InkWell(
                      onTap: () {
                        if (userController.flexeryFilter.value != 0) {
                          Get.back();
                          getFlexery('likes');
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        color: userController.flexeryFilter.value == 0
                            ? primaryColorVariant : transparentColor,
                        width: SizeConfig.screenWidth,
                        child: Center(
                          child: Text(
                            'Most Recent',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: userController.flexeryFilter.value == 0
                                  ? FontWeight.w600 : FontWeight.w500,
                              fontFamily: 'Gilroy',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    InkWell(
                      onTap: () {
                        if (userController.flexeryFilter.value != 1) {
                          Get.back();
                          getFlexery('time');
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        color: userController.flexeryFilter.value == 1
                          ? primaryColorVariant : transparentColor,
                        width: SizeConfig.screenWidth,
                        child: Center(
                          child: Text(
                            'Most Popular Flex',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: userController.flexeryFilter.value == 1
                                ? FontWeight.w600 : FontWeight.w500,
                              fontFamily: 'Gilroy',
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        width: SizeConfig.screenWidth,
                        child: const Center(
                          child: Text(
                            'Random',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Gilroy',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Timer? _debounce;

  ///Function to get images by search
  void getFlexeryByHashTag(String hashTag) {
    if (_debounce?.isActive ?? false) {
      print('here');
      _debounce?.cancel();
    } else {
      _debounce = Timer(const Duration(milliseconds: 800), () async {
        userController.showSearchSpinner.value = true;
       await api.getFlexeryByHashTag(hashTag).then((value) {
         userController.showSearchSpinner.value = false;
         print(value);
       }).catchError((e) {
         userController.showSearchSpinner.value = false;
         log(':::error: $e');
         Functions.showMessage(e.toString());
       });
      });
    }
  }
}

// ///List of pictures used in wrap
// final List<Widget> _pictureList = [
//   for (int i = 0; i < 8; i++){
//     return GestureDetector(
//       onTap: () {
//         _showImageDialog();
//       },
//       child: Container(
//         width: SizeConfig.screenWidth! * 0.28,
//         height: SizeConfig.screenHeight! * 0.13,
//         color: Colors.black.withOpacity(0.7),
//       ),
//     ),
//   }
// ];