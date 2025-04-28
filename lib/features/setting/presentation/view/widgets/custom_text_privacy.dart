import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/utils/app_colors.dart';

class CustomTextPrivacy extends StatelessWidget {
  const CustomTextPrivacy({super.key, required this.title, required this.info});
  final String title;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "${title.tr()} : ",
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.w800,
            fontSize: 20.sp,
            color: AppColors.red,
          ),
        ),
        Text(
          info,
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.w800,
            fontSize: 20.sp,
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }
}
