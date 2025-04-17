import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_candy/core/utils/app_colors.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == "ar";
    return Directionality(
      textDirection: isArabic ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.navBar1,
              AppColors.navBar,
            ],
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(
              30.r,
            ),
            bottomRight: Radius.circular(
              30.r,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 50.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    name,
                    style: GoogleFonts.cairo(
                      color: AppColors.white,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppBarWidgetWithoutBack extends StatelessWidget {
  const AppBarWidgetWithoutBack({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.navBar1, AppColors.navBar],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(
            30.r,
          ),
          bottomRight: Radius.circular(
            30.r,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 50.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  name,
                  style: GoogleFonts.cairo(
                    color: AppColors.white,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
