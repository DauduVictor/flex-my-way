import 'package:flex_my_way/util/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../../util/size-config.dart';
import '../dashboard/drawer.dart';

class Flexery extends StatefulWidget {

  static const String id = "flexery";
  const Flexery({Key? key}) : super(key: key);

  @override
  _FlexeryState createState() => _FlexeryState();
}

class _FlexeryState extends State<Flexery> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      drawer: const RefactoredDrawer(),
      body: SingleChildScrollView(
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
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(5, 15, 5, 5),
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
                        _showFilterDialog();
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
            ],
          ),
        ),
      ),
    );
  }
  ///widget to show the dialog for filter
  Future<void> _showFilterDialog () {
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
              padding: const EdgeInsets.fromLTRB(16, 30, 16, 21),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: const Color(0xFFFFFFFF),
              ),
              child: Material(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Turn On notifications',
                      style: TextStyle(
                        color: Color(0xFF001140),
                        fontWeight: FontWeight.w600,
                        fontSize: 23,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(15, 8, 15, 20),
                      child: Text(
                        'You will get updates when important events happen',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF001140),
                          fontWeight: FontWeight.normal,
                          fontSize: 18.5,
                        ),
                      ),
                    ),
                    /// update button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          ),
                          child: const Text(
                            'Not Now',
                            style: TextStyle(
                              fontSize: 19,
                              color: Color(0xFF4F5877),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () { },
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF4D84FF),
                            onSurface: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          ),
                          child: const Text(
                            'Turn On',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
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
