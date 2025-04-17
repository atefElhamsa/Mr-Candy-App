import 'package:easy_localization/easy_localization.dart';
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
    title: "onboardingText1".tr(),
    description: "descriptionOnboarding".tr(),
    titleButton: "onboardingTitleButton1And2".tr(),
  ),
  OnboardingModel(
    image: AppImages.onboardingImage2,
    title: "onboardingText2".tr(),
    description: "descriptionOnboarding".tr(),
    titleButton: "onboardingTitleButton1And2".tr(),
  ),
  OnboardingModel(
    image: AppImages.onboardingImage3,
    title: "onboardingText3".tr(),
    description: "descriptionOnboarding".tr(),
    titleButton: "onboardingTitleButton3".tr(),
  ),
];
