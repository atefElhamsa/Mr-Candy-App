import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/app_colors.dart';

class CustomSettingTitle extends StatelessWidget {
  const CustomSettingTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6),
      child: Align(
        alignment: Alignment.centerRight,
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
