import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ssignup_login/constants/image_string.dart';
import 'package:ssignup_login/statess/flash_screen_controller.dart';
import '../../constants/text_strings.dart';

class Splashh extends StatelessWidget {
  Splashh({super.key});

  final splashController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    splashController.startAnimation(); // Start animation on screen load
    return Scaffold(
      body: Stack(
        children: [
          // Top Icon
          Align(
            alignment: const Alignment(0, -0.8),
            child: Image.asset(tSplashTopIcon),
          ),

          // Tagline Text
          Align(
            alignment: const Alignment(0, -0.4),
            child: Text(
              appNameTagLine,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Main Icon with Animation
          Obx(() => AnimatedPositioned(
            duration: const Duration(milliseconds: 1600),
            bottom: splashController.animate.value ? 40 : 170,
            left: splashController.animate.value ? 0 : -100,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 1600),
              opacity: splashController.animate.value ? 1 : 0,
              child: Image.asset(
                tMainIcon,
                width: 400,
              ),
            ),
          )),
        ],
      ),
    );
  }
}
