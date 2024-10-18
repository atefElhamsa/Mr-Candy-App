import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_candy/core/shared_widgets/custom_button.dart';
import 'package:mr_candy/core/utils/app_colors.dart';
import 'package:mr_candy/core/utils/app_images.dart';
import 'package:mr_candy/core/utils/app_texts.dart';
import 'package:mr_candy/features/login/presentation/views/login_screen.dart';
import 'package:mr_candy/features/onboarding/presentation/data/model/onboarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingBody extends StatefulWidget {
  const OnboardingBody({super.key});

  @override
  State<OnboardingBody> createState() => _OnboardingBodyState();
}

class _OnboardingBodyState extends State<OnboardingBody> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset(
                  AppImages.rectangleOnboarding,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: MediaQuery.of(context).size.width * 0.27,
                  child: Image.asset(onboardings[index].image),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: MediaQuery.of(context).size.width * 0.05,
                  child: TextButton(
                    onPressed: () {
                      pageController.animateToPage(
                        onboardings.length - 1,
                        duration: const Duration(seconds: 1),
                        curve: Curves.decelerate,
                      );
                    },
                    child: Text(
                      index == onboardings.length - 1 ? "" : AppTexts.skip,
                      style: GoogleFonts.almarai(
                        textStyle: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Text(
              onboardings[index].title,
              style: GoogleFonts.almarai(
                textStyle: TextStyle(
                  color: AppColors.textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: MediaQuery.of(context).size.height * 0.03,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Text(
              onboardings[index].description,
              textAlign: TextAlign.center,
              style: GoogleFonts.almarai(
                textStyle: TextStyle(
                    color: AppColors.descriptionColor.withOpacity(0.7),
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.height * 0.02),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            SmoothPageIndicator(
              controller: pageController,
              count: onboardings.length,
              effect: WormEffect(
                activeDotColor: AppColors.indicator,
                dotHeight: MediaQuery.of(context).size.height * 0.015,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            CustomButton(
              titleButton: onboardings[index].titleButton,
              onTap: () {
                if (index == onboardings.length - 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LoginScreen();
                      },
                    ),
                  );
                } else {
                  pageController.animateToPage(
                    index + 1,
                    duration: const Duration(seconds: 1),
                    curve: Curves.decelerate,
                  );
                }
              },
            ),
          ],
        );
      },
      itemCount: onboardings.length,
    );
  }
}
