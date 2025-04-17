import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final String? hintText;
  final bool? obscureText;
  const CustomTextFormField({
    super.key,
    this.keyboardType,
    this.suffixIcon,
    this.controller,
    this.hintText,
    this.obscureText, this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == "ar";
    return TextFormField(
      controller: controller,
      autofocus: false,
      obscureText: obscureText ?? false,
      textDirection: ui.TextDirection.ltr,
      textAlign: isArabic ? TextAlign.right : TextAlign.left,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      style: GoogleFonts.almarai(
        color: AppColors.loginAppbar3,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.iconsFormFieldColor,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.iconsFormFieldColor,
            width: 2.0,
          ),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: GoogleFonts.almarai(
          color: AppColors.iconsFormFieldColor,
        ),
      ),
    );
  }
}
