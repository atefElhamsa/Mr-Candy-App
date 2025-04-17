import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mr_candy/core/utils/app_colors.dart';

class FailureWidget extends StatelessWidget {
  const FailureWidget({super.key, required this.errorMessage, this.onPressed});
  final String errorMessage;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          errorMessage,
          style: GoogleFonts.cairo(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.red,
          ),
        ),
        MaterialButton(
          onPressed: onPressed,
          child: Text("retry".tr()),
        ),
      ],
    );
  }
}
