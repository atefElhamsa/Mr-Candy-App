import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class CustomAwesomeDialog {
  showCustomDialog({
    required context,
    required String title,
    required String desc,
    required void Function() btnOkOnPress,
  }) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      title: title.tr(),
      titleTextStyle: GoogleFonts.cairo(
        color: AppColors.red,
        fontWeight: FontWeight.w700,
        fontSize: 20.h,
      ),
      desc: desc.tr(),
      descTextStyle: GoogleFonts.cairo(
        color: AppColors.grey,
        fontWeight: FontWeight.w700,
        fontSize: 17.h,
      ),
      btnCancelText: "no".tr(),
      btnOkText: "yes".tr(),
      btnCancelColor: AppColors.green,
      btnOkColor: AppColors.red,
      btnCancelOnPress: () {
        // Navigator.pop(context);
      },
      btnOkOnPress: btnOkOnPress,
    ).show();
  }
}
