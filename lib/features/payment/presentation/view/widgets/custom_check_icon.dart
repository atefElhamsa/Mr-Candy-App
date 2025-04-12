import 'package:flutter/material.dart';
import 'package:mr_candy/core/utils/app_colors.dart';

class CustomCheckIcon extends StatelessWidget {
  const CustomCheckIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 50,
      backgroundColor: AppColors.loginAppbar3,
      child: CircleAvatar(
        radius: 40,
        backgroundColor: AppColors.green,
        child: Icon(
          Icons.check,
          size: 42,
          color: AppColors.white,
        ),
      ),
    );
  }
}
