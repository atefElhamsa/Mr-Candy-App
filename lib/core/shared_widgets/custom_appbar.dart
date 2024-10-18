import 'package:flutter/material.dart';
import 'package:mr_candy/core/utils/app_images.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        Image.asset(
          AppImages.splashImage,
          width: MediaQuery.of(context).size.width * 0.4,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
      ],
    );
  }
}
