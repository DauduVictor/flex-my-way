import 'package:flex_my_way/util/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../../util/size-config.dart';
import '../dashboard/drawer.dart';

class Flexery extends StatelessWidget {

  static const String id = "flexery";
  const Flexery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      drawer: const RefactoredDrawer(),
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
            child: Column(
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
                                FocusScopeNode currentFocus = FocusScope.of(context);
                                if(!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
                                Scaffold.of(context).openDrawer();
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(8),
                                shape: const CircleBorder(),
                              ),
                              child: const Icon(
                                Icons.menu_rounded,
                                color: neutralColor,
                                size: 24,
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
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        width: SizeConfig.screenWidth,
                        child: const Center(
                          child: Text(
                            'Most Recent',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
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
                        color: primaryColorVariant,
                        width: SizeConfig.screenWidth,
                        child: const Center(
                          child: Text(
                            'Most Popular Flex',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
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