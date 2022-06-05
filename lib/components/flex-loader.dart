import 'package:flutter/material.dart';
import '../util/constants/constants.dart';
import '../util/size-config.dart';

class FlexLoader extends StatefulWidget{

  const FlexLoader({Key? key}) : super(key: key);
  @override
  State<FlexLoader> createState() => _FlexLoaderState();
}

class _FlexLoaderState extends State<FlexLoader>  with TickerProviderStateMixin {

  /// Declaring the animation controller for the animation
  late AnimationController _animationController;

  /// Variable to hold the tween animation
  late Animation<double> _glowingAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    super.initState();

    /// setting the [_glowingAnimation] as a tween value
    _glowingAnimation = Tween(begin: 0.05, end: 0.15).animate(CurvedAnimation(
      curve: Curves.slowMiddle,
      parent: _animationController
    ));

    /// animation to repeat and reverse set to true
    _animationController.repeat(reverse: false);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, _) {
        final textTheme = Theme.of(context).textTheme;
        SizeConfig().init(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 21,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: neutralColor.withOpacity(_glowingAnimation.value),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 21,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: neutralColor.withOpacity(_glowingAnimation.value),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: SizeConfig.screenWidth! * 0.2),
                  Container(
                    width: SizeConfig.screenWidth! * 0.2,
                    height: SizeConfig.screenHeight! * 0.097,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(23),
                      color: neutralColor.withOpacity(_glowingAnimation.value),
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
                        Container(
                          height: 21,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: neutralColor.withOpacity(_glowingAnimation.value),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 21,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: neutralColor.withOpacity(_glowingAnimation.value),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: SizeConfig.screenWidth! * 0.18),
                  Container(
                    width: SizeConfig.screenWidth! * 0.38,
                    height: SizeConfig.screenHeight! * 0.075,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: neutralColor.withOpacity(_glowingAnimation.value),
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
                      Container(
                        height: 21,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: neutralColor.withOpacity(_glowingAnimation.value),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 21,
                        width: 78,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: neutralColor.withOpacity(_glowingAnimation.value),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 21,
                        width: SizeConfig.screenWidth! * 0.28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: neutralColor.withOpacity(_glowingAnimation.value),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: SizeConfig.screenWidth! * 0.19,
                    height: SizeConfig.screenHeight! * 0.085,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: neutralColor.withOpacity(_glowingAnimation.value),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              //about
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 21,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: neutralColor.withOpacity(_glowingAnimation.value),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 21,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: neutralColor.withOpacity(_glowingAnimation.value),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 21,
                    width: SizeConfig.screenWidth! * 0.65,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: neutralColor.withOpacity(_glowingAnimation.value),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 21,
                    width: SizeConfig.screenWidth! * 0.35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: neutralColor.withOpacity(_glowingAnimation.value),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //guest
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 21,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: neutralColor.withOpacity(_glowingAnimation.value),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 21,
                        width: SizeConfig.screenWidth! * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: neutralColor.withOpacity(_glowingAnimation.value),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  //provided
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 21,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: neutralColor.withOpacity(_glowingAnimation.value),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 21,
                        width: SizeConfig.screenWidth! * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: neutralColor.withOpacity(_glowingAnimation.value),
                        ),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 21,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: neutralColor.withOpacity(_glowingAnimation.value),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 21,
                        width: SizeConfig.screenWidth! * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: neutralColor.withOpacity(_glowingAnimation.value),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  //rsvp
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 21,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: neutralColor.withOpacity(_glowingAnimation.value),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 21,
                        width: SizeConfig.screenWidth! * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: neutralColor.withOpacity(_glowingAnimation.value),
                        ),
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
                  color: neutralColor.withOpacity(_glowingAnimation.value),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      }, animation: _animationController,
    );
  }
}
