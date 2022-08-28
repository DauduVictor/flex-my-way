import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flex_my_way/networking/flex-datasource.dart';
import 'package:flex_my_way/screens/flex-media/upload-image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flex_my_way/util/util.dart';
import 'package:flex_my_way/controllers/controllers.dart';
import 'package:flex_my_way/model/model.dart';
import 'package:flex_my_way/components/components.dart';

class Flexery extends StatefulWidget {

  static const String id = "flexery";
  const Flexery({Key? key}) : super(key: key);

  @override
  State<Flexery> createState() => _FlexeryState();
}

class _FlexeryState extends State<Flexery> {
  /// dynamic variable to hold an instance of flexDataSource
  var api = FlexDataSource();

  /// calling the user controller [UserController]
  final FlexeryController controller = Get.put(FlexeryController());

  @override
  void initState() {
    controller.getFlexery('times');
    super.initState();
  }

  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: DismissKeyboard(
        child: SingleChildScrollView(
          child: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            padding: const EdgeInsets.symmetric(horizontal: 4),
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
                                controller: controller.searchController,
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
                                  suffixIcon: controller.showSearchSpinner.value == true
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: const Duration(milliseconds: 500),
                                  pageBuilder: (context, animation, secondaryAnimation) {
                                    return UploadImage();
                                  },
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    return Container(
                                      color: whiteColor.withOpacity(animation.value),
                                      child: SlideTransition(
                                        position: animation.drive(
                                          Tween(
                                            begin: const Offset(0.0, 1.0),
                                            end: Offset.zero,
                                          ).chain(CurveTween(curve: Curves.linear)),
                                        ),
                                        child: child,
                                      ),
                                    );
                                  },
                                ),
                              );
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
                    controller.showSpinner.value == false
                     ? Expanded(
                        child: GridView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                _showImageDialog(
                                  controller.flexery.value,
                                  index,
                                  context
                                );
                              },
                              child: Container(
                                color: Colors.grey.withOpacity(0.3),
                                child: CachedNetworkImage(
                                  alignment: Alignment.topCenter,
                                  imageUrl: controller.flexery[index].url!,
                                  progressIndicatorBuilder: (context, url, downloadProgress) {
                                    return SpinKitCircle(
                                      color: primaryColor.withOpacity(0.7),
                                      size: 30,
                                    );
                                  },
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.error,
                                    color: neutralColor.withOpacity(0.4),
                                    size: 30,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                          itemCount: controller.flexery.length,
                          padding: const EdgeInsets.only(bottom: 12),
                          shrinkWrap: true,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.6,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                          ),
                        ),
                      )
                     : Column(
                       children: [
                         SizedBox(height: SizeConfig.screenHeight! * 0.35),
                         SpinKitCircle(
                          color: primaryColor.withOpacity(0.9),
                          size: 45,
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
  Future<void> _showImageDialog (List<FlexeryModel> flexery, int position, BuildContext context) {
    // var rng = Random();
    // int randomInt = rng.nextInt(flexery.length -1);
    return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: '',
        barrierColor: neutralColor.withOpacity(0.4),
        transitionBuilder: (context, animation, secondaryAnimation, widget) {
          return Transform.translate(
            offset: Offset(0, 10 * animation.value),
            child: StatefulBuilder(
              builder: (context, stateSetter) {
                return Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 2),
                      child: Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Align(
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
                              ),
                              const SizedBox(height: 15),
                              CarouselSlider(
                                options: CarouselOptions(
                                  initialPage: position,
                                  autoPlay: false,
                                  viewportFraction: 1,
                                  height: SizeConfig.screenHeight! * 0.77,
                                ),
                                items: flexery.map((e) {
                                  return Column(
                                    children: [
                                      CachedNetworkImage(
                                        alignment: Alignment.topCenter,
                                        imageUrl: e.url!,
                                        progressIndicatorBuilder: (context, url, downloadProgress) {
                                          return SpinKitCircle(
                                            color: primaryColor.withOpacity(0.7),
                                            size: 30,
                                          );
                                        },
                                        errorWidget: (context, url, error) => Icon(
                                          Icons.error,
                                          color: neutralColor.withOpacity(0.4),
                                          size: 30,
                                        ),
                                        height: SizeConfig.screenHeight! * 0.7,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(height: 10),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Material(
                                          color: transparentColor,
                                          child: Text(
                                            e.hashtag!,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: whiteColor,
                                              letterSpacing: 1.2,
                                              fontSize: 24,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    /*Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          if (position < flexery.length -1) {
                            stateSetter(() {
                              position += 1;
                            });
                          }
                        },
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
                    ),*/
                  ],
                );
              }
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
                        if (controller.flexeryFilter.value != 0) {
                          Get.back();
                          controller.getFlexery('likes');
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        color: controller.flexeryFilter.value == 0
                            ? primaryColorVariant : transparentColor,
                        width: SizeConfig.screenWidth,
                        child: Center(
                          child: Text(
                            'Most Recent',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: controller.flexeryFilter.value == 0
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
                        if (controller.flexeryFilter.value != 1) {
                          Get.back();
                          controller.getFlexery('time');
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        color: controller.flexeryFilter.value == 1
                          ? primaryColorVariant : transparentColor,
                        width: SizeConfig.screenWidth,
                        child: Center(
                          child: Text(
                            'Most Popular Flex',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: controller.flexeryFilter.value == 1
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

  ///Function to get images by search
  void getFlexeryByHashTag(String hashTag) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 800), () async {
      controller.showSearchSpinner.value = true;
      await api.getFlexeryByHashTag(hashTag).then((value) {
        controller.showSearchSpinner.value = false;
        controller.flexery.clear();
        controller.flexery.value = value;
      }).catchError((e) {
        controller.showSearchSpinner.value = false;
        print(':::error: $e');
        Functions.showMessage(e.toString());
      });
    });
  }
}