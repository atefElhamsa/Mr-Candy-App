import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/app_colors.dart';

class CustomSettingTitle extends StatelessWidget {
  const CustomSettingTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == "ar";
    return Padding(
      padding: isArabic
          ? const EdgeInsets.only(left: 6, right: 17)
          : const EdgeInsets.only(left: 17, right: 6),
      child: Align(
        alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
        child: Text(
          title,
          softWrap: true,
          textAlign: TextAlign.right,
          overflow: TextOverflow.visible,
          style: GoogleFonts.almarai(
            color: AppColors.categories,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
