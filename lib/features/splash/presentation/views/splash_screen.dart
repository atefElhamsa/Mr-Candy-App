import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mr_candy/core/utils/app_colors.dart';
import 'package:mr_candy/core/utils/app_images.dart';
import 'package:mr_candy/features/home/presentation/views/home_bottom_screen.dart';
import 'package:mr_candy/features/onboarding/presentation/views/onboarding_screen.dart';

import '../../../../core/utils/app_texts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(
        milliseconds: 350,
      ),
      () {
        navigateToLogin();
      },
    );
  }

  navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return Hive.box(AppTexts.nameOfBox).get("token") == null
            ? const OnboardingScreen()
            : const HomeBottomScreen();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.mainColorLinear1,
              AppColors.mainColorLinear2,
            ],
          ),
        ),
        child: Center(
          child: Image.asset(
            AppImages.splashImage,
            width: MediaQuery.of(context).size.width * 0.5,
          ),
        ),
      ),
    );
  }
}
