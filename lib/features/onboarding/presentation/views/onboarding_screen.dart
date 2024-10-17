import 'package:flutter/material.dart';
import 'package:mr_candy/features/onboarding/presentation/views/widgets/onboarding_body.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OnboardingBody(),
    );
  }
}
