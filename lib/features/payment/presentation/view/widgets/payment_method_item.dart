import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mr_candy/core/utils/app_colors.dart';

class PaymentMethodItem extends StatelessWidget {
  const PaymentMethodItem({
    super.key,
    required this.isActive,
    required this.image,
  });
  final bool isActive;
  final String image;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 100.w,
      height: 100.h,
      decoration: ShapeDecoration(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.sp),
          side: BorderSide(
            width: 2,
            color: isActive ? AppColors.loginAppbar3 : AppColors.grey,
          ),
        ),
        shadows: [
          BoxShadow(
            color: isActive ? AppColors.loginAppbar3 : AppColors.white,
            blurRadius: 4,
            offset: const Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Container(
        height: 24,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.sp),
        ),
        child: Image.asset(
          image,
          fit: BoxFit.scaleDown,
          height: 24.h,
        ),
      ),
    );
  }
}
