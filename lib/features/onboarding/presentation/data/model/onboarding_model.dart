import 'package:mr_candy/core/utils/app_images.dart';
import 'package:mr_candy/core/utils/app_texts.dart';

class OnboardingModel {
  final String image;
  final String title;
  final String description;
  final String titleButton;

  OnboardingModel({
    required this.image,
    required this.title,
    required this.description,
    required this.titleButton,
  });
}

List<OnboardingModel> onboardings = [
  OnboardingModel(
    image: AppImages.onboardingImage1,
    title: AppTexts.onboardingText1,
    description: AppTexts.descriptionOnboarding,
    titleButton: AppTexts.onboardingTitleButton1And2,
  ),
  OnboardingModel(
    image: AppImages.onboardingImage2,
    title: AppTexts.onboardingText2,
    description: AppTexts.descriptionOnboarding,
    titleButton: AppTexts.onboardingTitleButton1And2,
  ),
  OnboardingModel(
    image: AppImages.onboardingImage3,
    title: AppTexts.onboardingText3,
    description: AppTexts.descriptionOnboarding,
    titleButton: AppTexts.onboardingTitleButton3,
  ),
];
